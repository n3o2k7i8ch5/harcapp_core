import 'package:piosenkomat/cli.dart';
import 'package:piosenkomat/model.dart';
import 'package:piosenkomat/reply.dart';
import 'package:test/test.dart';

import 'fake_mailbox.dart';

const _query = '(label:song/reply/old-app OR label:song/reply/review-note)';

/// Wątek `t1` od autora czekający na tekst z przeglądu.
FakeMailbox _waitingForNote() => FakeMailbox()
  ..add(FakeMail('m1', 't1', labels: {
    SongLabel.auto.label,
    SongLabel.readyToAdd.label,
    SongLabel.replyReviewNote.label,
  }));

Future<ReplyRun> _run(FakeMailbox mailbox, {Map<String, String> notes = const {'t1': 'Dorzuć chwyty.'}}) async {
  final ids = await mailbox.listIds(_query);
  final queue = await groupBySender(mailbox, ids, query: _query, limit: null, inScope: (_) => true);
  final oldAppIds = (await mailbox.listIds('label:${labelQueryName(SongLabel.replyOldApp.label)}')).toSet();
  return ReplyRun(
    mailbox: mailbox,
    queue: queue,
    plans: {
      for (final sender in queue.senders)
        sender: planAuthorReplies(
          sender,
          [for (final id in queue.bySender[sender]!) (id: id, threadId: queue.replyTargetById[id]!.threadId)],
          reviewNotes: notes,
          oldAppIds: oldAppIds,
        ),
    },
    draftIdByThread: await mailbox.draftIdByThread(),
  );
}

void main() {
  group('ReplyRun.sendAll', () {
    test('wysyła tekst z przeglądu i przestawia etykiety na „czeka na autora”', () async {
      final mailbox = _waitingForNote();
      await (await _run(mailbox)).sendAll();
      expect(mailbox.sentTexts.single.text, contains('Dorzuć chwyty.'));
      expect(mailbox.sentTexts.single.threadId, 't1');
      final labels = mailbox.mails.first.labels;
      expect(labels, contains(SongLabel.waitingForAuthor.label));
      expect(labels, isNot(contains(SongLabel.replyReviewNote.label)));
    });

    test('szkic w wątku idzie w świat zamiast składania mejla od nowa', () async {
      final mailbox = _waitingForNote();
      mailbox.drafts['d1'] = (threadId: 't1', body: 'Poprawione ręcznie.');
      await (await _run(mailbox)).sendAll();
      expect(mailbox.sentTexts.map((s) => s.text), ['Poprawione ręcznie.']);
      expect(mailbox.drafts, isEmpty);
    });

    test('ostatnie słowo nasze, szkicu brak: odpisane ręcznie, drugiego mejla nie ma', () async {
      final mailbox = _waitingForNote()..add(FakeMail('s1', 't1', from: kInboxEmail, sent: true));
      await (await _run(mailbox)).sendAll();
      expect(mailbox.sentTexts, isEmpty);
      expect(mailbox.mails.first.labels, contains(SongLabel.waitingForAuthor.label));
    });

    test('blok o starej apce schodzi też z pozostałych wątków autora', () async {
      final mailbox = FakeMailbox()
        ..add(FakeMail('a', 'ta', labels: {SongLabel.replyOldApp.label}))
        ..add(FakeMail('b', 'tb', labels: {SongLabel.replyOldApp.label}));
      await (await _run(mailbox, notes: const {})).sendAll();
      expect(mailbox.sentTexts, hasLength(1), reason: 'jeden mejl z samym blokiem na autora');
      expect(mailbox.mails.where((m) => m.labels.contains(SongLabel.replyOldApp.label)), isEmpty);
    });
  });

  group('ReplyRun.draftAll / undraftAll', () {
    test('szkic powstaje, drugi --draft go nie dubluje', () async {
      final mailbox = _waitingForNote();
      await (await _run(mailbox)).draftAll();
      expect(mailbox.drafts.values.single.body, contains('Dorzuć chwyty.'));
      await (await _run(mailbox)).draftAll();
      expect(mailbox.drafts, hasLength(1));
      expect(mailbox.mails.first.labels, contains(SongLabel.replyReviewNote.label),
          reason: 'szkic to nie wysyłka — kolejka zostaje');
    });

    test('szkic w naszym kształcie przelicza się po zmianie tekstu', () async {
      final mailbox = _waitingForNote();
      await (await _run(mailbox)).draftAll();
      await (await _run(mailbox, notes: const {'t1': 'Dorzuć YouTube.'})).draftAll();
      expect(mailbox.drafts.values.single.body, contains('Dorzuć YouTube.'));
    });

    test('szkic ruszony ręcznie zostaje', () async {
      final mailbox = _waitingForNote();
      mailbox.drafts['d1'] = (threadId: 't1', body: 'Moja własna odpowiedź');
      await (await _run(mailbox)).draftAll();
      expect(mailbox.drafts['d1']!.body, 'Moja własna odpowiedź');
    });

    test('--undraft kasuje szkice i nic nie wysyła', () async {
      final mailbox = _waitingForNote();
      await (await _run(mailbox)).draftAll();
      await (await _run(mailbox)).undraftAll(mailbox.drafts.keys.toSet());
      expect(mailbox.drafts, isEmpty);
      expect(mailbox.sentTexts, isEmpty);
    });
  });

  group('reopen', () {
    FakeMailbox waiting({bool authorReplied = true, bool added = false}) => FakeMailbox()
      ..add(FakeMail('m1', 't1', labels: {
        SongLabel.auto.label,
        SongLabel.waitingForAuthor.label,
        if (added) SongLabel.added.label,
      }))
      ..add(FakeMail('s1', 't1', from: kInboxEmail, sent: true))
      ..add(authorReplied ? FakeMail('m2', 't1', body: 'Chwyty: a d e') : FakeMail('s2', 't1', sent: true));

    test('autor odpisał → z --push wątek wraca do kolejki bez żadnej song/*', () async {
      final mailbox = waiting();
      expect(await runPiosenkomat(['reopen', '--push'], connect: (_) async => mailbox), 0);
      expect(mailbox.mails.expand((m) => m.labels).where(isSongLabel), isEmpty);
    });

    test('bez --push nic się nie zmienia', () async {
      final mailbox = waiting();
      expect(await runPiosenkomat(['reopen'], connect: (_) async => mailbox), 0);
      expect(mailbox.mails.first.labels, contains(SongLabel.waitingForAuthor.label));
    });

    test('ostatnie słowo nasze → czeka dalej', () async {
      final mailbox = waiting(authorReplied: false);
      await runPiosenkomat(['reopen', '--push'], connect: (_) async => mailbox);
      expect(mailbox.mails.first.labels, contains(SongLabel.waitingForAuthor.label));
    });

    test('piosenka już w apce → odpowiedź to nie nowe zgłoszenie', () async {
      final mailbox = waiting(added: true);
      await runPiosenkomat(['reopen', '--push'], connect: (_) async => mailbox);
      expect(mailbox.mails.first.labels, contains(SongLabel.added.label));
    });
  });

  test('zbędny argument to błąd użycia, nie cicha „cała kolejka”', () async {
    expect(await runPiosenkomat(['scan', '20'], connect: (_) async => FakeMailbox()), 64);
    expect(await runPiosenkomat(['nieznana']), 64);
    expect(await runPiosenkomat(['label']), 64);
  });
}
