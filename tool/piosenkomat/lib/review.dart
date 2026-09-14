import 'dart:convert';
import 'dart:io';

import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';

import 'hrcpsng.dart';
import 'plan.dart';
import 'similarity.dart';

/// Po czym piosenka z `reviewed-*.hrcpsng` została związana ze zgłoszeniem.
enum MatchKind {
  threadId('id wątku'),
  songId('id piosenki'),
  title('tytuł'),
  songText('tekst');

  const MatchKind(this.text);
  final String text;
}

/// Piosenka, którą automat wstawił do pliku kandydatów, wraz z wątkiem.
class ProposedSong {
  final String threadId;
  final String songId;
  final String title;
  final String sender;
  final SubmissionKind kind;
  /// Puste, gdy piosenki nie ma w pliku (plan i plik się rozjechały).
  final Set<String> words;

  ProposedSong({
    required this.threadId,
    required this.songId,
    required this.title,
    this.sender = '',
    this.kind = SubmissionKind.newSong,
    this.words = const {},
  });
}

/// Piosenka, która wróciła z przeglądu.
class Matched {
  final ProposedSong proposed;
  final MatchKind kind;
  final SongRaw reviewed;

  const Matched(this.proposed, this.kind, this.reviewed);
}

/// Werdykt przeglądu. Piosenka wchodzi, gdy wróciła w pliku **i** nie ma
/// zgaszonego przełącznika; nie wróciła albo zgaszony → odpada. Plus to, co
/// każe się zatrzymać: z kandydatów można wywalać i edytować, nie dodawać.
class ReviewResult {
  final SubmissionKind kind;
  final List<Matched> accepted;
  /// Nie wróciła w pliku zwrotnym — skasowana przy przeglądzie.
  final List<ProposedSong> rejected;
  /// Wróciła, ale z przełącznikiem „nie wchodzi”. Odpada tak samo jak
  /// [rejected], ale wiemy o niej więcej — m.in. może nieść odpowiedź.
  final List<Matched> turnedDown;
  /// Co napisać autorom: id wątku → tekst z pola „Odpowiedź do autora”.
  /// Niezależne od werdyktu — i odrzucona, i przyjęta może coś nieść.
  final Map<String, String> replies;
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
    required this.rejected,
    required this.foreign,
    required this.wrongKind,
    required this.duplicateTargets,
    this.turnedDown = const [],
    this.replies = const {},
  });

  bool get mustStop =>
      foreign.isNotEmpty || wrongKind.isNotEmpty || duplicateTargets.isNotEmpty;

  List<String> get acceptedThreads => [for (final m in accepted) m.proposed.threadId];
  /// Skasowane i zgaszone przełącznikiem — dla etykiet to jedno i to samo.
  List<String> get rejectedThreads => [
        for (final r in rejected) r.threadId,
        for (final m in turnedDown) m.proposed.threadId,
      ];
  /// Wszystko, co odpadło, do wypisania.
  List<ProposedSong> get allRejected =>
      [...rejected, for (final m in turnedDown) m.proposed];
}

