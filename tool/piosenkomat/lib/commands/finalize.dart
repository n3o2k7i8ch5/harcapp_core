import 'dart:io';

import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:path/path.dart' as p;

import '../hrcpsng.dart';
import '../mailbox.dart';
import '../model.dart';
import '../reply.dart';
import '../report.dart';
import '../review.dart';
import '../run_dir.dart';
import '../similarity.dart';
import 'command.dart';
import 'review.dart';

class FinalizeCommand extends PiosenkomatCommand {
  FinalizeCommand(super.connectMailbox, super.root) {
    addSongsDbOption();
    addForceFlag('Domknij mimo piosenek z final-*, których nie widać w all_songs');
    addGmailOptions();
    addPushFlag('Oznacz „${SongLabel.added.label}” i przenieś przebieg do archive/ '
        '(bez tej flagi tylko lista)');
  }

  @override
  final name = 'finalize';
  @override
  final description = 'Koniec przebiegu, po wklejeniu final-*.hrcpsng do all_songs: mejle '
      'z „${SongLabel.readyToAdd.label}” → „${SongLabel.added.label}” + przeczytane, a out/run/ → '
      'archive/<przebieg>/ z summary.md. Staje, gdy coś czeka na przegląd, przegląd jest '
      'nieaktualny (etykiety, final-* albo szkice nie zgadzają się z eksportem) albo piosenek '
      'z final-* nie ma w all_songs. Odpowiedzi do autorów czekają dalej w szkicach — nie blokują.';

  @override
  Future<int> execute() async {
    final run = runDir;
    final plan = pushedRun();
    final mailbox = await connect();
    final current = await mailbox.songLabelsByMessage();

    final waiting = plan.threadsWith(current, SongLabel.needsReview);
    if (waiting.isNotEmpty) {
      throw Stop('Na przegląd czeka ${plural(waiting.length, 'zgłoszenie', 'zgłoszenia', 'zgłoszeń')} '
          '(„${SongLabel.needsReview.label}”). Najpierw: ./piosenkomat review --push');
    }
    requireExports(run);
    final results = reviewRun(run, plan, safety: false);
    // Przegląd ma być aktualny: etykiety i `final-*` z tego eksportu, który
    // leży teraz w `reviewed-*` — inaczej domknęlibyśmy coś innego, niż weszło.
    if (applicableChanges(reviewLabelChanges(results, plan, current).changes, current).isNotEmpty) {
      throw const Stop('Etykiety w Gmailu nie zgadzają się z eksportem — przegląd nieaktualny. '
          'Najpierw: ./piosenkomat review --push');
    }
    // Szkice też: tekst zmieniony na stronie po `review --push` zostałby
    // w Gmailu po staremu, a po archiwizacji nie przeliczy go już nikt.
    final notes = {for (final r in results) ...r.reviewNotes};
    final stale = await syncDrafts(mailbox, replyThreadsOf(plan, current, notes),
        push: false, written: run.readDrafts());
    if (stale > 0) {
      throw const Stop('Szkice w Gmailu nie zgadzają się z eksportem (wyżej, co by się zmieniło). '
          'Najpierw: ./piosenkomat review --push');
    }
    final summary = formatRunSummary(
      plan: plan,
      results: results,
      repliesWaiting: [
        for (final thread in plan.threads.keys)
          if (plan.labelsOfThread(thread, current).any(kReplyQueueLabels.contains)) thread,
      ],
      finalizedAt: DateTime.now(),
    );
    final finals = <SongRaw>[];
    for (final result in results) {
      final expected = result.finalFile();
      final path = run.finalSongs(result.kind);
      final file = File(path);
      if (!file.existsSync() || file.readAsStringSync() != expected.content) {
        throw Stop('$path nie jest z ostatniego przeglądu. Najpierw: ./piosenkomat review --push');
      }
      finals.addAll(expected.songs);
    }

    final missing = _notInAllSongs(loadSongBook(), finals);
    for (final m in missing) {
      stderr.writeln('  NIE MA W ALL_SONGS  $m');
    }
    if (missing.isNotEmpty && !force) {
      throw const Stop('Wklej final-*.hrcpsng do all_songs i odpal ponownie (--force, jeśli świadomie inaczej).');
    }

    stdout
      ..writeln()
      ..write(summary);
    final ready = [
      for (final id in plan.labelsByMessage.keys)
        if (hasToolLabel(current[id] ?? const {}, SongLabel.readyToAdd)) id,
    ];
    final archive = archivePath(plan.id, root: root);
    if (dryRun('oznaczy ${emailCount(ready.length)} jako „${SongLabel.added.label}”, '
        'zapisze to podsumowanie w summary.md i przeniesie przebieg do $archive')) {
      return 0;
    }

    await mailbox.ensureToolLabels();
    await applyLabelChanges(mailbox, {
      for (final id in ready)
        id: withReadOnClose(([SongLabel.added.label], [SongLabel.readyToAdd.label]), current: current[id]!),
    });
    writeText(run.summary, summary);
    Directory(p.dirname(archive)).createSync(recursive: true);
    Directory(run.path).renameSync(archive);
    stdout.writeln('Przebieg ${plan.id} domknięty → $archive. '
        'Można zaczynać kolejny: ./piosenkomat scan --push');
    return 0;
  }
}

/// Piosenki z `final-*`, których nie ma w śpiewniku w tej postaci: brak id
/// albo pod nim inna wersja. Poprawka ma już id poprawianej piosenki, więc
/// liczy się dopiero jej nowa treść.
List<String> _notInAllSongs(SongBook book, List<SongRaw> songs) => [
      for (final s in songs)
        if (book.matchTo(s.id, SongProfile(s)) case final m when m?.level != MatchLevel.identical)
          m == null ? '${s.id}  „${s.title}” — nie ma tego id' : '${s.id}  „${s.title}” — pod tym id inna wersja',
    ];
