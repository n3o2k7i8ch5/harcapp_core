import 'dart:io';

import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
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
    writeHrcpsng(candidatesPathIn(dir, kind), [sampleSong(id: 'o!_${kind.id}')],
        withPiosenkomatData: true);
    writeReviewedPlaceholder(reviewedPathIn(dir, kind));
  }
  return dir;
}

void main() {
  test('po scan żaden eksport nie jest gotowy', () {
    final dir = _scannedRun();
    expect(missingExportsIn(dir), [
      for (final kind in SubmissionKind.values) reviewedPathIn(dir, kind),
    ]);
  });

  test('przejrzane same nowe: label reviewed i prepare stają na poprawkach', () async {
    final dir = _scannedRun();
    writeHrcpsng(reviewedPathIn(dir, SubmissionKind.newSong), [sampleSong(id: 'o!_new')],
        withPiosenkomatData: true);

    expect(missingExportsIn(dir), [reviewedPathIn(dir, SubmissionKind.correction)]);
    expect(await runPiosenkomat(['label', 'reviewed', dir]), 1);
    expect(await runPiosenkomat(['prepare', dir]), 1);
  });

  test('skasowany plik zwrotny to też brak eksportu', () {
    final dir = _scannedRun();
    writeHrcpsng(reviewedPathIn(dir, SubmissionKind.newSong), const []);
    File(reviewedPathIn(dir, SubmissionKind.correction)).deleteSync();
    expect(missingExportsIn(dir), [reviewedPathIn(dir, SubmissionKind.correction)]);
  });

  test('eksport bez żadnej piosenki to „odrzucam wszystko”, nie brak eksportu', () {
    final dir = _scannedRun();
    for (final kind in SubmissionKind.values) {
      writeHrcpsng(reviewedPathIn(dir, kind), const []);
    }
    expect(missingExportsIn(dir), isEmpty);
  });

  test('rodzaj bez kandydatów nie potrzebuje eksportu', () {
    final dir = tempDir().path;
    writeHrcpsng(candidatesPathIn(dir, SubmissionKind.newSong), [sampleSong()],
        withPiosenkomatData: true);
    writeHrcpsng(reviewedPathIn(dir, SubmissionKind.newSong), [sampleSong()],
        withPiosenkomatData: true);
    expect(missingExportsIn(dir), isEmpty);
  });

  group('runda w Gmailu', () {
    final plan = RunPlan(
      createdAt: DateTime(2026),
      labelsByMessage: const {'a': [], 'b': []},
      songByThread: const {},
      messagesByThread: const {},
    );

    test('bez label scanned nie ma jej w Gmailu', () {
      expect(isRunInGmail(plan, const {}), isFalse);
      // Obce etykiety innych mejli się nie liczą.
      expect(isRunInGmail(plan, const {'x': {kLabelAuto, kLabelReadyToAdd}}), isFalse);
    });

    test('wystarczy jeden mejl ze znacznikiem automatu', () {
      expect(isRunInGmail(plan, const {'b': {kLabelAuto, kLabelAdded}}), isTrue);
    });

    test('etykieta postawiona ręcznie, bez song/auto, to nie label scanned', () {
      expect(isRunInGmail(plan, const {'a': {kLabelReadyToAdd}}), isFalse);
    });
  });

  group('robota do stracenia przy clean', () {
    test('sam wynik scan to żadna robota', () {
      final dir = _scannedRun();
      writeText(planPathIn(dir), '{}');
      writeText(reportPathIn(dir), 'raport');
      writeText('$dir/.DS_Store', 'x');
      expect(localReviewWorkIn(dir), isEmpty);
    });

    test('eksport, ślad decyzji i final-* są robotą', () {
      final dir = _scannedRun();
      writeHrcpsng(reviewedPathIn(dir, SubmissionKind.newSong), [sampleSong()]);
      writeText(decisionsPathIn(dir), '{}');
      writeHrcpsng(finalPathIn(dir, SubmissionKind.newSong), [sampleSong()]);
      expect(localReviewWorkIn(dir),
          ['decisions.json', 'final-new.hrcpsng', 'reviewed-new.hrcpsng']);
    });
  });
}
