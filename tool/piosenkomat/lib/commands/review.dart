import 'dart:io';

import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:path/path.dart' as p;

import '../hrcpsng.dart';
import '../mailbox.dart';
import '../model.dart';
import '../people.dart';
import '../plan.dart';
import '../reply.dart';
import '../review.dart';
import '../run_dir.dart';
import 'command.dart';

class ReviewCommand extends PiosenkomatCommand {
  ReviewCommand(super.connectMailbox, super.root) {
    addForceFlag('Pomiń bezpieczniki (pusty eksport, odrzucona większość)');
    addGmailOptions();
    addPushFlag('Przestaw etykiety, zapisz final-* i people.dart, załóż szkice (bez tej flagi tylko lista)');
  }

  @override
  final name = 'review';
  @override
  final description = 'Po przeglądzie na stronie: piosenka w reviewed-* → „${SongLabel.readyToAdd.label}”, '
      'skasowana albo ze zgaszonym przełącznikiem → „${SongLabel.rejectedAfterReview.label}” '
      '(z odpowiedzią do autora — „${SongLabel.replyReviewNote.label}”). Składa final-*.hrcpsng '
      'do wklejenia w all_songs i people.dart, zakłada szkice z tekstem do autora. Wolno powtarzać. '
      'Z kandydatów można wywalać i edytować, nie dodawać: obca piosenka, zły rodzaj albo '
      'sprzeczne kopie → STOP.';

  @override
  Future<int> execute() async {
    final run = runDir;
    final mailbox = await connect();
    final current = await mailbox.songLabelsByMessage();
    final plan = pushedRun(current);
    requireExports(run);
    if (!isRunInGmail(plan, current)) {
      throw Stop('Przebieg ${plan.id} nie ma etykiet w Gmailu (zdjęte ręcznie?). '
          'Cofnij go: ./piosenkomat unlabel --push');
    }
    final results = reviewRun(run, plan, safety: !force);

    final labeling = reviewLabelChanges(results, plan, current);
    for (final thread in labeling.alreadyReplied) {
      stdout.writeln('  JUŻ ODPISANE  ${plan.threads[thread]?.song?.title ?? ''}  [$thread] — '
          'tekst do autora już wysłany; zmianę wyślij ręcznie');
    }
    final changes = applicableChanges(labeling.changes, current);
    final skipped = labeling.changes.length - changes.length;
    if (skipped > 0) {
      stdout.writeln('Pomijam ${emailCount(skipped)} bez etykiet automatu '
          'albo już domknięte.');
    }
    stdout.writeln('Etykiety do przestawienia: ${emailCount(changes.length)}');

    // `final-*` i osoby z tego samego przeglądu, co etykiety.
    final otherEmails = otherEmailsBySender(plan);
    final sources = <ContributorSource>[];
    final finals = <SubmissionKind, String>{};
    for (final result in results) {
      sources.addAll(contributorSourcesOf(result.acceptedSongs, otherEmailsBySender: otherEmails));
      final file = result.finalFile();
      finals[result.kind] = file.content;
      _printFinal(run, result, file.songs, file.replacements);
    }

    final notes = {for (final r in results) ...r.reviewNotes};
    final threads = replyThreadsOf(plan, labelsAfter(current, changes), notes);
    if (push) {
      for (final e in finals.entries) {
        writeText(run.finalSongs(e.key), e.value);
      }
      _writePeople(run, collectPeople(sources));
      await mailbox.ensureToolLabels();
      await applyLabelChanges(mailbox, changes);
    }
    final written = run.readDrafts();
    await syncDrafts(mailbox, threads, push: push, written: written);
    if (push) run.writeDrafts(written);
    if (dryRun('przestawi etykiety, zapisze final-* i people.dart i założy szkice')) return 0;
    stdout.writeln('\nDalej: wklej final-*.hrcpsng do all_songs, potem ./piosenkomat finalize --push. '
        'Odpowiedzi do autorów: ./piosenkomat reply --push, kiedy przejrzysz szkice.');
    return 0;
  }
}

/// Przegląd jednego rodzaju: wynik i to, z czego powstał.
typedef KindReview = ({ReviewResult result, int candidateCount, int reviewedCount, String reviewedPath});

