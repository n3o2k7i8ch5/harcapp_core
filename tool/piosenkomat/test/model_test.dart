import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:harcapp_core/song_book/submission/submission_file.dart';
import 'package:piosenkomat/model.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
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

  test('stateLabelsFor: po decyzji, nie po uwagach', () {
    expect(stateLabelFor(classifiedWith([SongIssue.missingChords])), kLabelToReview);
    expect(stateLabelFor(classifiedWith([])), kLabelReady);
    expect(stateLabelFor(classifiedWith([], target: Target.rejectAlreadyInApp)),
        kLabelRejectedInBook);
    expect(stateLabelFor(classifiedWith([], target: Target.rejectDuplicate)),
        kLabelRejectedDuplicate);
    expect(stateLabelsFor(classifiedWith([], target: Target.mailOnlyIdentical, userMessage: true)),
        [kLabelToReview, ReviewKind.identicalInApp.label, ReviewKind.userMessage.label]);
    expect(stateLabelsFor(classifiedWith([], target: Target.unparsable)), [kLabelUnparsable]);
    expect(
      stateLabelsFor(classifiedWith(
          [SongIssue.missingYoutube, SongIssue.missingTitle, SongIssue.hasUserMessage])),
      [kLabelToReview, ReviewKind.missingData.label, ReviewKind.userMessage.label],
    );
    expect(stateLabelsFor(classifiedWith([SongIssue.similarTextInApp, SongIssue.sameTargetInBatch])),
        [kLabelToReview, ReviewKind.duplicateInApp.label, ReviewKind.duplicateInBatch.label]);
    expect(stateLabelsFor(classifiedWith([SongIssue.chordsDifferFromApp])),
        [kLabelToReview, ReviewKind.undeclaredCorrection.label]);
    // Znaczniki.
    expect(classifiedWith([], kind: SubmissionKind.correction).labels,
        [kLabelReady, kLabelCorrection]);
  });

  test('kolejka: co łapie, czego nie', () {
    expect(kQueueQuery, startsWith('in:inbox (subject:'));
    // Łapie: stare kształty po temacie i treści, nowy po znaczniku albo
    // rozszerzeniu załącznika — temat jest edytowalny, więc jeden sygnał mało.
    for (final czlon in [
      'subject:"Nowa piosenka" OR subject:"Poprawka piosenki"',
      '"### Kod piosenki:"',
      kOldAppMarker,
      'subject:"hrcpsng/app"',
      'filename:$kSubmissionFileExtension',
    ]) {
      expect(kQueueQuery, contains(czlon));
    }
    // Nie łapie: cokolwiek już otagowanego — poza znacznikiem o nadawcy.
    for (final etykieta in [
      kLabelAuto, kLabelReady, kLabelDone, kLabelUnparsable, kLabelCorrection,
      kLabelOldAppToReply, ReviewKind.duplicateInApp.label, 'song/rejected/too-niche',
    ]) {
      expect(kQueueQuery, contains('-label:${labelQueryName(etykieta)}'));
    }
    expect(kQueueQuery, isNot(contains(labelQueryName(kLabelOldAppReplied))));

    expect(isReadyByTool({kLabelReady, kLabelAuto}), isTrue);
    expect(isReadyByTool({kLabelReady}), isFalse);
  });

  test('przeczytane tylko przy werdykcie domykającym', () {
    expect(isClosedLabel(kLabelDone), isTrue);
    expect(isClosedLabel(kLabelRejectedInBook), isTrue);
    expect(isClosedLabel(kLabelRejectedDuplicate), isTrue);
    expect(isClosedLabel(kLabelRejectedAfterReview), isTrue);
    expect(isClosedLabel('song/rejected/silly'), isTrue);

    expect(isClosedLabel(kLabelToReview), isFalse);
    expect(isClosedLabel(kLabelUnparsable), isFalse,
        reason: 'niesparsowalne masz zobaczyć w skrzynce');
    expect(isClosedLabel(ReviewKind.missingData.label), isFalse);
    expect(isClosedLabel(ReviewKind.identicalInApp.label), isFalse,
        reason: 'to nie odrzut — piosenki nie ma w pliku, ale etykieta zostaje');
    expect(isClosedLabel(kLabelOldAppToReply), isFalse);
    expect(isClosedLabel(kLabelContributorToAsk), isFalse);
    expect(isClosedLabel(kLabelContributorAsked), isFalse,
        reason: 'asked nie jest werdyktem — przeczytane zdejmuje `reply`');
    expect(isClosedLabel(kLabelReady), isFalse);
    expect(isClosedLabel(kLabelAuto), isFalse);

    expect(clearsUnread(kLabelDone), isTrue);
    expect(clearsUnread(kLabelRejectedInBook), isTrue);
    expect(clearsUnread(ReviewKind.identicalInApp.label), isTrue,
        reason: 'piosenki nie ma w pliku — po etykietach nie wisi w nieprzeczytanych');
    expect(clearsUnread(kLabelToReview), isFalse);
    expect(clearsUnread(ReviewKind.missingData.label), isFalse);
  });

  test('po odpowiedzi do osoby dodającej mejl jest przeczytany', () {
    final (add, remove) =
        labelsAfterReply(oldApp: false, askedContributor: true);
    expect(add, [kLabelContributorAsked]);
    expect(remove, [
      kLabelOldAppToReply,
      kLabelContributorToAsk,
      kLabelOldAppDrafted,
      'UNREAD',
    ]);

    // Sama stara apka: piosenka może wciąż czekać na przegląd.
    final onlyOld = labelsAfterReply(oldApp: true, askedContributor: false);
    expect(onlyOld.$1, [kLabelOldAppReplied]);
    expect(onlyOld.$2, isNot(contains('UNREAD')));

    // Obie sprawy w jednym mejlu: pytanie poszło, nieprzeczytane schodzi.
    final both = labelsAfterReply(oldApp: true, askedContributor: true);
    expect(both.$1, [kLabelOldAppReplied, kLabelContributorAsked]);
    expect(both.$2, contains('UNREAD'));
  });

  test('isSongSubmission: po temacie albo znaczniku w treści', () {
    expect(const ContribMessage(id: 'a', body: 'x', subject: 'Nowa piosenka "Y"').isSongSubmission, isTrue);
    expect(const ContribMessage(id: 'b', body: 'bla\n### Kod piosenki:\n{}').isSongSubmission, isTrue);
    expect(const ContribMessage(id: 'c', body: 'x', subject: 'Re: grupa FB').isSongSubmission, isFalse);
  });

  test('hasOwnSongCode: cytat to nie własny kod', () {
    expect(const ContribMessage(id: 'a', body: 'Dzięki!\n> ### Kod piosenki:\n> {}').hasOwnSongCode, isFalse);
    expect(const ContribMessage(id: 'b', body: '### Kod piosenki:\n{}').hasOwnSongCode, isTrue);
    expect(const ContribMessage(id: 'c', body: 'x', songAttachment: '{}').hasOwnSongCode, isTrue);
  });
}
