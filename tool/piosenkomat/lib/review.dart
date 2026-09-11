import 'dart:convert';

import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';

import 'hrcpsng.dart';
import 'model.dart';
import 'plan.dart';
import 'similarity.dart';

/// Po czym piosenka z `reviewed.hrcpsng` została związana ze zgłoszeniem.
enum MatchKind {
  emailMsgId('id mejla'),
  songId('id piosenki'),
  title('tytuł'),
  songText('tekst');

  const MatchKind(this.text);
  final String text;
}

/// Piosenka, którą automat wstawił do pliku przebiegu, wraz z mejlem źródłowym.
class ProposedSong {
  final String msgId;
  final String songId;
  final String title;
  final String sender;
  final RunFile file;
  /// Uwagi, z jakimi piosenka pojechała do przeglądu.
  final List<SongIssue> issues;
  /// Puste, gdy piosenki nie ma w pliku (plan i plik się rozjechały).
  final Set<String> words;

  ProposedSong({
    required this.msgId,
    required this.songId,
    required this.title,
    this.sender = '',
    this.file = RunFile.auto,
    this.issues = const [],
    this.words = const {},
  });
}

/// Piosenka, która wróciła z przeglądu — i to, co z niej zostało.
class Matched {
  final ProposedSong proposed;
  final MatchKind kind;
  final String reviewedTitle;
  /// Uwagi, których nie zdjąłeś w edytorze. Puste = ogarnięte.
  final List<SongIssue> remaining;

  const Matched(this.proposed, this.kind, this.reviewedTitle,
      {this.remaining = const []});

  bool get isResolved => remaining.isEmpty;
}

class ReviewResult {
  /// Wróciły i nie mają już żadnej uwagi: idą do apki.
  final List<Matched> accepted;
  /// Wróciły, ale uwagi zostały: wracają do kolejki przeglądu.
  final List<Matched> unresolved;
  /// Nie wróciły wcale: odrzucone przy przeglądzie.
  final List<ProposedSong> rejected;
  /// Piosenki z `reviewed`, których nie da się związać ze zgłoszeniem
  /// (dorzucone ręcznie na stronie). Nic z nimi nie robimy.
  final List<String> unknown;
  /// Mejle, z których część piosenek weszła, a część wypadła. Dziś niemożliwe
  /// (jeden mejl = jedna piosenka), ale review nie ma prawa tego zgadywać.
  final Map<String, List<ProposedSong>> partial;
  /// Żadna wracająca piosenka nie niesie już śladu piosenkomatu, choć plan
  /// mówi, że niosły go wszystkie — czyli eksport zgubił pole, a nie Ty
  /// ogarnąłeś wszystko naraz.
  final bool lostIssues;

  const ReviewResult({
    required this.accepted,
    required this.unresolved,
    required this.rejected,
    required this.unknown,
    required this.partial,
    this.lostIssues = false,
  });

  /// Mejle do odetykietowania: wypadły wszystkie ich piosenki.
  List<String> get rejectedMsgIds => [
        for (final e in _byMsg(rejected).entries)
          if (!partial.containsKey(e.key)) e.key,
      ];

  /// Mejle, które po przeglądzie są gotowe do apki: wszystkie ich piosenki
  /// wróciły bez uwag.
  List<String> get acceptedMsgIds {
    final blocked = {
      for (final m in unresolved) m.proposed.msgId,
      for (final r in rejected) r.msgId,
    };
    return [
      for (final id in {for (final m in accepted) m.proposed.msgId})
        if (!blocked.contains(id)) id,
    ];
  }

  /// Mejle z nieogarniętymi uwagami i etykiety przeglądu, jakie mają dostać.
  Map<String, List<String>> get unresolvedLabels {
    final out = <String, List<String>>{};
    for (final m in unresolved) {
      final labels = out.putIfAbsent(m.proposed.msgId, () => [kLabelToReview]);
      for (final issue in m.remaining) {
        final label = issue.review?.label;
        if (label != null && !labels.contains(label)) labels.add(label);
      }
    }
    return out;
  }
}

Map<String, List<ProposedSong>> _byMsg(List<ProposedSong> songs) {
  final out = <String, List<ProposedSong>>{};
  for (final s in songs) {
    out.putIfAbsent(s.msgId, () => []).add(s);
  }
  return out;
}

/// Co automat zaproponował: plan jest kręgosłupem (wiąże piosenkę z mejlem),
/// pliki dokładają tekst do porównań. Plany sprzed wersji z sekcją `songs`
/// odtwarzamy z `email_msg_id` w samych piosenkach.
List<ProposedSong> collectProposed(LabelPlan plan, List<SongRaw> songs) {
  final byId = {for (final s in songs) s.id: s};
  SongRaw? find(String songId) =>
      byId[songId] ??
      songs.where((s) => s.id.split('~').first == songId).firstOrNull;

  if (plan.songsById.isNotEmpty) {
    return [
      for (final e in plan.songsById.entries)
        for (final i in e.value)
          ProposedSong(
            msgId: e.key,
            songId: i.songId,
            title: i.title,
            sender: i.sender,
            file: i.file,
            issues: [
              for (final id in i.issues)
                if (SongIssue.byId(id) case final issue?) issue,
            ],
            words: textWords(find(i.songId)?.text ?? ''),
          ),
    ];
  }
  return [
    for (final s in songs)
      if (s.contributorData?.emailMsgId case final msgId?)
        ProposedSong(
          msgId: msgId,
          songId: s.id,
          title: s.title,
          sender: s.contributorData?.email ?? '',
          issues: [for (final i in s.piosenkomatData?.issues ?? const []) i.issue],
          words: textWords(s.text),
        ),
  ];
}