/// Co automat zaproponował dla danego rodzaju: plan jest kręgosłupem (wiąże
/// piosenkę z wątkiem), plik dokłada tekst do porównań awaryjnych.
List<ProposedSong> collectProposed(
  LabelPlan plan,
  List<SongRaw> candidates,
  SubmissionKind kind,
) {
  final byId = {for (final s in candidates) s.id: s};
  SongRaw? find(String songId) =>
      byId[songId] ??
      candidates.where((s) => s.id.split('~').first == songId).firstOrNull;

  if (plan.songsByThread.isNotEmpty) {
    return [
      for (final e in plan.songsByThread.entries)
        for (final i in e.value)
          if (i.kind == kind)
            ProposedSong(
              threadId: e.key,
              songId: i.songId,
              title: i.title,
              sender: i.sender,
              kind: kind,
              words: textWords(find(i.songId)?.text ?? ''),
            ),
    ];
  }
  // Plany sprzed sekcji `songs`: kręgosłupem jest id wątku w piosenkach.
  return [
    for (final s in candidates)
      if (_threadOf(s) case final threadId?)
        if ((s.piosenkomatData?.kind ?? SubmissionKind.newSong) == kind)
          ProposedSong(
            threadId: threadId,
            songId: s.id,
            title: s.title,
            sender: s.contributorData?.email ?? '',
            kind: kind,
            words: textWords(s.text),
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
  required List<ProposedSong> proposed,
  required List<SongRaw> reviewed,
}) {
  final matched = <ProposedSong, Matched>{};
  final foreign = <SongRaw>[];
  final wrongKind = <SongRaw>[];

  for (final song in reviewed) {
    final songKind = song.piosenkomatData?.kind;
    if (songKind != null && songKind != kind) {
      wrongKind.add(song);
      continue;
    }
    final hit = _match(song, proposed);
    if (hit == null) {
      foreign.add(song);
      continue;
    }
    // Kilka zatwierdzonych na jedno zgłoszenie (np. rozbite na stronie):
    // pierwsze dopasowanie wystarczy, żeby zgłoszenie uznać za przyjęte.
    matched.putIfAbsent(hit.proposed, () => hit);
  }

  final rejected = [for (final p in proposed) if (!matched.containsKey(p)) p];

  // Przełącznik z edytora. Brak flagi znaczy „wchodzi”, więc pliki sprzed
  // przełącznika (i te, z których po prostu skasowałeś, co odpada) działają
  // jak dotąd.
  final goesIn = <Matched>[];
  final turnedDown = <Matched>[];
  for (final m in matched.values) {
    (m.reviewed.piosenkomatData?.goesIn ?? true ? goesIn : turnedDown).add(m);
  }

  // Odpowiedzi do autorów — z każdej piosenki, która wróciła, niezależnie
  // od werdyktu.
  final replies = <String, String>{};
  for (final m in matched.values) {
    final text = m.reviewed.piosenkomatData?.replyToContributor?.trim();
    if (text != null && text.isNotEmpty) replies[m.proposed.threadId] = text;
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
    rejected: rejected,
    turnedDown: turnedDown,
    replies: replies,
    foreign: foreign,
    wrongKind: wrongKind,
    duplicateTargets: {
      for (final e in byTarget.entries)
        if (e.value.length > 1) e.key: e.value,
    },
  );
}

Matched? _match(SongRaw song, List<ProposedSong> proposed) {
  final threadId = _threadOf(song);
  if (threadId != null) {
    final sameThread = [for (final p in proposed) if (p.threadId == threadId) p];
    if (sameThread.isNotEmpty) {
      // W obrębie wątku id wystarczy; gdy piosenek jest kilka i nie da się
      // ich rozróżnić, bierzemy pierwszą.
      final hit = _narrow(song, sameThread, trustSingle: true);
      return Matched(hit?.$1 ?? sameThread.first, hit?.$2 ?? MatchKind.threadId, song);
    }
  }
  // Bez id wątku piosenka musi się obronić sama: id, tytuł albo tekst.
  final hit = _narrow(song, proposed, trustSingle: false);
  return hit == null ? null : Matched(hit.$1, hit.$2, song);
}

/// [trustSingle] mówi, czy jedyny kandydat jest już odpowiedzią — jest nią
/// w obrębie wątku, ale nie w całym przebiegu.
(ProposedSong, MatchKind)? _narrow(
  SongRaw song,
  List<ProposedSong> candidates, {
  required bool trustSingle,
}) {
  if (trustSingle && candidates.length == 1) {
    return (candidates.single, MatchKind.threadId);
  }

  final id = song.id.split('~').first;
  final byId = [for (final c in candidates) if (c.songId == id) c];
  if (byId.length == 1) return (byId.single, MatchKind.songId);

  final key = searchableString(song.title);
  final byTitle = [
    for (final c in candidates) if (searchableString(c.title) == key) c,
  ];
  if (byTitle.length == 1) return (byTitle.single, MatchKind.title);

  final words = textWords(song.text);
  ProposedSong? best;
  var bestScore = kSameText;
  for (final c in byTitle.isEmpty ? candidates : byTitle) {
    final score = jaccard(words, c.words);
    if (score >= bestScore) {
      best = c;
      bestScore = score;
    }
  }
  return best == null ? null : (best, MatchKind.songText);
}

/// Odpowiedzi do autorów ze śladu przeglądu: id wątku → tekst. Stąd, a nie
/// z plików `.hrcpsng`, bo `reply` woła się długo po `strip`, a `strip`
/// zdejmuje pole `piosenkomat` razem z odpowiedzią.
Map<String, String> readReplies(String decisionsPath) {
  if (!File(decisionsPath).existsSync()) return const {};
  final raw = jsonDecode(File(decisionsPath).readAsStringSync());
  if (raw is! Map) return const {};
  final out = <String, String>{};
  for (final entry in (raw['songs'] as List? ?? const [])) {
    if (entry is! Map) continue;
    final threadId = entry['thread_id'] as String?;
    final reply = (entry['reply_to_contributor'] as String?)?.trim();
    if (threadId != null && reply != null && reply.isNotEmpty) {
      out[threadId] = reply;
    }
  }
  return out;
}

/// Ślad przeglądu w katalogu przebiegu: co weszło, co wypadło, po czym
/// rozpoznane. Jeden plik na oba rodzaje.
void writeDecisions(String path, List<ReviewResult> results) {
  writeText(path, const JsonEncoder.withIndent('  ').convert({
    'created_at': DateTime.now().toIso8601String(),
    'songs': [
      for (final r in results) ...[
        for (final m in r.accepted)
          {
            'kind': r.kind.id,
            'song_id': m.proposed.songId,
            'title': m.reviewed.title,
            'thread_id': m.proposed.threadId,
            'decision': 'accepted',
            'matched_by': m.kind.text,
            if (m.reviewed.piosenkomatData?.correctionTarget case final t?)
              'correction_target': t,
            if (r.replies[m.proposed.threadId] case final reply?)
              'reply_to_contributor': reply,
          },
        for (final m in r.turnedDown)
          {
            'kind': r.kind.id,
            'song_id': m.proposed.songId,
            'title': m.reviewed.title,
            'thread_id': m.proposed.threadId,
            'sender': m.proposed.sender,
            // Wróciła w pliku, ale z przełącznikiem „nie wchodzi”.
            'decision': 'turned-down',
            'matched_by': m.kind.text,
            if (r.replies[m.proposed.threadId] case final reply?)
              'reply_to_contributor': reply,
          },
        for (final p in r.rejected)
          {
            'kind': r.kind.id,
            'song_id': p.songId,
            'title': p.title,
            'thread_id': p.threadId,
            'sender': p.sender,
            'decision': 'rejected-after-review',
          },
      ],
    ],
  }));
}
