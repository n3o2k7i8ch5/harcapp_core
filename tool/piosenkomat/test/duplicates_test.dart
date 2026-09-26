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

    test('te same wersy to nie identyczna: zamieniona kolejność → sameSong', () {
      final a = SongProfile(sampleSong(lyrics: _a));
      final b = SongProfile(sampleSong(lyrics: _a.split('\n').reversed.join('\n')));
      final s = compare(a, b);
      expect((s.sharedLines!.coverage(), s.sharedLines!.otherCoverage()), (1.0, 1.0));
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

    test('inne chwyty → sameSong, a o chwytach mówi dowód', () {
      final a = SongProfile(sampleSong(lyrics: _a, chordsText: 'a d e\na d e'));
      final b = SongProfile(sampleSong(lyrics: _a, chordsText: 'C G a\nC G a'));
      final s = compare(a, b);
      expect(levelOf(s), MatchLevel.sameSong);
      expect(s.sameChordsUpToOrder, isFalse);
    });

    test('ten sam tytuł, inny tekst → sameTitleDifferentText', () {
      expect(levelOf(compare(SongProfile(sampleSong(lyrics: _a)), SongProfile(sampleSong(lyrics: _b)))),
          MatchLevel.sameTitleDifferentText);
    });

    test('inny tytuł, ten sam tekst i wers więcej → shorter; inny → null', () {
      // Różne id: helper daje wszystkim `tmp`, a wspólne id to osobny dowód.
      final a = SongProfile(sampleSong(id: 'a', title: 'Ognisko', lyrics: _a));
      final b = SongProfile(sampleSong(id: 'b', title: 'Knieje', lyrics: '$_a\nJedna nowa linijka'));
      expect(levelOf(compare(a, b)), MatchLevel.shorter, reason: 'całe „Ognisko” jest w „Kniejach”');
      expect(levelOf(compare(b, a)), MatchLevel.longer);
      final c = SongProfile(sampleSong(id: 'c', title: 'Morze', lyrics: _b));
      expect(levelOf(compare(a, c)), isNull);
    });

    test('to samo id, poza tym nic → sameIdDifferentSong; treść wygrywa', () {
      final a = SongProfile(sampleSong(id: 'x', title: 'Ognisko', lyrics: _a));
      final c = SongProfile(sampleSong(id: 'x', title: 'Morze', lyrics: _b));
      final s = compare(a, c);
      expect(s.whereType<SameId>(), hasLength(1));
      expect(levelOf(s), MatchLevel.sameIdDifferentSong);
      final b = SongProfile(sampleSong(id: 'x', title: 'Knieje', lyrics: '$_a\nJedna nowa linijka'));
      expect(levelOf(compare(a, b)), MatchLevel.shorter);
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
      expect(got.destination, Destination.rejectAlreadyInApp);
      expect(got.decision.detail, contains('ten sam tekst'));
      expect(stateLabelsFor(got), [kLabelRejectedAlreadyInApp]);
      expect(got.goesToFile, isFalse);
    });

    test('identyczna z dopiskiem → odrzut z „rzuć okiem”, przeczytany', () async {
      final got = classify(
        msgFrom(await completeEmail(song: sampleSong(lyrics: _a), userMessage: 'Dodajcie drugi głos')),
        book: bookWith([sampleSong(lyrics: _a)]),
      );
      expect(got.destination, Destination.rejectAlreadyInApp);
      expect(got.goesToFile, isFalse, reason: 'piosenki nie ma po co oglądać');
      expect(stateLabelsFor(got), [kLabelRejectedAlreadyInApp]);
      expect(got.labels, contains(kLabelHaveALook));
      expect(got.labels.any((l) => l.startsWith(kLabelNeedsReview)), isFalse,
          reason: '`needs-review` jest tylko dla piosenek w pliku');
      expect(got.labels.any(isClosedLabel), isTrue,
          reason: 'po `label scanned` nie wisi w nieprzeczytanych');
    });

    test('ta sama piosenka, inny YouTube → metadata-differ-from-app, do pliku', () async {
      final got = classify(
        msgFrom(await completeEmail(song: sampleSong(lyrics: _a, yt: 'xxxxxxxxxxx'))),
        book: bookWith([sampleSong(lyrics: _a)]),
      );
      expect(got.destination, Destination.candidateNew);
      expect(issuesOf(got), [SongIssue.metadataDifferFromApp]);
      expect(detailOf(got, SongIssue.metadataDifferFromApp), contains('yt_video_id'));
    });

    test('inne chwyty → chords-differ-from-app', () async {
      final got = classify(
        msgFrom(await completeEmail(song: sampleSong(lyrics: _a, chordsText: 'C G a\nC G a'))),
        book: bookWith([sampleSong(lyrics: _a)]),
      );
      expect(issuesOf(got), [SongIssue.chordsDifferFromApp]);
      expect(stateLabelsFor(got), [kLabelNeedsReview, NeedsReviewKind.undeclaredCorrection.label]);
    });

    test('ten sam tytuł, inny tekst → same-title-in-app', () async {
      final got = classify(msgFrom(await completeEmail(song: sampleSong(lyrics: _b))),
          book: bookWith([sampleSong(lyrics: _a)]));
      expect(issuesOf(got), [SongIssue.sameTitleInApp]);
      expect(stateLabelsFor(got), [kLabelNeedsReview, NeedsReviewKind.duplicateInApp.label]);
    });

    test('inny tytuł, dopisana zwrotka → more-verses-than-app z nazwą pierwowzoru', () async {
      final got = classify(
        msgFrom(await completeEmail(song: sampleSong(title: 'Płonie ognisko', lyrics: '$_a\nDodatkowa linijka'))),
        book: bookWith([sampleSong(title: 'Ognisko', lyrics: _a)]),
      );
      expect(issuesOf(got), [SongIssue.moreVersesThanApp]);
      expect(detailOf(got, SongIssue.moreVersesThanApp), contains('„Ognisko”'));
      expect(stateLabelsFor(got), [kLabelNeedsReview, NeedsReviewKind.undeclaredCorrection.label],
          reason: 'dopisane zwrotki to najczęściej poprawka wysłana jako nowa');
    });

    test('fragment piosenki z apki → fewer-verses-than-app', () async {
      final got = classify(
        msgFrom(await completeEmail(song: sampleSong(title: 'Inny', lyrics: _a.split('\n').take(3).join('\n')))),
        book: bookWith([sampleSong(title: 'Ognisko', lyrics: '$_a\n$_b')]),
      );
      expect(issuesOf(got), [SongIssue.fewerVersesThanApp]);
    });

    test('połowa wersów wspólna → variant-of-app', () async {
      final half = _a.split('\n').take(2).join('\n');
      final got = classify(
        msgFrom(await completeEmail(song: sampleSong(title: 'Inny', lyrics: '$half\nZupełnie nowy wers o czymś innym\nI jeszcze jeden nowy na koniec'))),
        book: bookWith([sampleSong(title: 'Ognisko', lyrics: _a)]),
      );
      expect(issuesOf(got), [SongIssue.variantOfApp]);
    });

    test('dwie wersje w apce → pastylka wymienia obie', () async {
      final got = classify(
        msgFrom(await completeEmail(song: sampleSong(title: 'Nowy tytuł', lyrics: _a))),
        book: bookWith([
          sampleSong(id: 'o!_a', title: 'Ognisko', lyrics: _a),
          sampleSong(id: 'o!_b', title: 'Ognisko II', lyrics: '$_a\nJedna nowa linijka'),
        ]),
      );
      expect(got.submission.appMatch?.songId, 'o!_a');
      expect(got.submission.alsoInApp.map((m) => m.songId), ['o!_b']);
      final detail = got.issues.single.detail!;
      expect(detail, allOf(contains('„Ognisko”'), contains('też „Ognisko II”')));
    });

    test('inny tytuł, inny tekst → czysty kandydat', () async {
      final got = classify(msgFrom(await completeEmail(song: sampleSong(title: 'Morze', lyrics: _b))),
          book: bookWith([sampleSong(title: 'Ognisko', lyrics: _a)]));
      expect(got.isClean, isTrue);
    });

    test('poprawka: identyczna bez komentarza → odrzut; sameSong → kandydat bez uwag', () async {
      final book = bookWith([sampleSong(lyrics: _a)]);
      final same = classify(
          msgFrom(await completeEmail(isNew: false, song: sampleSong(lyrics: _a), withUpdateComment: false)),
          book: book);
      expect(same.destination, Destination.rejectAlreadyInApp);
      expect(same.goesToFile, isFalse);
      final yt = classify(
          msgFrom(await completeEmail(isNew: false, correctionTarget: 'tmp', song: sampleSong(lyrics: _a, yt: 'xxxxxxxxxxx'))),
          book: book);
      expect(yt.destination, Destination.candidateCorrection);
      expect(yt.issues, isEmpty);
      expect(yt.submission.correctionTarget, 'tmp');
    });
  });

  group('w paczce:', () {
    Future<String> older(String raw) async =>
        raw.replaceFirst('Date: 2026-09-06T12:00:00+02:00', 'Date: 2026-09-01T12:00:00+02:00');
    Future<String> dated(String raw, String day) async =>
        raw.replaceFirst('Date: 2026-09-06T12:00:00+02:00', 'Date: 2026-09-${day}T12:00:00+02:00');

    test('identyczna dwa razy → najnowsza wchodzi, starsza rejected/duplicate', () async {
      final old = await older(await completeEmail(song: sampleSong(lyrics: _a)));
      final newer = await completeEmail(song: sampleSong(lyrics: _a));
      final out = classifyBatch([msgFrom(newer, id: 'new'), msgFrom(old, id: 'old')], book: SongBook.empty);
      final byId = {for (final c in out) c.message.id: c};
      expect(byId['new']!.isClean, isTrue);
      expect(byId['old']!.destination, Destination.rejectDuplicate);
      expect(byId['old']!.decision.detail, contains('[new]'));
    });

    test('starsza z dopiskiem też odpada — nowsza jest dobra', () async {
      final old = await older(await completeEmail(song: sampleSong(lyrics: _a), userMessage: 'pytanie'));
      final newer = await completeEmail(song: sampleSong(lyrics: _a));
      final out = classifyBatch([msgFrom(old, id: 'old'), msgFrom(newer, id: 'new')], book: SongBook.empty);
      expect(out.firstWhere((c) => c.message.id == 'old').destination, Destination.rejectDuplicate);
    });

    test('dwie poprawki „Barki”, tylko jedna z celem → obie widzą się w paczce', () async {
      // Cel jednej zgadnięty (grupa po celu), drugiej nie (grupa po tytule):
      // różne grupy, a wspólny tytuł nie może ich wtedy rozdzielać.
      final book = bookWith([sampleSong(title: 'Barka', lyrics: _a)]);
      final out = classifyBatch([
        msgFrom(await completeEmail(isNew: false, song: sampleSong(title: 'Barka', lyrics: '$_a\nDopisek')), id: 'z'),
        msgFrom(await completeEmail(isNew: false, song: sampleSong(title: 'Barka', lyrics: _b)), id: 'bez'),
      ], book: book);
      final byId = {for (final c in out) c.message.id: c};
      expect(byId['z']!.submission.correctionTargetGuessed, isTrue);
      expect(byId['bez']!.submission.correctionTarget, isNull);
      expect(issuesOf(byId['z']!), contains(SongIssue.sameTitleInBatch));
      expect(issuesOf(byId['bez']!), contains(SongIssue.sameTitleInBatch));
    });

    test('mniej niż identyczne → obie do pliku z same-title-in-batch', () async {
      final out = classifyBatch([
        msgFrom(await completeEmail(song: sampleSong(lyrics: _a)), id: 'a'),
        msgFrom(await completeEmail(song: sampleSong(lyrics: _a, yt: 'xxxxxxxxxxx')), id: 'b'),
      ], book: SongBook.empty);
      expect(out.map((c) => c.destination), everyElement(Destination.candidateNew));
      expect(out.map(issuesOf), everyElement([SongIssue.sameTitleInBatch]));
      expect(detailOf(out[0], SongIssue.sameTitleInBatch), contains('[b]'));
    });

    test('A≡B + C z innymi chwytami: A odpada, B i C wskazują siebie nawzajem', () async {
      final a = await dated(await completeEmail(song: sampleSong(lyrics: _a)), '01');
      final b = await dated(await completeEmail(song: sampleSong(lyrics: _a)), '03');
      final c = await completeEmail(song: sampleSong(lyrics: _a, chordsText: 'C G a\nC G a'));
      final out = classifyBatch(
          [msgFrom(c, id: 'c'), msgFrom(a, id: 'a'), msgFrom(b, id: 'b')], book: SongBook.empty);
      final byId = {for (final x in out) x.message.id: x};
      expect(byId['a']!.destination, Destination.rejectDuplicate);
      expect(byId['a']!.decision.detail, contains('[b]'));
      // B nie wchodzi bez pytania, choć jest najnowszą z identycznych.
      expect(issuesOf(byId['b']!), [SongIssue.sameTitleInBatch]);
      expect(issuesOf(byId['c']!), [SongIssue.sameTitleInBatch]);
      // Pastylki wskazują to, co jest w pliku — nie odrzucone A.
      expect(detailOf(byId['b']!, SongIssue.sameTitleInBatch), contains('[c]'));
      expect(detailOf(byId['c']!, SongIssue.sameTitleInBatch), contains('[b]'));
    });

    test('trzy identyczne → zostaje najnowsza, bez pastylki', () async {
      final out = classifyBatch([
        msgFrom(await dated(await completeEmail(song: sampleSong(lyrics: _a)), '01'), id: 'a'),
        msgFrom(await dated(await completeEmail(song: sampleSong(lyrics: _a)), '03'), id: 'b'),
        msgFrom(await completeEmail(song: sampleSong(lyrics: _a)), id: 'c'),
      ], book: SongBook.empty);
      final byId = {for (final x in out) x.message.id: x};
      expect(byId['a']!.destination, Destination.rejectDuplicate);
      expect(byId['b']!.destination, Destination.rejectDuplicate);
      expect(byId['c']!.isClean, isTrue);
    });

    test('dwie identyczne poprawki → starsza odpada, nowsza bez same-target-in-batch', () async {
      final book = bookWith([sampleSong(lyrics: _a)]);
      Future<String> poprawka() => completeEmail(
          isNew: false, correctionTarget: 'tmp', song: sampleSong(lyrics: '$_a\nDopisana zwrotka'));
      final out = classifyBatch([
        msgFrom(await older(await poprawka()), id: 'old'),
        msgFrom(await poprawka(), id: 'new'),
      ], book: book);
      final byId = {for (final x in out) x.message.id: x};
      expect(byId['old']!.destination, Destination.rejectDuplicate);
      expect(byId['new']!.destination, Destination.candidateCorrection);
      expect(issuesOf(byId['new']!), isNot(contains(SongIssue.sameTargetInBatch)));
    });

    test('podobna z innej grupy wskazuje zostającą, nie odrzucony duplikat', () async {
      final out = classifyBatch([
        msgFrom(await older(await completeEmail(song: sampleSong(title: 'Ognisko', lyrics: _a))), id: 'a'),
        msgFrom(await completeEmail(song: sampleSong(title: 'Ognisko', lyrics: _a)), id: 'b'),
        msgFrom(await completeEmail(song: sampleSong(title: 'Knieje', lyrics: '$_a\nJedna nowa linijka')), id: 'd'),
      ], book: SongBook.empty);
      final byId = {for (final x in out) x.message.id: x};
      expect(byId['a']!.destination, Destination.rejectDuplicate);
      expect(detailOf(byId['d']!, SongIssue.similarTextInBatch), contains('[b]'));
      expect(detailOf(byId['b']!, SongIssue.similarTextInBatch), contains('[d]'));
    });

    test('wspólny tylko tytuł ukryty: łapie tekst, nie tytuł', () async {
      final ukryty = sampleSong(title: 'Pan kiedyś stanął nad brzegiem', lyrics: _a)
        ..hidTitles = ['Ognisko'];
      final out = classifyBatch([
        msgFrom(await completeEmail(song: sampleSong(title: 'Ognisko', lyrics: _a)), id: 'a'),
        msgFrom(await completeEmail(song: ukryty), id: 'b'),
      ], book: SongBook.empty);
      expect(out.map(issuesOf), everyElement([SongIssue.similarTextInBatch]));
      expect(detailOf(out[0], SongIssue.similarTextInBatch), contains('[b]'));
    });

    test('wspólny tylko tytuł ukryty, inny tekst → obie czyste', () async {
      final ukryty = sampleSong(title: 'Pan kiedyś stanął nad brzegiem', lyrics: _b)
        ..hidTitles = ['Ognisko'];
      final out = classifyBatch([
        msgFrom(await completeEmail(song: sampleSong(title: 'Ognisko', lyrics: _a)), id: 'a'),
        msgFrom(await completeEmail(song: ukryty), id: 'b'),
      ], book: SongBook.empty);
      expect(out.map((c) => c.isClean), everyElement(isTrue));
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
        msgFrom(await completeEmail(isNew: false, correctionTarget: 'tmp', song: sampleSong(lyrics: '$_a\nDopisana zwrotka')), id: 'a'),
        msgFrom(await completeEmail(isNew: false, correctionTarget: 'tmp', song: sampleSong(title: 'Płonie ognisko', lyrics: '$_a\nInna zwrotka')), id: 'b'),
      ], book: book);
      expect(out.map((c) => c.destination), everyElement(Destination.candidateCorrection));
      expect(out.map((c) => c.submission.correctionTarget), everyElement('tmp'));
      expect(out.map(issuesOf), everyElement([SongIssue.sameTargetInBatch]));
    });

    test('poprawki różnych piosenek o podobnej treści → nie „ta sama piosenka”', () async {
      // `batchMatch` bywa dopasowaniem po samym tekście (różne tytuły). Cele
      // są wtedy różne, więc pastylka „druga poprawka tej samej piosenki”
      // byłaby nieprawdą.
      final ognisko = sampleSong(title: 'Ognisko', lyrics: _a)..id = 'o1';
      final knieje = sampleSong(title: 'Knieje', lyrics: '$_a\nJedna nowa linijka')..id = 'k1';
      final out = classifyBatch([
        msgFrom(
            await completeEmail(
                isNew: false,
                correctionTarget: 'o1',
                song: sampleSong(title: 'Ognisko', lyrics: '$_a\nDopisana zwrotka')),
            id: 'a'),
        msgFrom(
            await completeEmail(
                isNew: false,
                correctionTarget: 'k1',
                song: sampleSong(title: 'Knieje', lyrics: '$_a\nJedna nowa linijka\nI jeszcze jedna')),
            id: 'b'),
      ], book: bookWith([ognisko, knieje]));
      expect(out.map((c) => c.submission.correctionTarget), ['o1', 'k1']);
      expect(out.map(issuesOf), everyElement(isNot(contains(SongIssue.sameTargetInBatch))));
      expect(issuesOf(out[0]), contains(SongIssue.similarTextInBatch));
    });

    test('ta sama piosenka pod dwoma tytułami → jedna grupa, starsza odpada', () async {
      final out = classifyBatch([
        msgFrom(await older(await completeEmail(song: sampleSong(title: 'Ognisko', lyrics: _a))), id: 'old'),
        msgFrom(await completeEmail(song: sampleSong(title: 'Płonie ognisko', lyrics: _a)), id: 'new'),
      ], book: SongBook.empty);
      final byId = {for (final x in out) x.message.id: x};
      // Ten sam tekst, różne tytuły: w grupie po treści — nie identyczne
      // (tytuł inny), więc obie do pliku, wskazując siebie nawzajem.
      expect(byId['old']!.destination, Destination.candidateNew);
      expect(detailOf(byId['old']!, SongIssue.similarTextInBatch), contains('[new]'));
      expect(detailOf(byId['new']!, SongIssue.similarTextInBatch), contains('[old]'));
    });

    test('nowa i poprawka nie zlewają się w jedną grupę', () async {
      final out = classifyBatch([
        msgFrom(await completeEmail(song: sampleSong(lyrics: _a)), id: 'a'),
        msgFrom(await completeEmail(isNew: false, song: sampleSong(lyrics: _a)), id: 'b'),
      ], book: SongBook.empty);
      expect(out.map((c) => c.destination).toSet(), {Destination.candidateNew, Destination.candidateCorrection});
    });
  });

  test('słowa po normalizacji', () {
    expect(textWords('Ala ma kota'), textWords('ala MA kota!'));
    expect(textWords(''), isEmpty);
  });
}
