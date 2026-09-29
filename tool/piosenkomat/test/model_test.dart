import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:harcapp_core/song_book/submission/submission_file.dart';
import 'package:piosenkomat/eml.dart';
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
    expect(stateLabelsFor(classifiedWith([SongIssue.missingChords])).first, SongLabel.needsReview.label);
    expect(stateLabelsFor(classifiedWith([])).first, SongLabel.readyToAdd.label);
    expect(stateLabelsFor(classifiedWith([], destination: Destination.rejectAlreadyInApp)).first,
        SongLabel.rejectedAlreadyInApp.label);
    expect(stateLabelsFor(classifiedWith([], destination: Destination.rejectDuplicate)).first,
        SongLabel.rejectedDuplicate.label);
    expect(stateLabelsFor(classifiedWith([], destination: Destination.rejectCorruptedFile)),
        [SongLabel.rejectedCorruptedFile.label]);
    expect(stateLabelsFor(classifiedWith([], destination: Destination.rejectUnknownFormat)),
        [SongLabel.rejectedUnknownFormat.label]);
    expect(stateLabelsFor(classifiedWith([], destination: Destination.rejectUnparsable)), [SongLabel.rejectedUnparsable.label]);
    expect(
      stateLabelsFor(classifiedWith(
          [SongIssue.missingYoutube, SongIssue.missingTitle, SongIssue.userMessage])),
      [SongLabel.needsReview.label, SongLabel.missingData.label, SongLabel.userMessage.label],
    );
    expect(stateLabelsFor(classifiedWith([SongIssue.similarTextInApp, SongIssue.sameTargetInBatch])),
        [SongLabel.needsReview.label, SongLabel.duplicateInApp.label, SongLabel.duplicateInBatch.label]);
    expect(stateLabelsFor(classifiedWith([SongIssue.chordsDifferFromApp])),
        [SongLabel.needsReview.label, SongLabel.undeclaredCorrection.label]);
    // Znaczniki.
    expect(classifiedWith([], kind: SubmissionKind.correction).labels,
        [SongLabel.readyToAdd.label, SongLabel.correction.label]);
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
      SongLabel.auto.label, SongLabel.readyToAdd.label, SongLabel.added.label, SongLabel.rejectedUnparsable.label, SongLabel.correction.label,
      SongLabel.replyOldApp.label, SongLabel.duplicateInApp.label, 'song/rejected/too-niche',
    ]) {
      expect(kQueueQuery, contains('-label:${labelQueryName(etykieta)}'));
    }

    expect(hasToolLabel({SongLabel.readyToAdd.label, SongLabel.auto.label}, SongLabel.readyToAdd), isTrue);
    expect(hasToolLabel({SongLabel.readyToAdd.label}, SongLabel.readyToAdd), isFalse);
  });

  test('przeczytane tylko przy werdykcie domykającym', () {
    expect(isClosedLabel(SongLabel.added.label), isTrue);
    expect(isClosedLabel(SongLabel.rejectedAlreadyInApp.label), isTrue);
    expect(isClosedLabel(SongLabel.rejectedDuplicate.label), isTrue);
    expect(isClosedLabel(SongLabel.rejectedAfterReview.label), isTrue);
    expect(isClosedLabel('song/rejected/silly'), isTrue);

    expect(isClosedLabel(SongLabel.needsReview.label), isFalse);
    expect(isClosedLabel(SongLabel.rejectedUnparsable.label), isTrue,
        reason: 'odrzut; zobaczyć masz go po `have-a-look`');
    expect(isClosedLabel(SongLabel.missingData.label), isFalse);
    expect(isClosedLabel(SongLabel.rejectedCorruptedFile.label), isTrue);
    expect(isClosedLabel(SongLabel.haveALook.label), isFalse,
        reason: 'znacznik, nie werdykt');
    expect(isClosedLabel(SongLabel.replyOldApp.label), isFalse);
    expect(isClosedLabel(SongLabel.replyReviewNote.label), isFalse);
    expect(isClosedLabel(SongLabel.waitingForAuthor.label), isFalse,
        reason: 'czekanie na autora nie jest werdyktem — przeczytane zdejmuje `reply`');
    expect(isClosedLabel(SongLabel.readyToAdd.label), isFalse);
    expect(isClosedLabel(SongLabel.auto.label), isFalse);

  });

  test('po tekście z przeglądu mejl jest przeczytany i czeka na autora', () {
    final (add, remove) = labelsAfterReply(sentReviewNote: true);
    expect(add, [SongLabel.waitingForAuthor.label]);
    expect(remove, [SongLabel.replyOldApp.label, SongLabel.replyReviewNote.label, 'UNREAD']);

    // Sam blok o starej apce: piosenka może wciąż czekać na przegląd,
    // a `reply/review-note` bez wysłanego tekstu to sprawa, która nie poszła.
    final onlyOld = labelsAfterReply(sentReviewNote: false);
    expect(onlyOld.$1, isEmpty, reason: 'o odpowiedzi mówi sam wątek (SENT)');
    expect(onlyOld.$2, [SongLabel.replyOldApp.label]);
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
