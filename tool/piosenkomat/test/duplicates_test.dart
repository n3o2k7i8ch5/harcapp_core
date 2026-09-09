import 'package:piosenkomat/classify.dart';
import 'package:piosenkomat/model.dart';
import 'package:piosenkomat/similarity.dart';
import 'package:test/test.dart';

import 'helpers.dart';

const _a = 'Płonie ognisko i szumią knieje\nDrużynowy jest wśród nas\nOpowiada starodawne dzieje\nBohaterski wskrzesza czas';
const _b = 'Zupełnie inny tekst o morzu\nŻagle na wietrze i sól na wargach\nDaleko od lasu i od ogniska';

List<SkipReason> reasonsOf(Classified c) => (c.verdict as Manual).reasons;

void main() {
  group('względem śpiewnika:', () {
    test('ten sam tytuł i tekst → already-in-app, automat', () async {
      final book = bookWith([sampleSong(lyrics: _a)]);
      final got = classify(msgFrom(await completeEmail(song: sampleSong(lyrics: '$_a\n'))), book: book);
      expect(reasonsOf(got), [SkipReason.alreadyInBook]);
      expect(stateLabelsFor(got.verdict), [kLabelRejectedInBook]);
    });

    test('ten sam tytuł, inny tekst → przegląd possible-duplicate', () async {
      final book = bookWith([sampleSong(lyrics: _a)]);
      final got = classify(msgFrom(await completeEmail(song: sampleSong(lyrics: _b))), book: book);
      expect(reasonsOf(got), [SkipReason.sameTitleDifferentText]);
      expect(stateLabelsFor(got.verdict), [kLabelToReview, ReviewKind.possibleDuplicate.label]);
      expect((got.verdict as Manual).detail, contains('tekst zgodny w'));
    });

    test('inny tytuł, podobny tekst → przegląd z nazwą pierwowzoru', () async {
      final book = bookWith([sampleSong(title: 'Ognisko', lyrics: _a)]);
      final got = classify(
        msgFrom(await completeEmail(song: sampleSong(title: 'Płonie ognisko', lyrics: '$_a\nDodatkowa linijka'))),
        book: book,
      );
      expect(reasonsOf(got), [SkipReason.similarInBook]);
      expect((got.verdict as Manual).detail, contains('„Ognisko”'));
    });

    test('inny tytuł, inny tekst → import', () async {
      final book = bookWith([sampleSong(title: 'Ognisko', lyrics: _a)]);
      final got = classify(msgFrom(await completeEmail(song: sampleSong(title: 'Morze', lyrics: _b))), book: book);
      expect(got.verdict, isA<Import>());
    });
  });

  group('w paczce:', () {
    test('identyczna dwa razy → starsza wchodzi, młodsza rejected/duplicate', () async {
      final older = (await completeEmail(song: sampleSong(lyrics: _a)))
          .replaceFirst('Date: 2026-09-06T12:00:00+02:00', 'Date: 2026-09-01T12:00:00+02:00');
      final newer = await completeEmail(song: sampleSong(lyrics: _a));
      final out = classifyBatch([msgFrom(newer, id: 'new'), msgFrom(older, id: 'old')], book: SongBook.empty);
      expect(out[1].isImport, isTrue);
      expect(reasonsOf(out[0]), [SkipReason.duplicateInBatch]);
      expect(stateLabelsFor(out[0].verdict), [kLabelRejectedDuplicate]);
      expect((out[0].verdict as Manual).detail, contains('[old]'));
    });

    test('ten sam tytuł, inna treść → oba na przegląd', () async {
      final out = classifyBatch([
        msgFrom(await completeEmail(song: sampleSong(lyrics: _a)), id: 'a'),
        msgFrom(await completeEmail(song: sampleSong(lyrics: _b)), id: 'b'),
      ], book: SongBook.empty);
      expect(out.map((c) => c.isImport), [false, false]);
      expect(reasonsOf(out[0]), [SkipReason.sameTitleInBatch]);
    });

    test('różne tytuły, podobna treść → oba na przegląd', () async {
      final out = classifyBatch([
        msgFrom(await completeEmail(song: sampleSong(title: 'Ognisko', lyrics: _a)), id: 'a'),
        msgFrom(await completeEmail(song: sampleSong(title: 'Knieje', lyrics: '$_a\nJedna nowa linijka')), id: 'b'),
        msgFrom(await completeEmail(song: sampleSong(title: 'Morze', lyrics: _b)), id: 'c'),
      ], book: SongBook.empty);
      expect(out.map((c) => c.isImport), [false, false, true]);
      expect(reasonsOf(out[0]), [SkipReason.similarInBatch]);
      expect((out[0].verdict as Manual).detail, contains('„Knieje”'));
    });
  });

  test('etykiety przeglądu: jedna na powód, bez powtórzeń', () {
    expect(
      stateLabelsFor(const Manual([SkipReason.missingYoutube, SkipReason.missingTitle, SkipReason.hasUserMessage])),
      [kLabelToReview, ReviewKind.missingData.label, ReviewKind.userMessage.label],
    );
    expect(stateLabelsFor(const Manual([SkipReason.missingChords])), [kLabelToReview, ReviewKind.missingData.label]);
    expect(stateLabelsFor(const Manual([SkipReason.missingChords, SkipReason.correction])),
        [kLabelToReview, ReviewKind.missingData.label, ReviewKind.correction.label]);
  });

  test('jaccard i słowa', () {
    expect(jaccard(textWords('Ala ma kota'), textWords('ala MA kota!')), 1.0);
    expect(jaccard(textWords(''), textWords('x')), 0);
  });
}
