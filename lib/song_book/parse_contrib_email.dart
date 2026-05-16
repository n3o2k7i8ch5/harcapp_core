import 'dart:convert';

import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/values/people/models.dart';
import 'package:harcapp_core/values/rank_harc.dart';
import 'package:harcapp_core/values/rank_instr.dart';
import 'package:harcapp_core/values/srodowiska/models.dart';

class ParsedContribEmail{

  final SongRaw song;
  final String? senderEmail;
  final String? acceptedRulesVersion;
  final RegisteredContributorPerson? registered;
  final String? userMessage;
  final bool isNewFormat;

  ParsedContribEmail({
    required this.song,
    required this.senderEmail,
    required this.acceptedRulesVersion,
    required this.registered,
    required this.userMessage,
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

  RegisteredContributorPerson? registered;
  String? personJson = _tryExtractFencedBlockAfter(content, '### Osoba dodająca');
  if(personJson != null){
    try {
      Map<String, dynamic> personMap = jsonDecode(personJson) as Map<String, dynamic>;
      final emailsRaw = personMap.remove('email');
      final emails = emailsRaw is List ? emailsRaw.cast<String>() : const <String>[];
      final person = Person.fromApiJsonMap(personMap);
      registered = RegisteredContributorPerson(person: person, emails: emails);
    } catch(_){
      // Person block malformed — keep null but still let parsing succeed.
    }
  }

  return ParsedContribEmail(
    song: song,
    senderEmail: senderEmail,
    acceptedRulesVersion: acceptedRulesVersion,
    registered: registered,
    userMessage: _extractUserMessage(content),
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

  RegisteredContributorPerson? registered;
  int personHeaderIdx = content.indexOf('### Osoba dodająca');
  if(personHeaderIdx != -1 && personHeaderIdx < codeHeaderIdx){
    String personBlock = content.substring(personHeaderIdx, codeHeaderIdx);
    // Try newer-legacy (RegisteredContributorPerson) first, fall back to V1
    // (bare Person), so nested `Person(...)` inside doesn't get mis-matched.
    registered = _parseLegacyRegisteredBlock(personBlock)
              ?? _parseLegacyPersonBlock(personBlock);
  }

  return ParsedContribEmail(
    song: song,
    senderEmail: senderEmail,
    acceptedRulesVersion: acceptedRulesVersion,
    registered: registered,
    userMessage: _extractUserMessage(content),
    isNewFormat: false,
  );
}

/// Parses the newer legacy block emitted by `contrib_song_email_legacy.dart`:
/// `RegisteredContributorPerson X = const RegisteredContributorPerson(
///    person: Person(...), emails: [...] );`
RegisteredContributorPerson? _parseLegacyRegisteredBlock(String block){
  const marker = 'RegisteredContributorPerson(';
  final start = block.indexOf(marker);
  if(start == -1) return null;
  final outerOpenParen = start + marker.length - 1; // index of '('
  final outerClose = _findMatchingParen(block, outerOpenParen);
  if(outerClose == -1) return null;
  final outerBody = block.substring(outerOpenParen + 1, outerClose);

  final pIdx = outerBody.indexOf('Person(');
  if(pIdx == -1) return null;
  final pOpenParen = pIdx + 'Person('.length - 1;
  final pClose = _findMatchingParen(outerBody, pOpenParen);
  if(pClose == -1) return null;
  final personBody = outerBody.substring(pOpenParen + 1, pClose);

  final person = _personFromLegacyBody(personBody);
  if(person == null) return null;

  // Emails sit on the OUTER level (outside Person body). Slice Person out
  // so the regex doesn't accidentally hit something inside.
  final outerWithoutPerson =
      outerBody.substring(0, pIdx) + outerBody.substring(pClose + 1);
  final emails = _captureLegacyStringList(outerWithoutPerson, 'emails');

  return RegisteredContributorPerson(person: person, emails: emails);
}

/// Parses the original legacy block: `Person X = const Person(... email: [...] );`.
/// Maps `hufiec: '...'` and `org: Org.xxx` onto the new `Srodowisko` model.
RegisteredContributorPerson? _parseLegacyPersonBlock(String block){
  final start = block.indexOf('Person(');
  if(start == -1) return null;
  final pOpenParen = start + 'Person('.length - 1;
  final pClose = _findMatchingParen(block, pOpenParen);
  if(pClose == -1) return null;
  final body = block.substring(pOpenParen + 1, pClose);

  final person = _personFromLegacyBody(body);
  if(person == null) return null;

  final emails = _captureLegacyStringList(body, 'email');
  return RegisteredContributorPerson(person: person, emails: emails);
}

/// Wyciąga pola [Person] z ciała wnętrza `Person(...)`. Wspiera oba formaty
/// środowiska: stary `hufiec: '...'` (V1) i nowy `srodowisko: Srodowisko.custom('...')`
/// (V2). Org-tylko fallback: brak hufca/srodowiska + `org: Org.xxx` →
/// `Srodowisko.org(...)`.
Person? _personFromLegacyBody(String body){
  final name = _captureLegacyString(body, 'name');
  if(name == null || name.trim().isEmpty) return null;

  final druzyna = _captureLegacyString(body, 'druzyna');
  final comment = _captureLegacyString(body, 'comment');

  Srodowisko? srodowisko;

  // V2 path: srodowisko: Srodowisko.custom('value')
  final v2Match = RegExp(r"srodowisko:\s*Srodowisko\.custom\('((?:\\'|[^'])*)'\)")
      .firstMatch(body);
  if(v2Match != null) {
    final value = v2Match.group(1)?.replaceAll(r"\'", "'");
    if(value != null && value.isNotEmpty) srodowisko = Srodowisko.custom(value);
  }

  // V1 path: hufiec: 'value'
  if(srodowisko == null) {
    final hufiec = _captureLegacyString(body, 'hufiec');
    if(hufiec != null && hufiec.trim().isNotEmpty) srodowisko = Srodowisko.custom(hufiec);
  }

  // V1 org-only fallback (Person had a separate `org: Org.xxx` field).
  if(srodowisko == null) {
    final orgRaw = _captureLegacyEnumValue(body, 'org');
    if(orgRaw != null) srodowisko = Srodowisko.org(orgRaw);
  }

  final rankHarcRaw = _captureLegacyEnumValue(body, 'rankHarc');
  final rankInstrRaw = _captureLegacyEnumValue(body, 'rankInstr');

  RankHarc? rankHarc;
  if(rankHarcRaw != null)
    rankHarc = RankHarc.values.where((r) => r.name == rankHarcRaw).firstOrNull;

  RankInstr? rankInstr;
  if(rankInstrRaw != null)
    rankInstr = RankInstr.values.where((r) => r.name == rankInstrRaw).firstOrNull;

  return Person(
    name: name,
    druzyna: druzyna,
    srodowisko: srodowisko,
    rankHarc: rankHarc,
    rankInstr: rankInstr,
    comment: comment,
  );
}

/// Walks paren-balance from `openIdx` (which points to '(') and returns the
/// index of the matching ')'. Skips parens inside Dart string literals.
int _findMatchingParen(String s, int openIdx){
  int depth = 0;
  bool inString = false;
  String? quote;
  bool escape = false;
  for(int i = openIdx; i < s.length; i++){
    final c = s[i];
    if(escape) { escape = false; continue; }
    if(inString){
      if(c == r'\') { escape = true; }
      else if(c == quote) { inString = false; quote = null; }
      continue;
    }
    if(c == "'" || c == '"') { inString = true; quote = c; continue; }
    if(c == '(') depth++;
    else if(c == ')') {
      depth--;
      if(depth == 0) return i;
    }
  }
  return -1;
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

final RegExp _userMessageRe = RegExp(
  r'-\s*-\s*-\s*-\s*-\s*-\s*Miejsce na własną wiadomość\s*-\s*-\s*-\s*-\s*-\s*-([\s\S]*?)-\s*-\s*-\s*-\s*-\s*-\s*Zasady dodawania piosenek\s*-\s*-\s*-\s*-\s*-\s*-',
);

const String _userMessagePlaceholder =
    '[Jeśli chcesz coś dodać, skomentować, lub wyjaśnić, możesz to zrobić tutaj.]';

String? _extractUserMessage(String content){
  Match? m = _userMessageRe.firstMatch(content);
  if(m == null) return null;
  String raw = m.group(1) ?? '';
  raw = raw.replaceAll(_userMessagePlaceholder, '');
  String trimmed = raw.trim();
  if(trimmed.isEmpty) return null;
  return trimmed;
}

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