/// Przegląd każdego rodzaju z kandydatami — kandydaci kontra plik zwrotny,
/// bez wypisywania i bez STOP-ów. Po cichu, bo woła go też `status`.
List<KindReview> kindReviews(RunDir run, RunPlan plan) {
  final out = <KindReview>[];
  for (final kind in run.kinds) {
    final candidates = collectCandidates(plan, readHrcpsng(run.candidates(kind)), kind);
    if (candidates.isEmpty) continue;
    final reviewedPath = run.reviewed(kind);
    final reviewed = readHrcpsng(reviewedPath);
    out.add((
      result: reviewDiff(kind: kind, candidates: candidates, reviewed: reviewed),
      candidateCount: candidates.length,
      reviewedCount: reviewed.length,
      reviewedPath: reviewedPath,
    ));
  }
  return out;
}

/// Przegląd każdego rodzaju, z wypisaniem ([kindReviews]). Jedna droga dla
/// `review` i `finalize`; eksport, z którego nie da się wyczytać werdyktu →
/// [Stop]. [safety]: bezpieczniki na zły plik (pusty eksport, odrzucona
/// większość) — `finalize` ich nie powtarza, bo przeszły, albo zostały
/// świadomie pominięte, w `review`.
List<ReviewResult> reviewRun(RunDir run, RunPlan plan, {required bool safety}) {
  final results = <ReviewResult>[];
  for (final (:result, :candidateCount, :reviewedCount, :reviewedPath) in kindReviews(run, plan)) {
    final kind = result.kind;
    stdout.writeln('${kind.groupName}: ${plural(candidateCount, 'kandydat', 'kandydaci', 'kandydatów')}, '
        '$reviewedCount w $reviewedPath');
    _printReview(result);

    if (result.mustStop) {
      _printStop(result, kind);
      throw const Stop('Popraw eksport i odpal ponownie.');
    }
    if (safety) {
      final error = reviewSafetyError(result,
          reviewedPath: reviewedPath,
          reviewedCount: reviewedCount,
          candidateCount: candidateCount);
      if (error != null) throw Stop(error);
    }
    results.add(result);
  }
  return results;
}

/// Czym Gmail i `out/run/` rozjechały się z eksportem, który leży teraz
/// w `reviewed-*` — co przestawiłby `review --push`: etykiety, `final-*`,
/// szkice odpowiedzi. Pusto — przegląd aktualny. Jedna reguła dla `finalize`
/// (staje) i `status` (mówi, co dalej).
Future<List<String>> staleReview(Mailbox mailbox, RunDir run, RunPlan plan, List<ReviewResult> results,
    Map<String, Set<String>> current) async {
  final notes = {for (final r in results) ...r.reviewNotes};
  final drafts = await planDrafts(mailbox, replyThreadsOf(plan, current, notes), written: run.readDrafts());
  return [
    if (applicableChanges(reviewLabelChanges(results, plan, current).changes, current).isNotEmpty)
      'etykiety w Gmailu',
    for (final r in results)
      if (File(run.finalSongs(r.kind)) case final file
          when !file.existsSync() || file.readAsStringSync() != r.finalFile().content)
        p.basename(file.path),
    if (draftChanges(drafts) > 0) 'szkice odpowiedzi',
  ];
}

/// `review` i `finalize` ruszają dopiero z kompletem eksportów: pusty albo
/// brakujący plik zwrotny to przegląd, którego jeszcze nie było, a nie
/// „wszystko weszło”.
void requireExports(RunDir run) {
  final missing = run.missingExports;
  if (missing.isEmpty) return;
  for (final path in missing) {
    stderr.writeln('  BRAK EKSPORTU  $path');
  }
  throw const Stop('Zapisz tam eksport ze strony i odpal ponownie.');
}

