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
    expect(stateLabelsFor(classifiedWith([SongIssue.missingChords])).first, kLabelNeedsReview);
    expect(stateLabelsFor(classifiedWith([])).first, kLabelReadyToAdd);
    expect(stateLabelsFor(classifiedWith([], destination: Destination.rejectAlreadyInApp)).first,
        kLabelRejectedAlreadyInApp);
    expect(stateLabelsFor(classifiedWith([], destination: Destination.rejectDuplicate)).first,
        kLabelRejectedDuplicate);
    expect(stateLabelsFor(classifiedWith([SongIssue.corruptedSubmissionFile], destination: Destination.rejectCorruptedFile)),
        [kLabelRejectedCorruptedFile]);
    expect(stateLabelsFor(classifiedWith([SongIssue.unknownSubmissionFormat], destination: Destination.rejectCorruptedFile)),
        [kLabelRejectedUnknownFormat]);
    expect(stateLabelsFor(classifiedWith([], destination: Destination.unparsable)), [kLabelRejectedUnparsable]);
    expect(
      stateLabelsFor(classifiedWith(
          [SongIssue.missingYoutube, SongIssue.missingTitle, SongIssue.hasUserMessage])),
      [kLabelNeedsReview, NeedsReviewKind.missingData.label, NeedsReviewKind.userMessage.label],
    );
    expect(stateLabelsFor(classifiedWith([SongIssue.similarTextInApp, SongIssue.sameTargetInBatch])),
        [kLabelNeedsReview, NeedsReviewKind.duplicateInApp.label, NeedsReviewKind.duplicateInBatch.label]);
    expect(stateLabelsFor(classifiedWith([SongIssue.chordsDifferFromApp])),
        [kLabelNeedsReview, NeedsReviewKind.undeclaredCorrection.label]);
    // Znaczniki.
    expect(classifiedWith([], kind: SubmissionKind.correction).labels,
        [kLabelReadyToAdd, kLabelCorrection]);
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
    // Nie łapie: cokolwiek już otagowanego.
    for (final etykieta in [
      kLabelAuto, kLabelReadyToAdd, kLabelAdded, kLabelRejectedUnparsable, kLabelCorrection,
      kLabelReplyOldApp, NeedsReviewKind.duplicateInApp.label, 'song/rejected/too-niche',
    ]) {
      expect(kQueueQuery, contains('-label:${labelQueryName(etykieta)}'));
    }

    expect(isReadyByTool({kLabelReadyToAdd, kLabelAuto}), isTrue);
    expect(isReadyByTool({kLabelReadyToAdd}), isFalse);
  });

  test('przeczytane tylko przy werdykcie domykającym', () {
    expect(isClosedLabel(kLabelAdded), isTrue);
    expect(isClosedLabel(kLabelRejectedAlreadyInApp), isTrue);
    expect(isClosedLabel(kLabelRejectedDuplicate), isTrue);
    expect(isClosedLabel(kLabelRejectedAfterReview), isTrue);
    expect(isClosedLabel('song/rejected/silly'), isTrue);

    expect(isClosedLabel(kLabelNeedsReview), isFalse);
    expect(isClosedLabel(kLabelRejectedUnparsable), isTrue,
        reason: 'odrzut; zobaczyć masz go po `have-a-look`');
    expect(isClosedLabel(NeedsReviewKind.missingData.label), isFalse);
    expect(isClosedLabel(kLabelRejectedCorruptedFile), isTrue);
    expect(isClosedLabel(kLabelHaveALook), isFalse,
        reason: 'znacznik, nie werdykt');
    expect(isClosedLabel(kLabelReplyOldApp), isFalse);
    expect(isClosedLabel(kLabelReplyReviewNote), isFalse);
    expect(isClosedLabel(kLabelWaitingForAuthor), isFalse,
        reason: 'czekanie na autora nie jest werdyktem — przeczytane zdejmuje `reply`');
    expect(isClosedLabel(kLabelReadyToAdd), isFalse);
    expect(isClosedLabel(kLabelAuto), isFalse);

  });

  test('po tekście z przeglądu mejl jest przeczytany i czeka na autora', () {
    final (add, remove) = labelsAfterReply(sentReviewNote: true);
    expect(add, [kLabelWaitingForAuthor]);
    expect(remove, [kLabelReplyOldApp, kLabelReplyReviewNote, 'UNREAD']);

    // Sam blok o starej apce: piosenka może wciąż czekać na przegląd,
    // a `reply/review-note` bez wysłanego tekstu to sprawa, która nie poszła.
    final onlyOld = labelsAfterReply(sentReviewNote: false);
    expect(onlyOld.$1, isEmpty, reason: 'o odpowiedzi mówi sam wątek (SENT)');
    expect(onlyOld.$2, [kLabelReplyOldApp]);
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
