import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';

import 'model.dart';
import 'plan.dart';
import 'similarity.dart';

/// Po czym piosenka z `reviewed-*.hrcpsng` została związana ze zgłoszeniem.
enum MatchedBy {
  threadId('id wątku'),
  songId('id piosenki'),
  title('tytuł'),
  songText('tekst');

  const MatchedBy(this.text);
  final String text;
}

/// Piosenka, którą automat wstawił do pliku kandydatów, wraz z wątkiem —
/// to, z czym porównujemy plik zwrotny.
class ReviewCandidate {
  final String threadId;
  /// Wpis z planu przebiegu — id i tytuł.
  final PlannedSong planned;
  /// Odcisk do porównań awaryjnych. `null`, gdy piosenki nie ma w pliku
  /// (plan i plik się rozjechały).
  final SongProfile? profile;

  ReviewCandidate({
    required this.threadId,
    required this.planned,
    this.profile,
  });

  String get songId => planned.songId;
  String get title => planned.title;
}

/// Piosenka, która wróciła z przeglądu.
class Matched {
  final ReviewCandidate candidate;
  final MatchedBy matchedBy;
  final SongRaw reviewed;

  const Matched(this.candidate, this.matchedBy, this.reviewed);
}

/// Werdykt przeglądu. Piosenka wchodzi, gdy wróciła w pliku **i** nie ma
/// zgaszonego przełącznika; nie wróciła albo zgaszony → odpada. Plus to, co
/// każe się zatrzymać: z kandydatów można wywalać i edytować, nie dodawać.
///
/// To jedyne źródło prawdy o przeglądzie: z niego `review` przestawia etykiety
/// i składa `final-*`, a `finalize` sprawdza, że jedno i drugie jest aktualne.
class ReviewResult {
  final SubmissionKind kind;
  /// Piosenki, które wchodzą — każda, także kilka z jednego zgłoszenia
  /// (nowa rozbita na stronie na dwie).
  final List<Matched> accepted;
  /// Nie wróciła w pliku zwrotnym — skasowana przy przeglądzie.
  final List<ReviewCandidate> removed;
  /// Wróciła, ale z przełącznikiem „nie wchodzi”. Odpada tak samo jak
  /// [removed], ale wiemy o niej więcej — m.in. może nieść odpowiedź.
  final List<Matched> turnedDown;
  /// Co napisać autorom: id wątku → tekst z pola „Odpowiedź do autora”.
  /// Niezależne od werdyktu — i odrzucona, i przyjęta może coś nieść.
  final Map<String, String> reviewNotes;
  /// Piosenki z `reviewed`, których nie ma w kandydatach — obcy `thread_id`
  /// albo dorzucone na stronie. STOP.
  final List<SongRaw> foreign;
  /// Piosenki innego rodzaju niż plik (poprawka w `reviewed-new`). STOP.
  final List<SongRaw> wrongKind;
  /// Dwie zachowane poprawki tej samej piosenki w apce. STOP.
  final Map<String, List<String>> duplicateTargets;
  /// Kilka piosenek z jednego zgłoszenia, które się wykluczają: różne
  /// przełączniki, różne odpowiedzi do autora albo dwie zachowane kopie jednej
  /// poprawki. Wątek dostaje jedną etykietę, więc nie ma poprawnej
  /// interpretacji. Id wątku → co się gryzie. STOP.
  final Map<String, String> conflicts;

  const ReviewResult({
    required this.kind,
    required this.accepted,
    required this.removed,
    required this.foreign,
    required this.wrongKind,
    required this.duplicateTargets,
    this.conflicts = const {},
    this.turnedDown = const [],
    this.reviewNotes = const {},
  });

  bool get mustStop =>
      foreign.isNotEmpty ||
      wrongKind.isNotEmpty ||
      duplicateTargets.isNotEmpty ||
      conflicts.isNotEmpty;

  /// Wątki przyjęte — każdy raz, choćby wróciły z niego dwie piosenki.
  List<String> get acceptedThreads => {for (final m in accepted) m.candidate.threadId}.toList();

  /// Piosenki, które idą do `final-*`.
  List<SongRaw> get acceptedSongs => [for (final m in accepted) m.reviewed];
  /// Wszystko, co odpadło: skasowane i zgaszone przełącznikiem — dla etykiet
  /// to jedno i to samo.
  List<ReviewCandidate> get rejected =>
      {...removed, for (final m in turnedDown) m.candidate}.toList();
  List<String> get rejectedThreads => [for (final c in rejected) c.threadId];
}

/// Co automat zaproponował dla danego rodzaju: plan jest kręgosłupem (wiąże
/// piosenkę z wątkiem), plik dokłada tekst do porównań awaryjnych.
List<ReviewCandidate> collectCandidates(
  RunPlan plan,
  List<SongRaw> candidateSongs,
  SubmissionKind kind,
) {
  final byId = {for (final s in candidateSongs) s.id: s};

  return [
    for (final e in plan.songByThread.entries)
      if (e.value.kind == kind)
        ReviewCandidate(
          threadId: e.key,
          planned: e.value,
          profile: switch (byId[e.value.songId]) { final s? => SongProfile(s), null => null },
        ),
  ];
}

