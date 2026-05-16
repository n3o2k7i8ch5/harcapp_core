import 'dart:convert';

import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/values/org.dart';
import 'package:harcapp_core/values/people/person.dart';
import 'package:harcapp_core/values/rank_harc.dart';
import 'package:harcapp_core/values/rank_instr.dart';

class ParsedContribEmail{

  final SongRaw song;
  final String? senderEmail;
  final String? acceptedRulesVersion;
  final Person? person;
  final bool isNewFormat;

  ParsedContribEmail({
    required this.song,
    required this.senderEmail,
    required this.acceptedRulesVersion,
    required this.person,
    required this.isNewFormat,
  });

}

class ContribEmailParseError implements Exception {
  final String message;
  ContribEmailParseError(this.message);
  @override
  String toString() => 'ContribEmailParseError: $message';
}

ParsedContribEmail parseContribEmail(String content){
  try {
    return _parseV2(content);
  } catch(eNew){
    try {
      return _parseLegacy(content);
    } catch(eLegacy){
      throw ContribEmailParseError(
        'Nie udało się odczytać piosenki z mejla.\n'
        'Próba nowego formatu: $eNew\n'
        'Próba formatu legacy: $eLegacy',
      );
    }
  }
}

// =====================================================================
// V2 parser (fenced JSON blocks).
// =====================================================================

ParsedContribEmail _parseV2(String content){
  String songJson = _extractFencedBlockAfter(content, '### Kod piosenki:');

  Map<String, dynamic> songMap;
  try {
    songMap = jsonDecode(songJson) as Map<String, dynamic>;
  } catch(e){
    throw ContribEmailParseError('Nie udało się sparsować JSON-a piosenki: $e');
  }

  String? title = songMap[SongCore.PARAM_TITLE] as String?;
  if(title == null || title.isEmpty)
    throw ContribEmailParseError('Brak tytułu piosenki w JSON-ie.');

  SongRaw song = SongRaw.fromApiRespMap('o!_${SongCore.filenameFromTitle(title)}', songMap);

  String? acceptedRulesVersion = _extractAcceptedRulesVersion(content);
  String? senderEmail = _extractSenderEmail(content);

  Person? person;
  String? personJson = _tryExtractFencedBlockAfter(content, '### Osoba dodająca');
  if(personJson != null){
    try {
      Map<String, dynamic> personMap = jsonDecode(personJson) as Map<String, dynamic>;
      person = Person.fromApiJsonMap(personMap);
    } catch(_){
      // Person block malformed — keep person null but still let parsing succeed.
    }
  }

  return ParsedContribEmail(
    song: song,
    senderEmail: senderEmail,
    acceptedRulesVersion: acceptedRulesVersion,
    person: person,
    isNewFormat: true,
  );
}

String _extractFencedBlockAfter(String content, String header){
  String? value = _tryExtractFencedBlockAfter(content, header);
  if(value == null)
    throw ContribEmailParseError('Brak sekcji "$header" lub jej zawartości w fence ```...```.');
  return value;
}

String? _tryExtractFencedBlockAfter(String content, String header){
  int headerIdx = content.indexOf(header);
  if(headerIdx == -1) return null;

  int searchFrom = headerIdx + header.length;
  RegExp fenceOpen = RegExp(r'```[a-zA-Z]*\s*\n');
  Match? open = fenceOpen.firstMatch(content.substring(searchFrom));
  if(open == null) return null;

  int blockStart = searchFrom + open.end;
  int blockEnd = content.indexOf('```', blockStart);
  if(blockEnd == -1) return null;

  return content.substring(blockStart, blockEnd).trim();
}

// =====================================================================
// Legacy parser (Dart-like Person, bare JSON song).
// =====================================================================

ParsedContribEmail _parseLegacy(String content){
  int codeHeaderIdx = content.indexOf('### Kod piosenki:');
  if(codeHeaderIdx == -1)
    throw ContribEmailParseError('Brak sekcji "### Kod piosenki:".');

  String songJson = _extractFirstJsonObject(
      content.substring(codeHeaderIdx + '### Kod piosenki:'.length));

  Map<String, dynamic> songMap;
  try {
    songMap = jsonDecode(songJson) as Map<String, dynamic>;
  } catch(e){
    throw ContribEmailParseError('Nie udało się sparsować JSON-a piosenki: $e');
  }

  String? title = songMap[SongCore.PARAM_TITLE] as String?;
  if(title == null || title.isEmpty)
    throw ContribEmailParseError('Brak tytułu piosenki w JSON-ie.');

  SongRaw song = SongRaw.fromApiRespMap('o!_${SongCore.filenameFromTitle(title)}', songMap);

  String? acceptedRulesVersion = _extractAcceptedRulesVersion(content);
  String? senderEmail = _extractSenderEmail(content);

  Person? person;
  int personHeaderIdx = content.indexOf('### Osoba dodająca');
  if(personHeaderIdx != -1 && personHeaderIdx < codeHeaderIdx){
    String personBlock = content.substring(personHeaderIdx, codeHeaderIdx);
    person = _parseLegacyPersonBlock(personBlock);
  }

  return ParsedContribEmail(
    song: song,
    senderEmail: senderEmail,
    acceptedRulesVersion: acceptedRulesVersion,
    person: person,
    isNewFormat: false,
  );
}

