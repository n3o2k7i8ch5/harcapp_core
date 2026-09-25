import 'package:harcapp_core/song_book/contrib_reply.dart';
import 'package:piosenkomat/classify.dart';
import 'package:piosenkomat/model.dart';
import 'package:piosenkomat/plan.dart';
import 'package:piosenkomat/similarity.dart';
import 'package:test/test.dart';

import 'helpers.dart';

ContribMessage reply(String id, String body, {required String from, required DateTime at}) =>
    ContribMessage(
      id: id,
      threadId: 't',
      body: body,
      subject: 'Re: Poprawka piosenki „Poezja”',
      from: from,
      date: at,
    );

const _author = 'Filip Piela <filip.piela0209@gmail.com>';

void main() {
  group('rozmowa w wątku:', () {

    test('wiadomości osobno, po stronach i po dacie', () async {
      // Wątek jak z prawdziwej skrzynki: zgłoszenie, Twoja odpowiedź, jego
      // odpowiedź, a na końcu **nowe** zgłoszenie z apki (reprezentant).
      final first = msgFrom(
        await completeEmail(userMessage: 'Prośba o edycję piosenki „Poezja”.'),
        id: 'm1',
      );
      final last = msgFrom(
        await completeEmail(userMessage: 'Jasne, może byc tak?'),
        id: 'm4',
      );

      final sub = buildSubmission([
        ContribMessage(
          id: first.id, threadId: 't', body: first.body, subject: first.subject,
          from: _author, date: DateTime.utc(2026, 6, 17),
          songAttachment: first.songAttachment, submissionAttachment: first.submissionAttachment,
        ),
        reply('m2', 'Oryginalnej piosenki niestety nie mogę w ten sposób zmienić.',
            from: 'Harc App <$kInboxEmail>', at: DateTime.utc(2026, 6, 28, 15, 51)),
        reply('m3', 'Jasne, czyli rozumiem, że możemy dodać to samo?',
            from: _author, at: DateTime.utc(2026, 6, 28, 17, 54)),
        ContribMessage(
          id: last.id, threadId: 't', body: last.body, subject: last.subject,
          from: _author, date: DateTime.utc(2026, 6, 28, 19, 27),
          songAttachment: last.songAttachment, submissionAttachment: last.submissionAttachment,
        ),
      ], book: SongBook.empty);

      expect(sub.conversation.map((m) => m.text), [
        'Prośba o edycję piosenki „Poezja”.',
        'Oryginalnej piosenki niestety nie mogę w ten sposób zmienić.',
        'Jasne, czyli rozumiem, że możemy dodać to samo?',
        'Jasne, może byc tak?',
      ]);
      expect(sub.conversation.map((m) => m.isOurs), [false, true, false, false]);
      expect(sub.conversation.first.at, DateTime.utc(2026, 6, 17));

      // Do uwagi `has-user-message` liczy się tylko to, co napisał autor.
      expect(sub.userMessage, isNot(contains('nie mogę w ten sposób zmienić')));
      expect(sub.hasUserMessage, isTrue);
    });

    test('kod piosenki z niecytowanej odpowiedzi nie wchodzi do wiadomości', () {
      final sub = buildSubmission([
        ContribMessage(
          id: 'm1', threadId: 't', body: 'Zgłoszenie', from: _author,
          date: DateTime.utc(2026, 6, 1),
        ),
        // Klient pocztowy wkleił kawałek szablonu bez znaków cytatu. Gdyby
        // wkleił też kod piosenki, wiadomość byłaby **nowym zgłoszeniem**
        // i trafiła w inną ścieżkę — tu chodzi o zwykłą odpowiedź.
        reply(
            'm2',
            'Dopisuję autorów.\n\n'
            '- - - - - - Zasady dodawania piosenek - - - - - -\n\n'
            'Znam i akceptuję zasady dodawania piosenek do aplikacji HarcApp (v05.10.2025).',
            from: _author,
            at: DateTime.utc(2026, 6, 2)),
      ], book: SongBook.empty);

      expect(sub.conversation.map((m) => m.text), contains('Dopisuję autorów.'));
      expect(sub.conversation.map((m) => m.text).join(), isNot(contains('Znam i akceptuję')));
    });

    test('po reopen: nasza odpowiedź w rozmowie, bez ramki — ale nie w etykietach', () async {
      final v1 = msgFrom(await completeEmail(userMessage: 'Pierwsza wersja.'), id: 'm1');
      final v2 = msgFrom(await completeEmail(userMessage: 'Poprawione, z chwytami.'), id: 'm3');
      ContribMessage inThread(ContribMessage m, DateTime at) => ContribMessage(
            id: m.id, threadId: 't', body: m.body, subject: m.subject,
            from: _author, date: at,
            songAttachment: m.songAttachment, submissionAttachment: m.submissionAttachment,
          );
      final out = classifyBatch([
        inThread(v1, DateTime.utc(2026, 9, 1)),
        // Tak wychodzi z `reply`: z ramką. W kolejce jej nie ma — `scan`
        // dociąga ją z wątku.
        reply('m2', composeContribReply(reviewNote: 'Brakuje chwytów.', oldApp: true)!,
            from: 'Harc App <$kInboxEmail>', at: DateTime.utc(2026, 9, 2)),
        inThread(v2, DateTime.utc(2026, 9, 3)),
      ], book: SongBook.empty);
      final c = out.single;

      expect(c.submission.message.id, 'm3', reason: 'reprezentantem jest nowsza wersja autora');
      expect(c.submission.conversation.map((m) => (m.text, m.isOurs)), [
        ('Pierwsza wersja.', false),
        ('Brakuje chwytów.', true),
        ('Poprawione, z chwytami.', false),
      ]);
      // Na naszym wysłanym mejlu etykiet nie wieszamy.
      expect(c.submission.messages.map((m) => m.id), ['m1', 'm3']);
      expect(RunPlan.fromClassified(out).labelsByMessage.keys, unorderedEquals(['m1', 'm3']));
    });

    test('nasza odpowiedź pisana ręcznie w Gmailu: bez cytatu, reszta cała', () {
      final sub = buildSubmission([
        ContribMessage(
          id: 'm1', threadId: 't', body: 'Zgłoszenie', from: _author,
          date: DateTime.utc(2026, 6, 1),
        ),
        reply('m2', 'Hej, dorzuć proszę chwyty.\n\nW dniu 1 czerwca Filip napisał:\n> Zgłoszenie',
            from: 'Harc App <$kInboxEmail>', at: DateTime.utc(2026, 6, 2)),
      ], book: SongBook.empty);
      expect(sub.conversation.where((m) => m.isOurs).single.text, 'Hej, dorzuć proszę chwyty.');
    });

    test('ślad w piosence niesie rozmowę, nie zlepek', () async {
      final got = classify(
        msgFrom(await completeEmail(userMessage: 'hej')),
        book: SongBook.empty,
      );
      final data = got.piosenkomatData();
      expect(data.conversation.map((m) => m.text), ['hej']);
      expect(data.userMessage, 'hej');
    });

  });
}
