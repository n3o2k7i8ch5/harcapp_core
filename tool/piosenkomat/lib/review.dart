import 'dart:convert';
import 'dart:io';

import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';

import 'hrcpsng.dart';
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
  final String songId;
  final String title;
  final String sender;
  /// Puste, gdy piosenki nie ma w pliku (plan i plik się rozjechały).
  final Set<String> words;

  ReviewCandidate({
    required this.threadId,
    required this.songId,
    required this.title,
    this.sender = '',
    this.words = const {},
  });
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
class ReviewResult {
  final SubmissionKind kind;
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

  const ReviewResult({
    required this.kind,
    required this.accepted,
    required this.removed,
    required this.foreign,
    required this.wrongKind,
    required this.duplicateTargets,
    this.turnedDown = const [],
    this.reviewNotes = const {},
  });

  bool get mustStop =>
      foreign.isNotEmpty || wrongKind.isNotEmpty || duplicateTargets.isNotEmpty;

  List<String> get acceptedThreads => [for (final m in accepted) m.candidate.threadId];
  /// Wszystko, co odpadło: skasowane i zgaszone przełącznikiem — dla etykiet
  /// to jedno i to samo.
  List<ReviewCandidate> get rejected =>
      [...removed, for (final m in turnedDown) m.candidate];
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
  SongRaw? find(String songId) =>
      byId[songId] ??
      candidateSongs.where((s) => s.id.split('~').first == songId).firstOrNull;

  return [
    for (final e in plan.songByThread.entries)
      if (e.value.kind == kind)
        ReviewCandidate(
          threadId: e.key,
          songId: e.value.songId,
          title: e.value.title,
          sender: e.value.sender,
          words: textWords(find(e.value.songId)?.text ?? ''),
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
  final matched = <ReviewCandidate, Matched>{};
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
    // Kilka zatwierdzonych na jedno zgłoszenie (np. rozbite na stronie):
    // pierwsze dopasowanie wystarczy, żeby zgłoszenie uznać za przyjęte.
    matched.putIfAbsent(hit.candidate, () => hit);
  }

  // Przełącznik z edytora. Brak flagi znaczy „wchodzi”, więc skasowanie
  // z pliku dalej działa jak odrzut.
  final goesIn = <Matched>[];
  final turnedDown = <Matched>[];
  for (final m in matched.values) {
    (m.reviewed.piosenkomatData?.goesIn ?? true ? goesIn : turnedDown).add(m);
  }

  // Odpowiedzi do autorów — z każdej piosenki, która wróciła, niezależnie
  // od werdyktu.
  final reviewNotes = <String, String>{
    for (final m in matched.values)
      if (m.reviewed.piosenkomatData?.reviewNote?.trim() case final note?
          when note.isNotEmpty)
        m.candidate.threadId: note,
  };

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
  );
}

Matched? _match(SongRaw song, List<ReviewCandidate> candidates) {
  final threadId = _threadOf(song);
  if (threadId != null) {
    final sameThread = [for (final c in candidates) if (c.threadId == threadId) c];
    if (sameThread.isNotEmpty) {
      // W obrębie wątku id wystarczy; gdy piosenek jest kilka i nie da się
      // ich rozróżnić, bierzemy pierwszą.
      final hit = _narrow(song, sameThread, trustSingle: true);
      return Matched(hit?.$1 ?? sameThread.first, hit?.$2 ?? MatchedBy.threadId, song);
    }
  }
  // Bez id wątku piosenka musi się obronić sama: id, tytuł albo tekst.
  final hit = _narrow(song, candidates, trustSingle: false);
  return hit == null ? null : Matched(hit.$1, hit.$2, song);
}

/// [trustSingle] mówi, czy jedyny kandydat jest już odpowiedzią — jest nią
/// w obrębie wątku, ale nie w całym przebiegu.
(ReviewCandidate, MatchedBy)? _narrow(
  SongRaw song,
  List<ReviewCandidate> candidates, {
  required bool trustSingle,
}) {
  if (trustSingle && candidates.length == 1) {
    return (candidates.single, MatchedBy.threadId);
  }

  final id = song.id.split('~').first;
  final byId = [for (final c in candidates) if (c.songId == id) c];
  if (byId.length == 1) return (byId.single, MatchedBy.songId);

  final key = searchableString(song.title);
  final byTitle = [
    for (final c in candidates) if (searchableString(c.title) == key) c,
  ];
  if (byTitle.length == 1) return (byTitle.single, MatchedBy.title);

  final words = textWords(song.text);
  ReviewCandidate? best;
  var bestScore = kSameText;
  for (final c in byTitle.isEmpty ? candidates : byTitle) {
    final score = jaccard(words, c.words);
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
    return '$reviewedPath jest pusty — to wygląda na pomyłkę. '
        'Jeśli naprawdę odrzucasz wszystko: --force.';
  }
  final rejectedCount = result.rejected.length;
  if (rejectedCount * 2 > candidateCount) {
    return 'Odrzucone to ponad połowa ($rejectedCount/$candidateCount) — '
        'sprawdź, czy podmieniłeś właściwy plik i czy nie zgasiłeś przełącznika '
        'hurtem. Jeśli tak ma być: --force.';
  }
  return null;
}

