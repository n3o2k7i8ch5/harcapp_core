import 'dart:convert';

import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';

import 'hrcpsng.dart';
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

/// Piosenka, którą automat wstawił do `songs.hrcpsng`, wraz z mejlem źródłowym.
class ProposedSong {
  final String msgId;
  final String songId;
  final String title;
  final String sender;
  /// Puste, gdy piosenki nie ma w pliku (plan i plik się rozjechały).
  final Set<String> words;

  ProposedSong({
    required this.msgId,
    required this.songId,
    required this.title,
    this.sender = '',
    this.words = const {},
  });
}

class Matched {
  final ProposedSong proposed;
  final MatchKind kind;
  final String reviewedTitle;

  const Matched(this.proposed, this.kind, this.reviewedTitle);
}

class ReviewResult {
  final List<Matched> accepted;
  final List<ProposedSong> rejected;
  /// Piosenki z `reviewed`, których nie da się związać ze zgłoszeniem
  /// (dorzucone ręcznie na stronie). Nic z nimi nie robimy.
  final List<String> unknown;
  /// Mejle, z których część piosenek weszła, a część wypadła. Dziś niemożliwe
  /// (jeden mejl = jedna piosenka), ale review nie ma prawa tego zgadywać.
  final Map<String, List<ProposedSong>> partial;

  const ReviewResult({
    required this.accepted,
    required this.rejected,
    required this.unknown,
    required this.partial,
  });

  /// Mejle do odetykietowania: wypadły wszystkie ich piosenki.
  List<String> get rejectedMsgIds => [
        for (final e in _byMsg(rejected).entries)
          if (!partial.containsKey(e.key)) e.key,
      ];
}

Map<String, List<ProposedSong>> _byMsg(List<ProposedSong> songs) {
  final out = <String, List<ProposedSong>>{};
  for (final s in songs) {
    out.putIfAbsent(s.msgId, () => []).add(s);
  }
  return out;
}

/// Co automat zaproponował: plan jest kręgosłupem (wiąże piosenkę z mejlem),
/// plik dokłada tekst do porównań. Plany sprzed wersji z sekcją `imports`
/// odtwarzamy z `email_msg_id` w samych piosenkach.
List<ProposedSong> collectProposed(LabelPlan plan, List<SongRaw> songs) {
  final byId = {for (final s in songs) s.id: s};
  SongRaw? find(String songId) =>
      byId[songId] ??
      songs.where((s) => s.id.split('~').first == songId).firstOrNull;

  if (plan.importsById.isNotEmpty) {
    return [
      for (final e in plan.importsById.entries)
        for (final i in e.value)
          ProposedSong(
            msgId: e.key,
            songId: i.songId,
            title: i.title,
            sender: i.sender,
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
          words: textWords(s.text),
        ),
  ];
}

/// Różnica „zaproponowane minus zatwierdzone”. Dopasowanie kaskadą: id mejla,
/// potem id piosenki, tytuł i wreszcie tekst — bo przy przeglądzie tytuł
/// i chwyty mogły się zmienić, a strona mogła zgubić `email_msg_id`.
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
    // Kilka zatwierdzonych na jedno zgłoszenie (np. rozbite na stronie):
    // pierwsze dopasowanie wystarczy, żeby zgłoszenie uznać za przyjęte.
    matched.putIfAbsent(hit.proposed, () => hit);
  }

  final rejected = [for (final p in proposed) if (!matched.containsKey(p)) p];
  final acceptedByMsg = _byMsg([for (final m in matched.values) m.proposed]);
  final partial = {
    for (final e in _byMsg(rejected).entries)
      if (acceptedByMsg.containsKey(e.key)) e.key: e.value,
  };

  return ReviewResult(
    accepted: matched.values.toList(),
    rejected: rejected,
    unknown: unknown,
    partial: partial,
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

/// Ślad przeglądu w katalogu przebiegu: co weszło, co wypadło i po czym
/// zostało rozpoznane.
void writeReviewLedger(
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
        },
      for (final r in result.rejected)
        {
          'song_id': r.songId,
          'title': r.title,
          'email_msg_id': r.msgId,
          'sender': r.sender,
          'decision': 'rejected-after-review',
        },
    ],
    'unknown': result.unknown,
  }));
}
