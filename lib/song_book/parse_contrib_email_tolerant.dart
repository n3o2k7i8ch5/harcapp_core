/// Parsowanie mejla zgłoszeniowego odporne na to, co robią z nim klienty
/// pocztowe: łamanie długich linii JSON-a, zbłąkane spacje w adresach.
/// Ścisły parser to [parseContribEmail]; tu tylko warianty treści, które
/// mu podajemy.
library;

import 'dart:convert';

import 'package:harcapp_core/song_book/parse_contrib_email.dart';
import 'package:harcapp_core/song_book/parse_contrib_email_old_app.dart';
import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/values/people/contributor_ref.dart';

/// Blok z kodem piosenki: w ogrodzeniu ``` albo goły JSON
/// od pierwszej `{` do końca treści (najstarsza apka).
final _songFenceRe = RegExp(
  r'(### Kod piosenki:\s*```[a-zA-Z]*\s*\n)([\s\S]*?)(\n?```)',
);
final _songBareRe = RegExp(r'(### Kod piosenki:\s*\n\s*)(\{[\s\S]*)$');

/// Parsuje mejl odpornie na łamanie linii przez klienty pocztowe.
///
/// Klient (np. Gmail na Androidzie) łamie długie linie co ~76 znaków,
/// wstawiając CRLF w miejsce spacji albo w środek słowa. JSON piosenki
/// w treści jest wtedy nie do odczytania. Kolejność prób:
///  1. załącznik `.hrcpsng` wstawiony w miejsce JSON-a z treści (źródło prawdy),
///  2. treść jak jest,
///  3. treść z liniami JSON-a sklejonymi spacją,
///  4. treść z liniami JSON-a sklejonymi bez spacji.
ParsedContribEmail parseContribEmailTolerant(String body, {String? songAttachment}) {
  final region = _songRegion(body);
  final attachment = songAttachment == null ? null : _attachmentSong(songAttachment);
  final candidates = <String?>[
    if (region != null && attachment != null)
      _replaceRegion(body, region, _attachmentJson(region, attachment)),
    body,
    if (region != null) _replaceRegion(body, region, region.json.replaceAll(RegExp(r'\r?\n'), ' ')),
    if (region != null) _replaceRegion(body, region, region.json.replaceAll(RegExp(r'\r?\n'), '')),
    ..._oldAppCandidates(body),
  ].whereType<String>().toList();

  Object? firstError;
  for (final content in candidates) {
    try {
      final parsed = parseContribEmail(content);
      _trimEmailRefs(parsed.song);
      return parsed;
    } catch (e) {
      firstError ??= e;
    }
  }
  throw firstError!;
}

/// Najstarsza apka: JSON siedzi między znacznikami „nie edytuj", bez sekcji
/// `### Kod piosenki:`. Rdzeń umie wyjąć ten region (i zdjąć z niego cytowanie
/// oraz HTML), ale klienty pocztowe łamią w nim długie linie tak samo jak
/// wszędzie indziej. Doklejamy więc region jako sekcję, którą parser już zna,
/// w trzech wariantach sklejenia — oryginalna treść zostaje, żeby
/// `detectOldAppFormat` dalej rozpoznał po niej starą apkę.
List<String> _oldAppCandidates(String body) {
  final region = oldAppSongRegion(body);
  if (region == null || !region.trimLeft().startsWith('{')) return const [];
  return [
    for (final json in [
      region,
      region.replaceAll(RegExp(r'\s*\r?\n\s*'), ' '),
      region.replaceAll(RegExp(r'\s*\r?\n\s*'), ''),
    ])
      '$body\n\n$kSongCodeMarker\n$json',
  ];
}

class _SongRegion {
  final int start;
  final int end;
  final String json;
  final bool isFenced;
  const _SongRegion(this.start, this.end, this.json, this.isFenced);
}

_SongRegion? _songRegion(String body) {
  final fenced = _songFenceRe.firstMatch(body);
  if (fenced != null) {
    return _SongRegion(fenced.start + fenced.group(1)!.length,
        fenced.end - fenced.group(3)!.length, fenced.group(2)!, true);
  }
  final bare = _songBareRe.firstMatch(body);
  if (bare != null) {
    final json = bare.group(2)!.trimRight();
    final start = bare.start + bare.group(1)!.length;
    return _SongRegion(start, start + json.length, json, false);
  }
  return null;
}

String _replaceRegion(String body, _SongRegion r, String json) =>
    body.replaceRange(r.start, r.end, json);

/// JSON załącznika w kształcie, w jakim był w treści. Otoczka
/// `{"o!_id": {...}}` to znak rozpoznawczy najstarszej apki
/// (`detectOldAppFormat`), więc dokładamy ją tylko wtedy, gdy treść też ją
/// miała — inaczej mejl z nowszej apki bez fence'a dostawałby otoczkę od nas
/// i wyglądał na stary format.
String _attachmentJson(_SongRegion region, (String, Map<String, dynamic>) attachment) =>
    !region.isFenced && _oldAppWrapperRe.hasMatch(region.json)
        ? jsonEncode({attachment.$1: attachment.$2})
        : jsonEncode(attachment.$2);

final _oldAppWrapperRe = RegExp(r'^\s*\{\s*"o!_');

/// Załącznik `.hrcpsng`: `(id, mapa piosenki)`.
(String, Map<String, dynamic>)? _attachmentSong(String attachment) {
  try {
    final map = jsonDecode(attachment) as Map<String, dynamic>;
    final official = map['official'];
    if (official is Map && official.isNotEmpty) {
      final id = official.keys.first as String;
      final entry = official[id];
      final song = entry is Map ? entry['song'] : null;
      if (song is Map) return (id, song.cast<String, dynamic>());
    }
    if (map.containsKey(SongCore.PARAM_TITLE)) {
      return ('o!_${SongCore.filenameFromTitle(map[SongCore.PARAM_TITLE] as String)}', map);
    }
  } catch (_) {}
  return null;
}

/// Po sklejeniu linii w `email_ref` może zostać zbłąkana spacja.
void _trimEmailRefs(SongRaw song) {
  song.contribRefs = [
    for (final c in song.contribRefs)
      ContributorRef(
        person: c.person,
        emailRef: c.emailRef?.replaceAll(RegExp(r'\s'), ''),
        userKeyRef: c.userKeyRef?.trim(),
      ),
  ];
}
