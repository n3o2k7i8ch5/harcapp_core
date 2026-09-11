import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:piosenkomat/similarity.dart';
import 'package:piosenkomat/classify.dart';
import 'package:piosenkomat/model.dart';
import 'dart:convert';

import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  _labels();
  _submission();
  test('kompletna nowa piosenka → do apki, ze zgodą, datą i nadawcą', () async {
    final got = classify(msgFrom(await completeEmail()), book: SongBook.empty);
    final song = got.song!;
    expect(got.goesToApp, isTrue);
    expect(got.issues, isEmpty);
    expect(got.sender, 'jan.testowy@example.com');
    expect(got.title, 'Piosenka testowa XYZ');
    expect(song.contributorData!.acceptedContributionRulesVersion, 'v05.10.2025');
    expect(song.contributorData!.email, 'jan.testowy@example.com');
    expect(song.contributorData!.contributionDate,
        DateTime.parse('2026-09-06T12:00:00+02:00'));
    expect(song.id, startsWith('o!_'));
    expect(song.contribRefs.any((c) => c.emailRef == 'jan.testowy@example.com'), isTrue);
    expect(song.piosenkomatData?.emailMsgId, got.message.id,
        reason: 'po tym przegląd wiąże piosenkę ze zgłoszeniem');
  });

  group('do przeglądu:', () {
    Future<void> expectReview(String raw, SongIssue issue, {SongBook? book}) async {
      final got = classify(msgFrom(raw), book: book ?? SongBook.empty);
      expect(issuesOf(got), contains(issue), reason: raw.split('\n').first);
      expect(got.goesToApp, isFalse);
    }

    test('poprawka', () async =>
        expectReview(await completeEmail(isNew: false), SongIssue.correction));
    test('własna wiadomość', () async => expectReview(
        await completeEmail(userMessage: 'Czy możecie dodać transpozycję?'),
        SongIssue.hasUserMessage));
    test('brak YouTube', () async => expectReview(
        await completeEmail(song: sampleSong(yt: null)), SongIssue.missingYoutube));
    test('brak chwytów', () async => expectReview(
        await completeEmail(song: sampleSong(chords: false)), SongIssue.missingChords));
    test('brak zgody', () async => expectReview(
        await completeEmail(withConsent: false), SongIssue.noConsent));
    test('nadawca = skrzynka HarcApp', () async => expectReview(
        await completeEmail(from: 'HarcApp <harcapp@gmail.com>'),
        SongIssue.noContributorEmail));
    test('tytuł już w apce', () async => expectReview(
        await completeEmail(),
        SongIssue.identicalInApp,
        book: bookWith([sampleSong()])));
    test('nie da się sparsować', () {
      final got = classify(
        ContribMessage(id: 'x', body: 'Cześć, mam pytanie', subject: 'Cześć'),
        book: SongBook.empty,
      );
      expect(issuesOf(got), contains(SongIssue.parseError));
      expect(got.song, isNull, reason: 'nie ma czego wstawić do pliku');
      expect(got.title, 'Cześć');
    });
  });

  test('odpowiedź: adnotacja, nie blokada', () async {
    final got = classify(msgFrom(await completeEmail(reply: true)), book: SongBook.empty);
    expect(issuesOf(got), [SongIssue.reply]);
    expect(got.goesToApp, isTrue,
        reason: 'powtórkę złapią duplikaty, a nowa piosenka nie ma za co odpaść');
    expect(got.labels, [kLabelReady]);
  });


  test('stara apka: import plus kolejka odpowiedzi, poprawka dalej łapana', () async {
    final oldApp = ContribMessage(
      id: 'old',
      subject: 'Piosenka "Piosenka testowa XYZ"',
      from: 'Jan <jan.testowy@example.com>',
      body: 'Dzięki za chęć dzielenia się swoimi piosenkami!\n\n'
          '### Kod piosenki:\n\n'
          '${jsonEncode({'o!_x': sampleSong().toApiJsonMap(withId: false)})}\n',
    );
    final got = classify(oldApp, book: SongBook.empty);
    expect(got.goesToApp, isTrue, reason: 'stary format sam w sobie nie blokuje');
    expect(got.labels, [kLabelReady, kLabelOldAppToReply]);

    // Brak chwytów i YouTube blokuje tak samo jak wszędzie indziej.
    final noChords = ContribMessage(
      id: 'old2', subject: oldApp.subject, from: oldApp.from,
      body: oldApp.body.replaceFirst(
          jsonEncode({'o!_x': sampleSong().toApiJsonMap(withId: false)}),
          jsonEncode({'o!_x': sampleSong(chords: false, yt: null).toApiJsonMap(withId: false)})),
    );
    final blocked = classify(noChords, book: SongBook.empty);
    expect(issuesOf(blocked),
        containsAll([SongIssue.missingChords, SongIssue.missingYoutube]));
    expect(blocked.labels, contains(kLabelOldAppToReply),
        reason: 'odrzucona piosenka też wymaga odpowiedzi o aktualizacji');
  });

  test('emailFromHeader', () {
    expect(emailFromHeader('Jan <Jan.K@Example.com>'), 'jan.k@example.com');
    expect(emailFromHeader('jan@example.com'), 'jan@example.com');
    expect(emailFromHeader('HarcApp'), isNull);
    expect(emailFromHeader(null), isNull);
  });

  test('Date: po RFC 2822, jak piszą prawdziwe klienty', () {
    expect(parseMailDate('Thu, 11 Sep 2026 10:00:00 +0200'),
        DateTime.utc(2026, 9, 11, 8, 0, 0));
    expect(parseMailDate('11 Sep 2026 10:00 -0130'), DateTime.utc(2026, 9, 11, 11, 30));
    expect(parseMailDate('2026-09-06T12:00:00+02:00'),
        DateTime.parse('2026-09-06T12:00:00+02:00'));
    expect(parseMailDate('wczoraj'), isNull);
    expect(parseMailDate(null), isNull);
    final m = ContribMessage.fromEml(
        'From: a@b.pl\nDate: Thu, 11 Sep 2026 10:00:00 +0200\n\nx', id: 'x');
    expect(m.date, DateTime.utc(2026, 9, 11, 8));
  });

  test('fromEml: bez nagłówków całość jest treścią', () {
    final m = ContribMessage.fromEml('Ala ma kota\n\nDruga linia', id: 'x');
    expect(m.subject, isNull);
    expect(m.body, 'Ala ma kota\n\nDruga linia');
  });
}