String? _threadOf(SongRaw s) =>
    s.piosenkomatData?.threadId ?? s.contributorData?.emailThreadId;

/// Różnica „zaproponowane minus to, co wróciło”. Dopasowanie kaskadą: id
/// wątku, potem id piosenki, tytuł i wreszcie tekst — bo przy przeglądzie
/// tytuł i chwyty mogły się zmienić, a strona mogła zgubić `thread_id`.
ReviewResult reviewDiff({
  required SubmissionKind kind,
  required List<ReviewCandidate> candidates,
  required List<SongRaw> reviewed,
}) {
  final matched = <ReviewCandidate, List<Matched>>{};
  final foreign = <SongRaw>[];
  final wrongKind = <SongRaw>[];

  for (final song in reviewed) {
    final songKind = song.piosenkomatData?.kind;
    if (songKind != null && songKind != kind) {
      wrongKind.add(song);
      continue;
    }
    final hit = _match(song, candidates);
    if (hit == null) {
      foreign.add(song);
      continue;
    }
    matched.putIfAbsent(hit.candidate, () => []).add(hit);
  }

  // Przełącznik z edytora. Brak flagi znaczy „wchodzi”, więc skasowanie
  // z pliku dalej działa jak odrzut.
  bool goesInOf(Matched m) => m.reviewed.piosenkomatData?.goesIn ?? true;
  String? noteOf(Matched m) => switch (m.reviewed.piosenkomatData?.reviewNote?.trim()) {
        final note? when note.isNotEmpty => note,
        _ => null,
      };

  final goesIn = <Matched>[];
  final turnedDown = <Matched>[];
  final reviewNotes = <String, String>{};
  final conflicts = <String, String>{};
  for (final MapEntry(key: candidate, value: hits) in matched.entries) {
    final thread = candidate.threadId;
    // Kilka piosenek z jednego zgłoszenia: nowa rozbita na stronie na dwie
    // wchodzi cała, ale sprzeczności nie rozstrzygamy za Ciebie.
    final verdicts = {for (final m in hits) goesInOf(m)};
    final notes = {for (final m in hits) if (noteOf(m) case final note?) note};
    if (verdicts.length > 1) {
      conflicts[thread] = '„${candidate.title}”: kopie z różnym przełącznikiem';
      continue;
    }
    if (notes.length > 1) {
      conflicts[thread] = '„${candidate.title}”: kopie z różną odpowiedzią do autora';
      continue;
    }
    if (kind == SubmissionKind.correction && verdicts.single && hits.length > 1) {
      conflicts[thread] = '„${candidate.title}”: ${hits.length} zachowane kopie jednej poprawki';
      continue;
    }
    (verdicts.single ? goesIn : turnedDown).addAll(hits);
    // Odpowiedź do autora niezależnie od werdyktu — i odrzucona, i przyjęta
    // może coś nieść.
    if (notes.singleOrNull case final note?) reviewNotes[thread] = note;
  }

  // Jedna poprawka na piosenkę: dwie zachowane z tym samym celem nie mają
  // poprawnej interpretacji. Liczą się tylko te, które faktycznie wchodzą.
  final byTarget = <String, List<String>>{};
  if (kind == SubmissionKind.correction) {
    for (final m in goesIn) {
      final target = m.reviewed.piosenkomatData?.correctionTarget;
      if (target != null) byTarget.putIfAbsent(target, () => []).add(m.reviewed.title);
    }
  }

  return ReviewResult(
    kind: kind,
    accepted: goesIn,
    removed: [for (final c in candidates) if (!matched.containsKey(c)) c],
    turnedDown: turnedDown,
    reviewNotes: reviewNotes,
    foreign: foreign,
    wrongKind: wrongKind,
    duplicateTargets: {
      for (final e in byTarget.entries)
        if (e.value.length > 1) e.key: e.value,
    },
    conflicts: conflicts,
  );
}

Matched? _match(SongRaw song, List<ReviewCandidate> candidates) {
  final threadId = _threadOf(song);
  if (threadId != null) {
    // Wątek to jedno zgłoszenie, więc i jeden kandydat. Id wątku spoza
    // kandydatów: obca, bez zgadywania po tytule — inaczej piosenka z innego
    // przebiegu przeszłaby jako „przyjęta”.
    final hit = candidates.where((c) => c.threadId == threadId).firstOrNull;
    return hit == null ? null : Matched(hit, MatchedBy.threadId, song);
  }
  // Bez id wątku piosenka musi się obronić sama: id, tytuł albo tekst.
  final hit = _narrow(song, candidates);
  return hit == null ? null : Matched(hit.$1, hit.$2, song);
}

