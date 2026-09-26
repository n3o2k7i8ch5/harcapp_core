import 'dart:convert';
import 'dart:io';

import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:piosenkomat/classify.dart';
import 'package:piosenkomat/hrcpsng.dart';
import 'package:piosenkomat/model.dart';
import 'package:piosenkomat/plan.dart';
import 'package:piosenkomat/review.dart';
import 'package:piosenkomat/similarity.dart';
import 'package:test/test.dart';

import 'helpers.dart';

const _new = SubmissionKind.newSong;
const _corr = SubmissionKind.correction;

/// Dwa zgłoszenia nowych piosenek, każde z innego wątku: stan po `scan`.
Future<(RunPlan, List<SongRaw>)> _run() async {
  final items = classifyBatch([
    msgFrom(await completeEmail(song: sampleSong(title: 'Pierwsza', lyrics: 'Ala ma kota\nA kot ma Ale')), id: 'm1'),
    msgFrom(await completeEmail(song: sampleSong(title: 'Druga', lyrics: 'Wlazl kotek na plotek\nI mruga')), id: 'm2'),
  ], book: SongBook.empty);
  expect(items.every((c) => c.isClean), isTrue);
  final songs = [for (final c in items) c.song!];
  for (final c in items) {
    c.song!.piosenkomatData = c.piosenkomatData(run: 'test');
  }
  return (RunPlan.fromClassified(items), songs);
}

/// Stan po `scan` widziany oczami `label reviewed`: co automat zaproponował
/// i piosenki, z których da się złożyć plik zwrotny.
Future<(List<ReviewCandidate>, List<SongRaw>)> _scanned() async {
  final (plan, songs) = await _run();
  return (collectCandidates(plan, roundTrip(songs), _new), songs);
}

