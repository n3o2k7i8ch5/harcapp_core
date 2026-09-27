import 'dart:io';

import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:piosenkomat/run_dir.dart';
import 'package:piosenkomat/cli.dart';
import 'package:piosenkomat/hrcpsng.dart';
import 'package:piosenkomat/model.dart';
import 'package:piosenkomat/plan.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Katalog tuż po `scan`: kandydaci obu rodzajów i puste miejsca na eksport.
String _scannedRun() {
  final dir = tempDir().path;
  for (final kind in SubmissionKind.values) {
    writeHrcpsng(RunDir(dir).candidates(kind), [sampleSong(id: 'o!_${kind.id}')],
        withPiosenkomatData: true);
    RunDir(dir).writeReviewedPlaceholder(kind);
  }
  return dir;
}

void main() {
  test('po scan żaden eksport nie jest gotowy', () {
    final dir = _scannedRun();
    expect(RunDir(dir).missingExports, [
      for (final kind in SubmissionKind.values) RunDir(dir).reviewed(kind),
    ]);
  });

  test('przejrzane same nowe: label reviewed i prepare stają na poprawkach', () async {
    final dir = _scannedRun();
    writeHrcpsng(RunDir(dir).reviewed(SubmissionKind.newSong), [sampleSong(id: 'o!_new')],
        withPiosenkomatData: true);

    expect(RunDir(dir).missingExports, [RunDir(dir).reviewed(SubmissionKind.correction)]);
    expect(await runPiosenkomat(['label', 'reviewed', dir]), 1);
    expect(await runPiosenkomat(['prepare', dir]), 1);
  });

  test('skasowany plik zwrotny to też brak eksportu', () {
    final dir = _scannedRun();
    writeHrcpsng(RunDir(dir).reviewed(SubmissionKind.newSong), const []);
    File(RunDir(dir).reviewed(SubmissionKind.correction)).deleteSync();
    expect(RunDir(dir).missingExports, [RunDir(dir).reviewed(SubmissionKind.correction)]);
  });

  test('eksport bez żadnej piosenki to „odrzucam wszystko”, nie brak eksportu', () {
    final dir = _scannedRun();
    for (final kind in SubmissionKind.values) {
      writeHrcpsng(RunDir(dir).reviewed(kind), const []);
    }
    expect(RunDir(dir).missingExports, isEmpty);
  });

  test('rodzaj bez kandydatów nie potrzebuje eksportu', () {
    final dir = tempDir().path;
    writeHrcpsng(RunDir(dir).candidates(SubmissionKind.newSong), [sampleSong()],
        withPiosenkomatData: true);
    writeHrcpsng(RunDir(dir).reviewed(SubmissionKind.newSong), [sampleSong()],
        withPiosenkomatData: true);
    expect(RunDir(dir).missingExports, isEmpty);
  });

  group('runda w Gmailu', () {
    final plan = RunPlan(
      createdAt: DateTime(2026),
      labelsByMessage: const {'a': [], 'b': []},
      songByThread: const {},
      messagesByThread: const {},
    );

    test('bez label scanned nie ma jej w Gmailu', () {
      expect(isRunInGmail(plan, {}), isFalse);
      // Obce etykiety innych mejli się nie liczą.
      expect(isRunInGmail(plan, {'x': {SongLabel.auto.label, SongLabel.readyToAdd.label}}), isFalse);
    });

    test('wystarczy jeden mejl ze znacznikiem automatu', () {
      expect(isRunInGmail(plan, {'b': {SongLabel.auto.label, SongLabel.added.label}}), isTrue);
    });

    test('etykieta postawiona ręcznie, bez song/auto, to nie label scanned', () {
      expect(isRunInGmail(plan, {'a': {SongLabel.readyToAdd.label}}), isFalse);
    });
  });

  group('robota do stracenia przy clean', () {
    test('sam wynik scan to żadna robota', () {
      final dir = _scannedRun();
      writeText(RunDir(dir).plan, '{}');
      writeText(RunDir(dir).report, 'raport');
      writeText('$dir/.DS_Store', 'x');
      expect(RunDir(dir).localReviewWork, isEmpty);
    });

    test('eksport, ślad decyzji i final-* są robotą', () {
      final dir = _scannedRun();
      writeHrcpsng(RunDir(dir).reviewed(SubmissionKind.newSong), [sampleSong()]);
      writeText(RunDir(dir).decisions, '{}');
      writeHrcpsng(RunDir(dir).finalSongs(SubmissionKind.newSong), [sampleSong()]);
      expect(RunDir(dir).localReviewWork,
          ['decisions.json', 'final-new.hrcpsng', 'reviewed-new.hrcpsng']);
    });
  });
}