/// Co po przeglądzie dochodzi i co schodzi z każdej wiadomości wątku.
Map<String, LabelChange> reviewLabelChanges(
  List<ReviewResult> results,
  RunPlan plan,
) {
  final out = <String, LabelChange>{};
  for (final r in results) {
    for (final threadId in r.rejectedThreads) {
      // Odrzucona z wyjaśnieniem to nie koniec sprawy, tylko pytanie do
      // autora: bez „rejected”, bo piosenka może jeszcze wrócić z chwytami.
      final add = r.reviewNotes.containsKey(threadId)
          ? kLabelReplyReviewNote
          : kLabelRejectedAfterReview;
      for (final id in plan.messagesOf(threadId)) {
        out[id] = ([add], [kLabelReadyToAdd, ...kNeedsReviewLabels]);
      }
    }
    for (final threadId in r.acceptedThreads) {
      final hasReviewNote = r.reviewNotes.containsKey(threadId);
      for (final id in plan.messagesOf(threadId)) {
        // Bez zarzutu już miały „w pliku” — ruszamy tylko te po przeglądzie
        // albo takie, którym dopisałeś odpowiedź.
        if (!hasReviewNote &&
            !(plan.labelsByMessage[id] ?? const []).contains(kLabelNeedsReview)) {
          continue;
        }
        out[id] = (
          [kLabelReadyToAdd, if (hasReviewNote) kLabelReplyReviewNote],
          kNeedsReviewLabels,
        );
      }
    }
  }
  return out;
}

const _kReviewNote = PiosenkomatData.PARAM_REVIEW_NOTE;

/// Odpowiedzi do autorów ze śladu przeglądu: id wątku → tekst. Stąd, a nie
/// z plików `.hrcpsng`, bo `reply` woła się długo po `prepare`, a ono
/// zdejmuje pole `piosenkomat` razem z odpowiedzią.
Map<String, String> readReviewNotes(String decisionsPath) {
  if (!File(decisionsPath).existsSync()) return const {};
  final raw = jsonDecode(File(decisionsPath).readAsStringSync());
  if (raw is! Map) return const {};
  return {
    for (final entry in (raw['songs'] as List? ?? const []))
      if (entry is Map)
        if ((entry['thread_id'] as String?, (entry[_kReviewNote] as String?)?.trim())
            case (final threadId?, final note?) when note.isNotEmpty)
          threadId: note,
  };
}

/// Ślad przeglądu w katalogu przebiegu: co weszło, co wypadło, po czym
/// rozpoznane. Jeden plik na oba rodzaje.
void writeDecisions(String path, List<ReviewResult> results) {
  Map<String, dynamic> entry(
    ReviewResult r,
    ReviewCandidate c,
    String decision, {
    Matched? matched,
  }) =>
      {
        'kind': r.kind.id,
        'song_id': c.songId,
        'title': matched?.reviewed.title ?? c.title,
        'thread_id': c.threadId,
        'sender': c.sender,
        'decision': decision,
        if (matched != null) 'matched_by': matched.matchedBy.text,
        if (matched?.reviewed.piosenkomatData?.correctionTarget case final t?)
          'correction_target': t,
        if (r.reviewNotes[c.threadId] case final note?) _kReviewNote: note,
      };

  writeText(path, const JsonEncoder.withIndent('  ').convert({
    'created_at': DateTime.now().toIso8601String(),
    'songs': [
      for (final r in results) ...[
        for (final m in r.accepted) entry(r, m.candidate, 'accepted', matched: m),
        // Wróciła w pliku, ale z przełącznikiem „nie wchodzi”.
        for (final m in r.turnedDown) entry(r, m.candidate, 'turned-down', matched: m),
        for (final c in r.removed) entry(r, c, 'rejected-after-review'),
      ],
    ],
  }));
}