void main() {
  _verdictTests();

  test('id wątku przeżywa zapis i odczyt pliku — w obu miejscach', () async {
    final (_, songs) = await _run();
    final back = roundTrip(songs);
    expect(back.map((s) => s.contributorData?.emailThreadId).toSet(), {'m1', 'm2'});
    expect(back.map((s) => s.piosenkomatData?.threadId).toSet(), {'m1', 'm2'});
  });

  test('plan wiąże piosenkę z wątkiem', () async {
    final (plan, songs) = await _run();
    expect(plan.songByThread.keys, ['m1', 'm2']);
    expect(plan.songByThread['m1']!.title, 'Pierwsza');
    expect(plan.songByThread['m1']!.songId, songs.first.id);
  });

  test('nic nie usunięte: wszystko wchodzi', () async {
    final (proposed, songs) = await _scanned();
    final result = reviewDiff(kind: _new, candidates: proposed, reviewed: roundTrip(songs));
    expect(result.accepted.length, 2);
    expect(result.removed, isEmpty);
    expect(result.mustStop, isFalse);
  });

  test('usunięta na stronie → odrzucona; uwagi w piosence bez znaczenia', () async {
    final (proposed, songs) = await _scanned();
    final kept = roundTrip([songs.first]);
    // Zostawiona pastylka nic nie zmienia: piosenka jest → wchodzi.
    kept.single.piosenkomatData = const PiosenkomatData(
        threadId: 'm1', issues: [PiosenkomatIssue(SongIssue.missingYoutube)]);
    final result = reviewDiff(kind: _new, candidates: proposed, reviewed: kept);
    expect(result.acceptedThreads, ['m1']);
    expect(result.removed.single.title, 'Druga');
    expect(result.rejectedThreads, ['m2']);
  });

  test('tytuł poprawiony przy przeglądzie nie robi z piosenki odrzuconej', () async {
    final (proposed, songs) = await _scanned();
    final edited = roundTrip(songs);
    edited.first.title = 'Pierwsza (poprawiony tytuł)';
    final result = reviewDiff(kind: _new, candidates: proposed, reviewed: edited);
    expect(result.removed, isEmpty);
    expect(result.accepted.map((m) => m.matchedBy), everyElement(MatchedBy.threadId));
  });

  test('strona zgubiła pole piosenkomat → id wątku z contributorData', () async {
    final (proposed, songs) = await _scanned();
    final stripped = roundTrip(songs);
    for (final s in stripped) {
      s.piosenkomatData = null;
    }
    final result = reviewDiff(kind: _new, candidates: proposed, reviewed: stripped);
    expect(result.accepted, hasLength(2));
    expect(result.accepted.map((m) => m.matchedBy), everyElement(MatchedBy.threadId));
  });

  test('zgubione oba id → dopasowanie po id piosenki', () async {
    final (proposed, songs) = await _scanned();
    final stripped = roundTrip(songs);
    for (final s in stripped) {
      s.piosenkomatData = null;
      s.contributorData = null;
    }
    final first = stripped.firstWhere((s) => s.title == 'Pierwsza');
    final result = reviewDiff(kind: _new, candidates: proposed, reviewed: [first]);
    expect(result.accepted.single.matchedBy, MatchedBy.songId);
    expect(result.rejectedThreads, ['m2']);
  });

  test('piosenka spoza kandydatów → STOP, nie „pomijam”', () async {
    final (proposed, songs) = await _scanned();
    final obca = sampleSong(title: 'Dorzucona recznie', lyrics: 'Zupelnie inne slowa tutaj');
    obca.id = 'o!_dorzucona_recznie';
    final result = reviewDiff(
        kind: _new, candidates: proposed, reviewed: roundTrip([...songs, obca]));
    expect(result.foreign.map((s) => s.title), ['Dorzucona recznie']);
    expect(result.mustStop, isTrue);
  });

  test('obcy wątek → STOP, choćby tytuł pasował do kandydata', () async {
    final (proposed, songs) = await _scanned();
    final back = roundTrip(songs);
    // „Pierwsza” z innego przebiegu: ten sam tytuł i tekst, inny wątek.
    final obca = back.firstWhere((s) => s.title == 'Pierwsza')
      ..piosenkomatData = const PiosenkomatData(kind: _new, threadId: 'z-innego-przebiegu')
      ..contributorData = null;
    final druga = back.firstWhere((s) => s.title == 'Druga');
    final result = reviewDiff(kind: _new, candidates: proposed, reviewed: [obca, druga]);
    expect(result.foreign.map((s) => s.title), ['Pierwsza']);
    expect(result.mustStop, isTrue);
    expect(result.removed.map((c) => c.threadId), ['m1']);
  });

  test('poprawka w pliku nowych → STOP (zły plik)', () async {
    final (proposed, songs) = await _scanned();
    final back = roundTrip(songs);
    back.first.piosenkomatData = const PiosenkomatData(kind: _corr, threadId: 'm1');
    final result = reviewDiff(kind: _new, candidates: proposed, reviewed: back);
    expect(result.wrongKind, hasLength(1));
    expect(result.mustStop, isTrue);
  });

  test('dwie zachowane poprawki tej samej piosenki → STOP', () async {
    final book = bookWith([sampleSong(lyrics: 'Ala ma kota\nA kot ma Ale')]);
    final items = classifyBatch([
      msgFrom(await completeEmail(isNew: false, correctionTarget: 'tmp', song: sampleSong(lyrics: 'Ala ma kota\nA kot ma Ale\nX')), id: 'a'),
      msgFrom(await completeEmail(isNew: false, correctionTarget: 'tmp', song: sampleSong(lyrics: 'Ala ma kota\nA kot ma Ale\nY')), id: 'b'),
    ], book: book);
    expect(items.map((c) => c.destination), everyElement(Destination.candidateCorrection));
    final songs = [for (final c in items) c.song!..piosenkomatData = c.piosenkomatData()];
    assignUniqueIds(songs);
    final plan = RunPlan.fromClassified(items);
    final proposed = collectCandidates(plan, roundTrip(songs), _corr);
    final result = reviewDiff(kind: _corr, candidates: proposed, reviewed: roundTrip(songs));
    expect(result.duplicateTargets.keys, ['tmp']);
    expect(result.mustStop, isTrue);
    // Zostawiona jedna → OK.
    final one = reviewDiff(kind: _corr, candidates: proposed, reviewed: roundTrip([songs.first]));
    expect(one.mustStop, isFalse);
    expect(one.acceptedThreads, ['a']);
    expect(one.rejectedThreads, ['b']);
  });

  test('collectCandidates filtruje po rodzaju', () async {
    final items = classifyBatch([
      msgFrom(await completeEmail(song: sampleSong(title: 'Nowa', lyrics: 'Ala ma kota')), id: 'n'),
      msgFrom(await completeEmail(isNew: false, song: sampleSong(title: 'Popr', lyrics: 'Wlazl kotek')), id: 'c'),
    ], book: SongBook.empty);
    final plan = RunPlan.fromClassified(items);
    final songs = [for (final c in items) c.song!];
    expect(collectCandidates(plan, songs, _new).map((p) => p.threadId), ['n']);
    expect(collectCandidates(plan, songs, _corr).map((p) => p.threadId), ['c']);
  });

  test('ślad przeglądu zapisuje decyzje z rodzajem', () async {
    final (proposed, songs) = await _scanned();
    final result = reviewDiff(kind: _new, candidates: proposed, reviewed: roundTrip([songs.first]));
    final path = decisionsPathIn(tempDir().path);
    writeDecisions(path, [result]);

    final written = jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;
    final rejected = (written['songs'] as List)
        .cast<Map<String, dynamic>>()
        .where((d) => d['decision'] == 'rejected-after-review');
    expect(rejected.single['thread_id'], 'm2');
    expect(rejected.single['kind'], 'new');
  });
}

