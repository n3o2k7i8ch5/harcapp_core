import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:piosenkomat/classify.dart';
import 'package:piosenkomat/model.dart';
import 'package:piosenkomat/similarity.dart';
import 'package:test/test.dart';

import 'helpers.dart';

const _a = 'Płonie ognisko i szumią knieje\nDrużynowy jest wśród nas\nOpowiada starodawne dzieje\nBohaterski wskrzesza czas';
const _b = 'Zupełnie inny tekst o morzu\nŻagle na wietrze i sól na wargach\nDaleko od lasu i od ogniska';

void main() {
  group('względem apki:', () {
    test('ten sam tytuł i tekst → already-in-app, automat', () async {
      final book = bookWith([sampleSong(lyrics: _a)]);
      final got = classify(msgFrom(await completeEmail(song: sampleSong(lyrics: '$_a\n'))), book: book);
      expect(issuesOf(got), [SongIssue.identicalInApp]);
      expect(stateLabelsFor(got), [kLabelRejectedInBook]);
    });

    test('ten sam tytuł, inny tekst → przegląd duplicate-in-app', () async {
      final book = bookWith([sampleSong(lyrics: _a)]);
      final got = classify(msgFrom(await completeEmail(song: sampleSong(lyrics: _b))), book: book);
      expect(issuesOf(got), [SongIssue.sameTitleInApp]);
      expect(stateLabelsFor(got), [kLabelToReview, ReviewKind.duplicateInApp.label]);
      expect(detailOf(got, SongIssue.sameTitleInApp), contains('tekst zgodny w'));
    });

    test('inny tytuł, podobny tekst → przegląd z nazwą pierwowzoru', () async {
      final book = bookWith([sampleSong(title: 'Ognisko', lyrics: _a)]);
      final got = classify(
        msgFrom(await completeEmail(song: sampleSong(title: 'Płonie ognisko', lyrics: '$_a\nDodatkowa linijka'))),
        book: book,
      );
      expect(issuesOf(got), [SongIssue.similarTextInApp]);
      expect(detailOf(got, SongIssue.similarTextInApp), contains('„Ognisko”'));
    });

    test('inny tytuł, inny tekst → do apki', () async {
      final book = bookWith([sampleSong(title: 'Ognisko', lyrics: _a)]);
      final got = classify(msgFrom(await completeEmail(song: sampleSong(title: 'Morze', lyrics: _b))), book: book);
      expect(got.goesToApp, isTrue);
    });
  });

  group('w paczce:', () {
    test('identyczna dwa razy → starsza wchodzi, młodsza rejected/duplicate', () async {
      final older = (await completeEmail(song: sampleSong(lyrics: _a)))
          .replaceFirst('Date: 2026-09-06T12:00:00+02:00', 'Date: 2026-09-01T12:00:00+02:00');
      final newer = await completeEmail(song: sampleSong(lyrics: _a));
      final out = classifyBatch([msgFrom(newer, id: 'new'), msgFrom(older, id: 'old')], book: SongBook.empty);
      expect(out[1].goesToApp, isTrue);
      expect(issuesOf(out[0]), [SongIssue.identicalInBatch]);
      expect(stateLabelsFor(out[0]), [kLabelRejectedDuplicate]);
      expect(detailOf(out[0], SongIssue.identicalInBatch), contains('[old]'));
    });

    test('ten sam tytuł, inna treść → oba na przegląd', () async {
      final out = classifyBatch([
        msgFrom(await completeEmail(song: sampleSong(lyrics: _a)), id: 'a'),
        msgFrom(await completeEmail(song: sampleSong(lyrics: _b)), id: 'b'),
      ], book: SongBook.empty);
      expect(out.map((c) => c.goesToApp), [false, false]);
      expect(issuesOf(out[0]), [SongIssue.sameTitleInBatch]);
    });

    test('różne tytuły, podobna treść → oba na przegląd', () async {
      final out = classifyBatch([
        msgFrom(await completeEmail(song: sampleSong(title: 'Ognisko', lyrics: _a)), id: 'a'),
        msgFrom(await completeEmail(song: sampleSong(title: 'Knieje', lyrics: '$_a\nJedna nowa linijka')), id: 'b'),
        msgFrom(await completeEmail(song: sampleSong(title: 'Morze', lyrics: _b)), id: 'c'),
      ], book: SongBook.empty);
      expect(out.map((c) => c.goesToApp), [false, false, true]);
      expect(issuesOf(out[0]), [SongIssue.similarTextInBatch]);
      expect(detailOf(out[0], SongIssue.similarTextInBatch), contains('„Knieje”'));
    });
  });

  test('etykiety przeglądu: jedna na uwagę, bez powtórzeń', () {
    expect(
      stateLabelsFor(classifiedWith(
          [SongIssue.missingYoutube, SongIssue.missingTitle, SongIssue.hasUserMessage])),
      [kLabelToReview, ReviewKind.missingData.label, ReviewKind.userMessage.label],
    );
    expect(stateLabelsFor(classifiedWith([SongIssue.missingChords])),
        [kLabelToReview, ReviewKind.missingData.label]);
    expect(stateLabelsFor(classifiedWith([SongIssue.missingChords, SongIssue.correction])),
        [kLabelToReview, ReviewKind.missingData.label, ReviewKind.correction.label]);
    // Kolizja z apką i kolizja w paczce to osobne kolejki.
    expect(stateLabelsFor(classifiedWith([SongIssue.similarTextInApp, SongIssue.sameTitleInBatch])),
        [kLabelToReview, ReviewKind.duplicateInApp.label, ReviewKind.duplicateInBatch.label]);
  });

  test('jaccard i słowa', () {
    expect(jaccard(textWords('Ala ma kota'), textWords('ala MA kota!')), 1.0);
    expect(jaccard(textWords(''), textWords('x')), 0);
  });
}