(ReviewCandidate, MatchedBy)? _narrow(SongRaw song, List<ReviewCandidate> candidates) {
  // Dokładnie: `o!_barka@sdm` i `o!_barka@sdm~2` to dwie różne piosenki z paczki.
  final byId = [for (final c in candidates) if (c.songId == song.id) c];
  if (byId.length == 1) return (byId.single, MatchedBy.songId);

  final key = searchableString(song.title);
  final byTitle = [
    for (final c in candidates) if (searchableString(c.title) == key) c,
  ];
  if (byTitle.length == 1) return (byTitle.single, MatchedBy.title);

  // Po przeglądzie tekst mógł się zmienić (poprawiona literówka, dopisana
  // zwrotka), ale to ma być dalej ta sama piosenka — ta sama definicja, co
  // przy wykrywaniu duplikatów.
  final profile = SongProfile(song);
  ReviewCandidate? best;
  var bestScore = -1.0;
  for (final c in byTitle.isEmpty ? candidates : byTitle) {
    final other = c.profile;
    if (other == null) continue;
    final evidence = compare(profile, other);
    if (!(levelOf(evidence)?.isSameSong ?? false)) continue;
    final score = similarityScore(evidence);
    if (score >= bestScore) {
      best = c;
      bestScore = score;
    }
  }
  return best == null ? null : (best, MatchedBy.songText);
}

/// Bezpieczniki na zły plik zwrotny: pusty eksport i „odrzucona większość”
/// prawie zawsze znaczą, że podmieniony został nie ten plik, co trzeba.
/// `null` = w porządku.
String? reviewSafetyError(
  ReviewResult result, {
  required String reviewedPath,
  required int reviewedCount,
  required int candidateCount,
}) {
  if (reviewedCount == 0) {
    return '$reviewedPath nie zawiera żadnej piosenki — to wygląda na pomyłkę. '
        'Jeśli naprawdę odrzucasz wszystko: --force.';
  }
  final rejectedCount = result.rejected.length;
  if (rejectedCount * 2 > candidateCount) {
    return 'Odrzucone to ponad połowa ($rejectedCount/$candidateCount) — '
        'sprawdź, czy podmieniony jest właściwy plik i czy przełącznik nie zgasł '
        'hurtem. Jeśli tak ma być: --force.';
  }
  return null;
}

/// Co po przeglądzie dochodzi i co schodzi z każdej wiadomości wątku —
/// liczone od tego, co mejle mają **teraz** ([current]), nie od stanu po
/// `scan`. Dzięki temu `review` można odpalać ile razy trzeba: zmiana zdania
/// („nie” → „tak” i odwrotnie) przestawia etykietę, a to, co już się zgadza,
/// zostaje nietknięte.
///
/// Tekst do autora idzie raz na przegląd. Wątek z [SongLabel.waitingForAuthor]
/// ma odpowiedź już wysłaną, więc `reply/review-note` nie wraca — takie wątki
/// lądują w `alreadyReplied`, żeby powiedzieć o nich wprost. Stan bierzemy
/// z Gmaila, nie z katalogu przebiegu.
({Map<String, LabelChange> changes, List<String> alreadyReplied}) reviewLabelChanges(
  List<ReviewResult> results,
  RunPlan plan,
  Map<String, Set<String>> current,
) {
  final changes = <String, LabelChange>{};
  final alreadyReplied = <String>[];
  for (final r in results) {
    final verdicts = {
      for (final thread in r.acceptedThreads) thread: true,
      for (final c in r.rejected) c.threadId: false,
    };
    for (final MapEntry(key: thread, value: accepted) in verdicts.entries) {
      final ids = plan.messagesOf(thread);
      final threadLabels = {for (final id in ids) ...?current[id]};
      final hasNote = r.reviewNotes.containsKey(thread);
      final replied = threadLabels.contains(SongLabel.waitingForAuthor.label);
      if (hasNote && replied) alreadyReplied.add(thread);
      // Odrzucona z wyjaśnieniem to nie koniec sprawy, tylko pytanie do
      // autora: bez „rejected”, bo piosenka może jeszcze wrócić z chwytami.
      final want = {
        if (accepted) SongLabel.readyToAdd.label,
        if (!accepted && !hasNote) SongLabel.rejectedAfterReview.label,
        if (hasNote && !replied) SongLabel.replyReviewNote.label,
      };
      final drop = {
        SongLabel.readyToAdd.label,
        SongLabel.rejectedAfterReview.label,
        SongLabel.replyReviewNote.label,
        ...kNeedsReviewLabels,
      }..removeAll(want);
      for (final id in ids) {
        final has = current[id] ?? const <String>{};
        final add = [for (final l in want) if (!has.contains(l)) l];
        final remove = [for (final l in drop) if (has.contains(l)) l];
        if (add.isNotEmpty || remove.isNotEmpty) changes[id] = (add, remove);
      }
    }
  }
  return (changes: changes, alreadyReplied: alreadyReplied);
}