void _labels() {
  test('stateLabelFor: odrzuca sam tylko przy jednoznacznych uwagach', () {
    expect(stateLabelFor(classifiedWith([SongIssue.missingChords])), kLabelToReview);
    expect(stateLabelFor(classifiedWith([SongIssue.identicalInApp])), kLabelRejectedInBook);
    expect(stateLabelFor(classifiedWith([SongIssue.identicalInApp, SongIssue.missingChords])),
        kLabelToReview);
    expect(stateLabelFor(classifiedWith([SongIssue.identicalInApp, SongIssue.correction])),
        kLabelToReview);
    expect(stateLabelFor(classifiedWith([SongIssue.hasUserMessage])), kLabelToReview);
    // Adnotacje nie zmieniają stanu: piosenka dalej idzie do apki.
    expect(stateLabelFor(classifiedWith([SongIssue.reply, SongIssue.oldApp])), kLabelReady);
    expect(stateLabelFor(classifiedWith([SongIssue.identicalInApp, SongIssue.reply])),
        kLabelRejectedInBook);
    expect(kQueueQuery, contains('-label:song/needs-review/duplicate-in-app'));
    expect(kQueueQuery, contains('-label:song/needs-review/duplicate-in-batch'));
    expect(kQueueQuery, contains('-label:song/rejected/duplicate'));
  });

  test('query Gmaila i rozpoznanie „w pliku” z ręki automatu', () {
    expect(kQueueQuery, startsWith('in:inbox (subject:'));
    expect(kQueueQuery, contains(' -label:song/auto '));
    expect(kQueueQuery, contains('-label:song/ready-to-add'));
    expect(kQueueQuery, contains('-label:song/rejected/too-niche'));
    expect(isReadyByTool({kLabelReady, kLabelAuto}), isTrue);
    expect(isReadyByTool({kLabelReady}), isFalse);
  });
}

void _submission() {
  test('isSongSubmission: po temacie albo znaczniku w treści', () {
    expect(const ContribMessage(id: 'a', body: 'x', subject: 'Nowa piosenka "Y"').isSongSubmission, isTrue);
    expect(const ContribMessage(id: 'b', body: 'bla\n### Kod piosenki:\n{}').isSongSubmission, isTrue);
    expect(const ContribMessage(id: 'c', body: 'x', subject: 'Re: grupa FB').isSongSubmission, isFalse);
    expect(kQueueQuery, contains('subject:"Nowa piosenka" OR subject:"Poprawka piosenki" OR "### Kod piosenki:"'));
  });
}