Person? _parseLegacyPersonBlock(String block){
  int parenIdx = block.indexOf('Person(');
  if(parenIdx == -1) return null;
  int closingIdx = block.indexOf(');', parenIdx);
  if(closingIdx == -1) return null;

  String body = block.substring(parenIdx + 'Person('.length, closingIdx);

  String? name = _captureLegacyString(body, 'name');
  if(name == null || name.trim().isEmpty) return null;

  String? druzyna = _captureLegacyString(body, 'druzyna');
  String? hufiec = _captureLegacyString(body, 'hufiec');
  String? comment = _captureLegacyString(body, 'comment');

  String? rankHarcRaw = _captureLegacyEnumValue(body, 'rankHarc');
  String? rankInstrRaw = _captureLegacyEnumValue(body, 'rankInstr');
  String? orgRaw = _captureLegacyEnumValue(body, 'org');

  RankHarc? rankHarc;
  if(rankHarcRaw != null)
    rankHarc = RankHarc.values.where((r) => r.name == rankHarcRaw).firstOrNull;

  RankInstr? rankInstr;
  if(rankInstrRaw != null)
    rankInstr = RankInstr.values.where((r) => r.name == rankInstrRaw).firstOrNull;

  Org? org;
  if(orgRaw != null)
    org = Org.values.where((o) => o.name == orgRaw).firstOrNull;

  List<String> emails = _captureLegacyStringList(body, 'email');

  return Person(
    name: name,
    druzyna: druzyna,
    hufiec: hufiec,
    rankHarc: rankHarc,
    rankInstr: rankInstr,
    org: org,
    comment: comment,
    email: emails,
  );
}

String? _captureLegacyString(String body, String key){
  RegExp re = RegExp("$key:\\s*'((?:\\\\'|[^'])*)'");
  Match? m = re.firstMatch(body);
  if(m == null) return null;
  return m.group(1)?.replaceAll(r"\'", "'");
}

String? _captureLegacyEnumValue(String body, String key){
  RegExp re = RegExp('$key:\\s*[A-Za-z]+\\.([A-Za-z]+)');
  Match? m = re.firstMatch(body);
  return m?.group(1);
}

List<String> _captureLegacyStringList(String body, String key){
  RegExp re = RegExp('$key:\\s*\\[([^\\]]*)\\]');
  Match? m = re.firstMatch(body);
  if(m == null) return [];
  String inner = m.group(1) ?? '';
  RegExp itemRe = RegExp('"([^"]*)"');
  return itemRe.allMatches(inner).map((mm) => mm.group(1)!).toList();
}

// =====================================================================
// Shared helpers.
// =====================================================================

final RegExp _emailAngleRe = RegExp(r'<([a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,})>');

String? _extractSenderEmail(String content){
  Match? m = _emailAngleRe.firstMatch(content);
  return m?.group(1)?.toLowerCase();
}

final RegExp _acceptRulesRe = RegExp(
  r'akceptuj[ęe]\s+zasady\s+dodawania\s+piosenek\s+do\s+aplikacji\s+HarcApp\s*\(\s*([^,\)]+?)\s*[,\)]',
  caseSensitive: false,
);

String? _extractAcceptedRulesVersion(String content){
  Match? m = _acceptRulesRe.firstMatch(content);
  String? raw = m?.group(1)?.trim();
  if(raw == null || raw.isEmpty) return null;
  return raw;
}

String _extractFirstJsonObject(String input){
  int start = input.indexOf('{');
  if(start == -1)
    throw ContribEmailParseError('Brak początku obiektu JSON w sekcji "### Kod piosenki:".');

  int depth = 0;
  bool inString = false;
  bool escape = false;

  for(int i = start; i < input.length; i++){
    String ch = input[i];

    if(escape){
      escape = false;
      continue;
    }

    if(ch == r'\' && inString){
      escape = true;
      continue;
    }

    if(ch == '"'){
      inString = !inString;
      continue;
    }

    if(inString) continue;

    if(ch == '{') depth++;
    else if(ch == '}'){
      depth--;
      if(depth == 0)
        return input.substring(start, i + 1);
    }
  }

  throw ContribEmailParseError('Niesymetryczne nawiasy JSON w sekcji "### Kod piosenki:".');
}