void _verdictTests() {
  test('przełącznik „nie wchodzi”: piosenka wraca w pliku, ale odpada', () async {
    final (proposed, songs) = await _scanned();
    final back = roundTrip(songs);
    // „Druga” zgaszona — zostaje w pliku, ale do śpiewnika nie wchodzi.
    // Po odczycie kolejność jest inna niż przy zapisie, więc szukamy po tytule.
    final second = back.firstWhere((s) => s.title == 'Druga');
    second.piosenkomatData =
        second.piosenkomatData!.copyWith(accepted: () => false);

    final r = reviewDiff(kind: _new, candidates: proposed, reviewed: back);
    expect(r.accepted.map((m) => m.reviewed.title), ['Pierwsza']);
    expect(r.turnedDown.map((m) => m.reviewed.title), ['Druga']);
    expect(r.removed, isEmpty, reason: 'nie skasowana, tylko zgaszona');
    expect(r.rejectedThreads, ['m2'], reason: 'dla etykiet to jedno i to samo');
    expect(r.mustStop, isFalse);
  });

  test('brak flagi znaczy „wchodzi” — stare pliki działają', () async {
    final (plan, songs) = await _run();
    final back = roundTrip(songs);
    expect(back.every((s) => s.piosenkomatData!.accepted == null), isTrue);
    final r = reviewDiff(
        kind: _new, candidates: collectCandidates(plan, back, _new), reviewed: back);
    expect(r.accepted.length, 2);
    expect(r.turnedDown, isEmpty);
  });

  test('odpowiedź do autora jedzie niezależnie od werdyktu', () async {
    final (proposed, songs) = await _scanned();
    final back = roundTrip(songs);
    final first = back.firstWhere((s) => s.title == 'Pierwsza');
    final second = back.firstWhere((s) => s.title == 'Druga');
    first.piosenkomatData = first.piosenkomatData!
        .copyWith(reviewNote: () => 'Dodałem, popraw literówkę.');
    second.piosenkomatData = second.piosenkomatData!.copyWith(
        accepted: () => false, reviewNote: () => 'Brakuje chwytów.');

    final r = reviewDiff(kind: _new, candidates: proposed, reviewed: back);
    expect(r.reviewNotes, {
      'm1': 'Dodałem, popraw literówkę.',
      'm2': 'Brakuje chwytów.',
    });
    expect(r.accepted.single.reviewed.title, 'Pierwsza',
        reason: 'uwaga nie wyrzuca ze śpiewnika — od tego jest przełącznik');

    // Ślad przeglądu niesie i werdykt, i odpowiedź: stąd bierze je `reply`.
    final path = '${tempDir().path}/decisions.json';
    writeDecisions(path, [r]);
    expect(readReviewNotes(path), {
      'm1': 'Dodałem, popraw literówkę.',
      'm2': 'Brakuje chwytów.',
    });
  });

  test('odpowiedź przeżywa zapis i odczyt pliku', () async {
    final (_, songs) = await _run();
    final pierwsza = songs.firstWhere((s) => s.title == 'Pierwsza');
    pierwsza.piosenkomatData = pierwsza.piosenkomatData!
        .copyWith(accepted: () => false, reviewNote: () => 'Dorzuć chwyty.');
    final back = roundTrip(songs);
    final first = back.firstWhere((s) => s.title == 'Pierwsza');
    expect(first.piosenkomatData!.accepted, isFalse);
    expect(first.piosenkomatData!.goesIn, isFalse);
    expect(first.piosenkomatData!.reviewNote, 'Dorzuć chwyty.');
    expect(back.firstWhere((s) => s.title == 'Druga').piosenkomatData!.goesIn,
        isTrue);
  });
}
