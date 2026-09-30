import 'dart:io';

import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:path/path.dart' as p;

import '../hrcpsng.dart';
import '../mailbox.dart';
import '../model.dart';
import '../report.dart';
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
    final mailbox = await connect();
    final current = await mailbox.songLabelsByMessage();
    final plan = pushedRun(current);

    final waiting = plan.threadsWith(current, SongLabel.needsReview);
    if (waiting.isNotEmpty) {
      throw Stop('Na przegląd czeka ${plural(waiting.length, 'zgłoszenie', 'zgłoszenia', 'zgłoszeń')} '
          '(„${SongLabel.needsReview.label}”). Najpierw: ./piosenkomat review --push');
    }
    requireExports(run);
    final results = reviewRun(run, plan, safety: false);
    // Przegląd ma być aktualny: etykiety, `final-*` i szkice z tego eksportu,
    // który leży teraz w `reviewed-*` — inaczej domknęlibyśmy coś innego, niż
    // weszło, a tekstu zmienionego na stronie po archiwizacji nie przeliczy
    // już nikt.
    final stale = await staleReview(mailbox, run, plan, results, current);
    if (stale.isNotEmpty) {
      throw Stop('Przegląd nieaktualny — eksport zmienił się po review --push '
          '(nie zgadzają się: ${stale.join(', ')}). Najpierw: ./piosenkomat review --push');
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
    final finals = [for (final result in results) ...result.finalFile().songs];
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