/// Co weszło, co wypadło, co rozpoznane inaczej niż po id wątku.
void _printReview(ReviewResult result) {
  stdout
    ..writeln('  WCHODZI    ${result.accepted.length}')
    ..writeln('  ODRZUCONE  ${result.rejected.length}');
  for (final c in result.removed) {
    stdout.writeln('    ODRZUĆ  ${c.title}  [${c.threadId}]');
  }
  for (final m in result.turnedDown) {
    final hasReviewNote = result.reviewNotes.containsKey(m.candidate.threadId);
    stdout.writeln('    ODRZUĆ  ${m.reviewed.title}  [${m.candidate.threadId}]'
        '  (przełącznik${hasReviewNote ? ', z odpowiedzią' : ''})');
  }
  final byOther = [
    for (final m in result.accepted)
      if (m.matchedBy != MatchedBy.threadId) m,
  ];
  if (byOther.isNotEmpty) {
    stdout.writeln('  Rozpoznane inaczej niż po id wątku '
        '(tytuł mógł się zmienić przy przeglądzie): ${byOther.length}');
    for (final m in byOther) {
      stdout.writeln('    ${m.matchedBy.text.padRight(12)} ${m.candidate.title}'
          '${m.reviewed.title == m.candidate.title ? '' : ' → ${m.reviewed.title}'}');
    }
  }
}

void _printStop(ReviewResult result, SubmissionKind kind) {
  for (final s in result.foreign) {
    stderr.writeln('  OBCA    ${s.title} — nie ma jej w kandydatach '
        '(z candidates można wywalać i edytować, nie dodawać)');
  }
  for (final s in result.wrongKind) {
    stderr.writeln('  ZŁY PLIK ${s.title} — to '
        '${s.piosenkomatData!.kind.itemName}, '
        'a plik jest na ${kind.groupName.toLowerCase()}');
  }
  for (final e in result.duplicateTargets.entries) {
    stderr.writeln('  DWIE POPRAWKI ${e.key}: ${e.value.join(' / ')} — '
        'podmienić można tylko jedną');
  }
  for (final e in result.conflicts.entries) {
    stderr.writeln('  SPRZECZNE KOPIE ${e.value} [${e.key}] — zostaw jedną albo wyrównaj');
  }
}

void _printFinal(
  RunDir run,
  ReviewResult result,
  List<SongRaw> songs,
  List<Replacement> replacements,
) {
  stdout.writeln('${result.kind.groupName}: '
      '${plural(songs.length, 'piosenka', 'piosenki', 'piosenek')} → ${run.finalSongs(result.kind)}');
  if (result.turnedDown.isNotEmpty) {
    stdout.writeln('  pominięto ${result.turnedDown.length} z przełącznikiem „nie wchodzi”');
  }
  if (result.kind != SubmissionKind.correction) return;
  for (final r in replacements) {
    stdout.writeln('  podmień ${r.id}  ←  ${r.title}'
        '${r.guessed ? '   (cel ZGADNIĘTY — sprawdź, zanim podmienisz)' : ''}');
  }
  final noTarget = songs.length - replacements.length;
  if (noTarget > 0) {
    stdout.writeln('  $noTarget bez celu (${SongIssue.noTargetInApp.id}) — te dodasz jak nowe '
        'albo podmienisz ręcznie');
  }
}

void _writePeople(RunDir run, PeopleReport people) {
  writePeopleDart(run.people, people);
  stdout.writeln('Osoby dodające: ${people.newContributors.length} nowych → ${run.people}'
      '${people.knownByEmail.isEmpty ? '' : ', ${people.knownByEmail.length} już w data.dart'}'
      '${people.knownWithNewEmails.isEmpty ? '' : ', ${people.knownWithNewEmails.length} z nowym adresem do dopisania'}'
      '${people.ambiguous.isEmpty ? '' : ', ${people.ambiguous.length} do sprawdzenia (adresy z różnych wpisów)'}'
      '${people.anonymousByEmail.isEmpty ? '' : ', ${people.anonymousByEmail.length} bez karty osoby'}');
  if (people.senderNotContributorByEmail.isNotEmpty) {
    stdout.writeln('${people.senderNotContributorByEmail.length} zgłoszeń '
        'w cudzym imieniu — osobę dodającą przypisz ręcznie '
        '(adres nadawcy jest tylko do odpisania).');
  }
  if (people.newContributors.isNotEmpty) {
    stdout.writeln('Doklej nowe do lib/values/people/data.dart, '
        'zanim wkleisz piosenki do all_songs.');
  }
}