/// Różnica „zaproponowane minus to, co wróciło”. Piosenka ma trzy stany:
/// wróciła bez uwag (wchodzi), wróciła z uwagami (dalej czeka), nie wróciła
/// (odrzucona). Dopasowanie kaskadą: id mejla, potem id piosenki, tytuł
/// i wreszcie tekst — bo przy przeglądzie tytuł i chwyty mogły się zmienić,
/// a strona mogła zgubić `email_msg_id`.
ReviewResult reviewDiff({
  required List<ProposedSong> proposed,
  required List<SongRaw> reviewed,
}) {
  final matched = <ProposedSong, Matched>{};
  final unknown = <String>[];

  for (final song in reviewed) {
    final hit = _match(song, proposed);
    if (hit == null) {
      unknown.add(song.title);
      continue;
    }
    final remaining = [
      for (final i in song.piosenkomatData?.toResolve ?? const <PiosenkomatIssue>[])
        i.issue,
    ];
    // Kilka zatwierdzonych na jedno zgłoszenie (np. rozbite na stronie):
    // pierwsze dopasowanie wystarczy, żeby zgłoszenie uznać za przyjęte.
    matched.putIfAbsent(
      hit.proposed,
      () => Matched(hit.proposed, hit.kind, hit.reviewedTitle, remaining: remaining),
    );
  }

  final rejected = [for (final p in proposed) if (!matched.containsKey(p)) p];
  final accepted = [for (final m in matched.values) if (m.isResolved) m];
  final unresolved = [for (final m in matched.values) if (!m.isResolved) m];
  final acceptedByMsg = _byMsg([for (final m in matched.values) m.proposed]);
  final partial = {
    for (final e in _byMsg(rejected).entries)
      if (acceptedByMsg.containsKey(e.key)) e.key: e.value,
  };

  // Bezpiecznik na zgubione pole: coś jechało z uwagą do ogarnięcia, a żadna
  // piosenka nie wróciła ze śladem piosenkomatu. Adnotacje (`old-app`, `reply`)
  // się nie liczą — nie ma w nich czego ogarniać, więc ich brak nic nie znaczy.
  // Ogarnięcie zdejmuje uwagę, a nie całe pole, więc uczciwy eksport zawsze
  // ma ślad — zero śladów przy choćby jednej takiej piosence to zgubione pole.
  final withIssues = matched.keys
      .where((p) => p.issues.any((i) => !i.isInfo))
      .length;
  final lostIssues = withIssues >= 1 &&
      reviewed.every((s) => s.piosenkomatData == null);

  return ReviewResult(
    accepted: accepted,
    unresolved: unresolved,
    rejected: rejected,
    unknown: unknown,
    partial: partial,
    lostIssues: lostIssues,
  );
}

Matched? _match(SongRaw song, List<ProposedSong> proposed) {
  final msgId = song.contributorData?.emailMsgId;
  if (msgId != null) {
    final sameMail = [for (final p in proposed) if (p.msgId == msgId) p];
    if (sameMail.isNotEmpty) {
      // W obrębie jednego mejla id wystarczy; gdy piosenek jest kilka i nie da
      // się ich rozróżnić, bierzemy pierwszą. Pomyłka zostawia mejl w „w pliku”,
      // czyli u Ciebie — odwrotnie niż zgadywanie, które zdejmowałoby etykietę.
      final hit = _narrow(song, sameMail, trustSingle: true);
      return Matched(hit?.$1 ?? sameMail.first, hit?.$2 ?? MatchKind.emailMsgId,
          song.title);
    }
  }
  // Bez id mejla piosenka musi się obronić sama: id, tytuł albo tekst.
  final hit = _narrow(song, proposed, trustSingle: false);
  return hit == null ? null : Matched(hit.$1, hit.$2, song.title);
}

/// [trustSingle] mówi, czy jedyny kandydat jest już odpowiedzią — jest nią
/// w obrębie mejla, ale nie w całym przebiegu.
(ProposedSong, MatchKind)? _narrow(
  SongRaw song,
  List<ProposedSong> candidates, {
  required bool trustSingle,
}) {
  if (trustSingle && candidates.length == 1) {
    return (candidates.single, MatchKind.emailMsgId);
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

/// Ślad przeglądu w katalogu przebiegu: co weszło, co dalej czeka, co wypadło
/// i po czym zostało rozpoznane.
void writeDecisions(
  String path, {
  required String reviewedPath,
  required ReviewResult result,
}) {
  writeText(path, const JsonEncoder.withIndent('  ').convert({
    'created_at': DateTime.now().toIso8601String(),
    'reviewed': reviewedPath,
    'songs': [
      for (final m in result.accepted)
        {
          'song_id': m.proposed.songId,
          'title': m.proposed.title,
          'email_msg_id': m.proposed.msgId,
          'decision': 'accepted',
          'matched_by': m.kind.text,
          if (m.proposed.issues.isNotEmpty)
            'resolved_issues': [for (final i in m.proposed.issues) i.id],
        },
      for (final m in result.unresolved)
        {
          'song_id': m.proposed.songId,
          'title': m.proposed.title,
          'email_msg_id': m.proposed.msgId,
          'decision': 'still-needs-review',
          'matched_by': m.kind.text,
          'issues': [for (final i in m.remaining) i.id],
        },
      for (final r in result.rejected)
        {
          'song_id': r.songId,
          'title': r.title,
          'email_msg_id': r.msgId,
          'sender': r.sender,
          'decision': 'rejected-after-review',
          if (r.issues.isNotEmpty)
            'issues': [for (final i in r.issues) i.id],
        },
    ],
    'unknown': result.unknown,
  }));
}
