import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:piosenkomat/classify.dart';
import 'package:piosenkomat/model.dart';
import 'package:piosenkomat/similarity.dart';
import 'package:test/test.dart';

import 'helpers.dart';

const _a = 'Płonie ognisko i szumią knieje\nDrużynowy jest wśród nas\nOpowiada starodawne dzieje\nBohaterski wskrzesza czas';
const _b = 'Zupełnie inny tekst o morzu\nŻagle na wietrze i sól na wargach\nDaleko od lasu i od ogniska';

void main() {
  group('dowody i poziomy:', () {
    test('identyczna = każde pole dosłownie równe', () {
      final a = SongProfile(sampleSong(lyrics: _a));
      final b = SongProfile(sampleSong(lyrics: _a));
      final s = compare(a, b);
      expect(s.whereType<SameTitle>(), hasLength(1));
      expect(s.whereType<SameText>(), hasLength(1));
      expect(s.whereType<SameChords>(), hasLength(1));
      expect(s.whereType<MetadataDiff>(), isEmpty);
      expect(levelOf(s), MatchLevel.identical);
    });

    test('Jaccard 1.0 to nie identyczna: zamieniona kolejność wersów → sameSong', () {
      final a = SongProfile(sampleSong(lyrics: 'Ala ma kota\nKot ma Ale'));
      final b = SongProfile(sampleSong(lyrics: 'Kot ma Ale\nAla ma kota'));
      final s = compare(a, b);
      expect(s.whereType<TextOverlap>().single.jaccard, 1.0);
      expect(s.whereType<SameText>(), isEmpty);
      expect(levelOf(s), MatchLevel.sameSong);
    });

    test('inny YouTube → MetadataDiff, sameSong', () {
      final a = SongProfile(sampleSong(lyrics: _a));
      final b = SongProfile(sampleSong(lyrics: _a, yt: 'xxxxxxxxxxx'));
      final s = compare(a, b);
      expect(s.whereType<MetadataDiff>().single.fields, ['yt_video_id']);
      expect(levelOf(s), MatchLevel.sameSong);
    });

    test('inna wielkość liter w tytule → MetadataDiff(title), ale SameTitle', () {
      final a = SongProfile(sampleSong(title: 'Płonie Ognisko', lyrics: _a));
      final b = SongProfile(sampleSong(title: 'Płonie ognisko', lyrics: _a));
      final s = compare(a, b);
      expect(s.whereType<SameTitle>(), hasLength(1));
      expect(s.whereType<MetadataDiff>().single.fields, ['title']);
      expect(levelOf(s), MatchLevel.sameSong);
    });

    test('inne chwyty → sameTextDifferentChords', () {
      final a = SongProfile(sampleSong(lyrics: _a, chordsText: 'a d e\na d e'));
      final b = SongProfile(sampleSong(lyrics: _a, chordsText: 'C G a\nC G a'));
      expect(levelOf(compare(a, b)), MatchLevel.sameTextDifferentChords);
    });

    test('ten sam tytuł, inny tekst → sameTitleDifferentText', () {
      expect(levelOf(compare(SongProfile(sampleSong(lyrics: _a)), SongProfile(sampleSong(lyrics: _b)))),
          MatchLevel.sameTitleDifferentText);
    });

    test('inny tytuł, podobny tekst → similarText; inny → null', () {
      final a = SongProfile(sampleSong(title: 'Ognisko', lyrics: _a));
      final b = SongProfile(sampleSong(title: 'Knieje', lyrics: '$_a\nJedna nowa linijka'));
      expect(levelOf(compare(a, b)), MatchLevel.similarText);
      final c = SongProfile(sampleSong(title: 'Morze', lyrics: _b));
      expect(levelOf(compare(a, c)), isNull);
    });

    test('null == [] w metadanych', () {
      final a = sampleSong(lyrics: _a)..hidTitles = [];
      final b = sampleSong(lyrics: _a)..hidTitles = ['', ' '];
      expect(compare(SongProfile(a), SongProfile(b)).whereType<MetadataDiff>(), isEmpty);
    });
  });

  group('względem apki:', () {
    test('identyczna bez dopisku → odrzut', () async {
      final got = classify(msgFrom(await completeEmail(song: sampleSong(lyrics: _a))),
          book: bookWith([sampleSong(lyrics: _a)]));
      expect(got.target, Target.rejectAlreadyInApp);
      expect(got.decision.detail, contains('ten sam tekst'));
      expect(stateLabelsFor(got), [kLabelRejectedInBook]);
      expect(got.goesToFile, isFalse);
    });

    test('identyczna z dopiskiem → sam mejl, nieprzeczytany', () async {
      final got = classify(
        msgFrom(await completeEmail(song: sampleSong(lyrics: _a), userMessage: 'Dodajcie drugi głos')),
        book: bookWith([sampleSong(lyrics: _a)]),
      );
      expect(got.target, Target.mailOnlyIdentical);
      expect(got.goesToFile, isFalse, reason: 'piosenki nie ma po co oglądać');
      expect(stateLabelsFor(got),
          [kLabelToReview, ReviewKind.identicalInApp.label, ReviewKind.userMessage.label]);
      expect(got.labels.any(isClosedLabel), isFalse);
    });

    test('ta sama piosenka, inny YouTube → metadata-differ-from-app, do pliku', () async {
      final got = classify(
        msgFrom(await completeEmail(song: sampleSong(lyrics: _a, yt: 'xxxxxxxxxxx'))),
        book: bookWith([sampleSong(lyrics: _a)]),
      );
      expect(got.target, Target.candidateNew);
      expect(issuesOf(got), [SongIssue.metadataDifferFromApp]);
      expect(detailOf(got, SongIssue.metadataDifferFromApp), contains('yt_video_id'));
    });

    test('inne chwyty → chords-differ-from-app', () async {
      final got = classify(
        msgFrom(await completeEmail(song: sampleSong(lyrics: _a, chordsText: 'C G a\nC G a'))),
        book: bookWith([sampleSong(lyrics: _a)]),
      );
      expect(issuesOf(got), [SongIssue.chordsDifferFromApp]);
      expect(stateLabelsFor(got), [kLabelToReview, ReviewKind.undeclaredCorrection.label]);
    });

    test('ten sam tytuł, inny tekst → same-title-in-app', () async {
      final got = classify(msgFrom(await completeEmail(song: sampleSong(lyrics: _b))),
          book: bookWith([sampleSong(lyrics: _a)]));
      expect(issuesOf(got), [SongIssue.sameTitleInApp]);
      expect(stateLabelsFor(got), [kLabelToReview, ReviewKind.duplicateInApp.label]);
    });

    test('inny tytuł, podobny tekst → similar-text-in-app z nazwą pierwowzoru', () async {
      final got = classify(
        msgFrom(await completeEmail(song: sampleSong(title: 'Płonie ognisko', lyrics: '$_a\nDodatkowa linijka'))),
        book: bookWith([sampleSong(title: 'Ognisko', lyrics: _a)]),
      );
      expect(issuesOf(got), [SongIssue.similarTextInApp]);
      expect(detailOf(got, SongIssue.similarTextInApp), contains('„Ognisko”'));
    });

    test('inny tytuł, inny tekst → czysty kandydat', () async {
      final got = classify(msgFrom(await completeEmail(song: sampleSong(title: 'Morze', lyrics: _b))),
          book: bookWith([sampleSong(title: 'Ognisko', lyrics: _a)]));
      expect(got.isClean, isTrue);
    });

    test('poprawka: identyczna → sam mejl; sameSong → kandydat bez uwag', () async {
      final book = bookWith([sampleSong(lyrics: _a)]);
      final same = classify(msgFrom(await completeEmail(isNew: false, song: sampleSong(lyrics: _a))), book: book);
      expect(same.target, Target.mailOnlyIdentical);
      final yt = classify(
          msgFrom(await completeEmail(isNew: false, song: sampleSong(lyrics: _a, yt: 'xxxxxxxxxxx'))),
          book: book);
      expect(yt.target, Target.candidateCorrection);
      expect(yt.issues, isEmpty);
      expect(yt.submission.correctionTarget, 'tmp');
    });
  });

  group('w paczce:', () {
    Future<String> older(String raw) async =>
        raw.replaceFirst('Date: 2026-09-06T12:00:00+02:00', 'Date: 2026-09-01T12:00:00+02:00');

    test('identyczna dwa razy → najnowsza wchodzi, starsza rejected/duplicate', () async {
      final old = await older(await completeEmail(song: sampleSong(lyrics: _a)));
      final newer = await completeEmail(song: sampleSong(lyrics: _a));
      final out = classifyBatch([msgFrom(newer, id: 'new'), msgFrom(old, id: 'old')], book: SongBook.empty);
      final byId = {for (final c in out) c.message.id: c};
      expect(byId['new']!.isClean, isTrue);
      expect(byId['old']!.target, Target.rejectDuplicate);
      expect(byId['old']!.decision.detail, contains('[new]'));
    });

    test('starsza z dopiskiem też odpada — nowsza jest dobra', () async {
      final old = await older(await completeEmail(song: sampleSong(lyrics: _a), userMessage: 'pytanie'));
      final newer = await completeEmail(song: sampleSong(lyrics: _a));
      final out = classifyBatch([msgFrom(old, id: 'old'), msgFrom(newer, id: 'new')], book: SongBook.empty);
      expect(out.firstWhere((c) => c.message.id == 'old').target, Target.rejectDuplicate);
    });

    test('mniej niż identyczne → obie do pliku z same-title-in-batch', () async {
      final out = classifyBatch([
        msgFrom(await completeEmail(song: sampleSong(lyrics: _a)), id: 'a'),
        msgFrom(await completeEmail(song: sampleSong(lyrics: _a, yt: 'xxxxxxxxxxx')), id: 'b'),
      ], book: SongBook.empty);
      expect(out.map((c) => c.target), everyElement(Target.candidateNew));
      expect(out.map(issuesOf), everyElement([SongIssue.sameTitleInBatch]));
      expect(detailOf(out[0], SongIssue.sameTitleInBatch), contains('[b]'));
    });

    test('różne tytuły, podobna treść → similar-text-in-batch', () async {
      final out = classifyBatch([
        msgFrom(await completeEmail(song: sampleSong(title: 'Ognisko', lyrics: _a)), id: 'a'),
        msgFrom(await completeEmail(song: sampleSong(title: 'Knieje', lyrics: '$_a\nJedna nowa linijka')), id: 'b'),
        msgFrom(await completeEmail(song: sampleSong(title: 'Morze', lyrics: _b)), id: 'c'),
      ], book: SongBook.empty);
      expect(out.map((c) => c.isClean), [false, false, true]);
      expect(issuesOf(out[0]), [SongIssue.similarTextInBatch]);
      expect(detailOf(out[0], SongIssue.similarTextInBatch), contains('„Knieje”'));
    });

    test('dwie poprawki tej samej piosenki → same-target-in-batch, obie do pliku', () async {
      final book = bookWith([sampleSong(lyrics: _a)]);
      final out = classifyBatch([
        msgFrom(await completeEmail(isNew: false, song: sampleSong(lyrics: '$_a\nDopisana zwrotka')), id: 'a'),
        msgFrom(await completeEmail(isNew: false, song: sampleSong(title: 'Płonie ognisko', lyrics: '$_a\nInna zwrotka')), id: 'b'),
      ], book: book);
      expect(out.map((c) => c.target), everyElement(Target.candidateCorrection));
      expect(out.map((c) => c.submission.correctionTarget), everyElement('tmp'));
      expect(out.map(issuesOf), everyElement([SongIssue.sameTargetInBatch]));
    });

    test('nowa i poprawka nie zlewają się w jedną grupę', () async {
      final out = classifyBatch([
        msgFrom(await completeEmail(song: sampleSong(lyrics: _a)), id: 'a'),
        msgFrom(await completeEmail(isNew: false, song: sampleSong(lyrics: _a)), id: 'b'),
      ], book: SongBook.empty);
      expect(out.map((c) => c.target).toSet(), {Target.candidateNew, Target.candidateCorrection});
    });
  });

  test('jaccard i słowa', () {
    expect(jaccard(textWords('Ala ma kota'), textWords('ala MA kota!')), 1.0);
    expect(jaccard(textWords(''), textWords('x')), 0);
  });
}
