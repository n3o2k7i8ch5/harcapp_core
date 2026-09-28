import 'dart:io';

import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:piosenkomat/run_dir.dart';
import 'package:piosenkomat/cli.dart';
import 'package:piosenkomat/hrcpsng.dart';
import 'package:piosenkomat/model.dart';
import 'package:piosenkomat/plan.dart';
import 'package:test/test.dart';

import 'fake_mailbox.dart';
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

/// To samo jako przebieg w `root/out/run/`, już w Gmailu (po `scan --push`).
String _openRun() {
  final root = tempDir().path;
  final run = RunDir.current(root: root);
  for (final kind in SubmissionKind.values) {
    writeHrcpsng(run.candidates(kind), [sampleSong(id: 'o!_${kind.id}')], withPiosenkomatData: true);
    run.writeReviewedPlaceholder(kind);
  }
  writePlan(run.plan, RunPlan(
    id: 'test',
    createdAt: DateTime(2026),
    labelsByMessage: const {},
    songByThread: const {},
    messagesByThread: const {},
  ).pushed(DateTime(2026)));
  return root;
}

void main() {
  test('po scan żaden eksport nie jest gotowy', () {
    final dir = _scannedRun();
    expect(RunDir(dir).missingExports, [
      for (final kind in SubmissionKind.values) RunDir(dir).reviewed(kind),
    ]);
  });

  test('przejrzane same nowe: review i finalize stają na poprawkach', () async {
    final root = _openRun();
    final run = RunDir.current(root: root);
    writeHrcpsng(run.reviewed(SubmissionKind.newSong), [sampleSong(id: 'o!_new')],
        withPiosenkomatData: true);

    expect(run.missingExports, [run.reviewed(SubmissionKind.correction)]);
    Future<int> cli(List<String> args) =>
        runPiosenkomat(args, root: root, connect: (_) async => FakeMailbox());
    expect(await cli(['review']), 1);
    expect(await cli(['finalize']), 1);
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
      id: 'test',
      createdAt: DateTime(2026),
      labelsByMessage: const {'a': [], 'b': []},
      songByThread: const {},
      messagesByThread: const {},
    );

    test('bez scan --push nie ma jej w Gmailu', () {
      expect(isRunInGmail(plan, {}), isFalse);
      // Obce etykiety innych mejli się nie liczą.
      expect(isRunInGmail(plan, {'x': {SongLabel.auto.label, SongLabel.readyToAdd.label}}), isFalse);
    });

    test('wystarczy jeden mejl ze znacznikiem automatu', () {
      expect(isRunInGmail(plan, {'b': {SongLabel.auto.label, SongLabel.added.label}}), isTrue);
    });

    test('etykieta postawiona ręcznie, bez song/auto, to nie scan --push', () {
      expect(isRunInGmail(plan, {'a': {SongLabel.readyToAdd.label}}), isFalse);
    });
  });

  group('robota z przeglądu (unlabel jej nie skasuje bez --force)', () {
    test('sam wynik scan to żadna robota', () {
      expect(RunDir(_scannedRun()).hasReviewWork, isFalse);
    });

    test('zapisany eksport to robota — także „odrzucam wszystko”', () {
      final dir = _scannedRun();
      writeHrcpsng(RunDir(dir).reviewed(SubmissionKind.newSong), const []);
      expect(RunDir(dir).hasReviewWork, isTrue);
    });
  });
}
