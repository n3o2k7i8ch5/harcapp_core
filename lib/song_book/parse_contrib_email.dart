import 'dart:convert';

import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/song_book/parse_contrib_email_oldest.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/values/people/models.dart';
import 'package:harcapp_core/values/rank_harc.dart';
import 'package:harcapp_core/values/rank_instr.dart';
import 'package:harcapp_core/values/srodowiska/models.dart';

class ParsedContribEmail{

  final SongRaw song;
  final String? senderEmail;
  final String? acceptedRulesVersion;
  final RegisteredContributor? registered;
  final String? userMessage;
  final bool isNewFormat;
  /// Lista pól z bloku `Osoba dodająca`, które były obecne w mejlu, ale
  /// nie udało się ich zmapować na aktualny model (np. `rankHarc: HO` po
  /// refaktorze enuma). Każdy wpis to gotowy do wyświetlenia komunikat.
  final List<String> personParseWarnings;
  /// True, gdy mejl pochodzi z najstarszej (już nierozwijanej) wersji apki
  /// mobilnej — rozpoznawane po owinięciu piosenki w `{"o!_filename": {...}}`
  /// lub po charakterystycznym nagłówku „Dzięki za chęć dzielenia się…".
  final bool isOldestFormat;

  ParsedContribEmail({
    required this.song,
    required this.senderEmail,
    required this.acceptedRulesVersion,
    required this.registered,
    required this.userMessage,
    required this.isNewFormat,
    this.personParseWarnings = const [],
    this.isOldestFormat = false,
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

  RegisteredContributor? registered;
  String? personJson = _tryExtractFencedBlockAfter(content, '### Osoba dodająca');
  if(personJson != null){
    try {
      Map<String, dynamic> personMap = jsonDecode(personJson) as Map<String, dynamic>;
      final emailsRaw = personMap.remove('email');
      final emails = emailsRaw is List ? emailsRaw.cast<String>() : const <String>[];
      final person = Person.fromApiJsonMap(personMap);
      registered = RegisteredContributor(person: person, emails: emails);
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

  // Najstarsze legacy — patrz `parse_contrib_email_oldest.dart`.
  final oldestDetection = detectOldestFormat(songMap, content);
  songMap = oldestDetection.songMap;
  final isOldestFormat = oldestDetection.isOldestFormat;

  String? title = songMap[SongCore.PARAM_TITLE] as String?;
  if(title == null || title.isEmpty)
    throw ContribEmailParseError('Brak tytułu piosenki w JSON-ie.');

  SongRaw song = SongRaw.fromApiRespMap('o!_${SongCore.filenameFromTitle(title)}', songMap);

  String? acceptedRulesVersion = _extractAcceptedRulesVersion(content);
  String? senderEmail = _extractSenderEmail(content);

  RegisteredContributor? registered;
  List<String> personWarnings = const [];
  int personHeaderIdx = content.indexOf('### Osoba dodająca');
  if(personHeaderIdx != -1 && personHeaderIdx < codeHeaderIdx){
    String personBlock = content.substring(personHeaderIdx, codeHeaderIdx);
    // Try newer-legacy (RegisteredContributor) first, fall back to V1
    // (bare Person), so nested `Person(...)` inside doesn't get mis-matched.
    var parsed = _parseLegacyRegisteredBlock(personBlock);
    if(parsed.registered == null) parsed = _parseLegacyPersonBlock(personBlock);
    registered = parsed.registered;
    personWarnings = parsed.warnings;
  }

  return ParsedContribEmail(
    song: song,
    senderEmail: senderEmail,
    acceptedRulesVersion: acceptedRulesVersion,
    registered: registered,
    userMessage: _extractUserMessage(content),
    isNewFormat: false,
    personParseWarnings: personWarnings,
    isOldestFormat: isOldestFormat,
  );
}

/// Wynik parsowania bloku osoby: zarejestrowany kontrybutor (jeśli się udało)
/// i lista ostrzeżeń o polach, które były obecne w mejlu, ale nie udało się
/// ich zmapować na aktualny model.
class _LegacyPersonParse {
  final RegisteredContributor? registered;
  final List<String> warnings;
  const _LegacyPersonParse(this.registered, this.warnings);
  static const empty = _LegacyPersonParse(null, []);
}

/// Parses the newer legacy block emitted by `contrib_song_email_legacy.dart`:
/// `RegisteredContributor X = const RegisteredContributor(
///    person: Person(...), emails: [...] );`
_LegacyPersonParse _parseLegacyRegisteredBlock(String block){
  const marker = 'RegisteredContributor(';
  final start = block.indexOf(marker);
  if(start == -1) return _LegacyPersonParse.empty;
  final outerOpenParen = start + marker.length - 1; // index of '('
  final outerClose = _findMatchingParen(block, outerOpenParen);
  if(outerClose == -1) return _LegacyPersonParse.empty;
  final outerBody = block.substring(outerOpenParen + 1, outerClose);

  final pIdx = outerBody.indexOf('Person(');
  if(pIdx == -1) return _LegacyPersonParse.empty;
  final pOpenParen = pIdx + 'Person('.length - 1;
  final pClose = _findMatchingParen(outerBody, pOpenParen);
  if(pClose == -1) return _LegacyPersonParse.empty;
  final personBody = outerBody.substring(pOpenParen + 1, pClose);

  final warnings = <String>[];
  final person = _personFromLegacyBody(personBody, warnings);
  if(person == null) return _LegacyPersonParse.empty;

  // Emails sit on the OUTER level (outside Person body). Slice Person out
  // so the regex doesn't accidentally hit something inside.
  final outerWithoutPerson =
      outerBody.substring(0, pIdx) + outerBody.substring(pClose + 1);
  final emails = _captureLegacyStringList(outerWithoutPerson, 'emails');

  return _LegacyPersonParse(
    RegisteredContributor(person: person, emails: emails),
    warnings,
  );
}

/// Parses the original legacy block: `Person X = const Person(... email: [...] );`.
/// Maps `hufiec: '...'` and `org: Org.xxx` onto the new `Srodowisko` model.
_LegacyPersonParse _parseLegacyPersonBlock(String block){
  final start = block.indexOf('Person(');
  if(start == -1) return _LegacyPersonParse.empty;
  final pOpenParen = start + 'Person('.length - 1;
  final pClose = _findMatchingParen(block, pOpenParen);
  if(pClose == -1) return _LegacyPersonParse.empty;
  final body = block.substring(pOpenParen + 1, pClose);

  final warnings = <String>[];
  final person = _personFromLegacyBody(body, warnings);
  if(person == null) return _LegacyPersonParse.empty;

  final emails = _captureLegacyStringList(body, 'email');
  return _LegacyPersonParse(
    RegisteredContributor(person: person, emails: emails),
    warnings,
  );
}

/// Wyciąga pola [Person] z ciała wnętrza `Person(...)`. Wspiera formaty
/// środowiska: strukturalny `Srodowisko.hufiec/choragiew/okreg/org('slug', ...)`
/// (domyślny emitowany format), `Srodowisko.custom('...')`, stary `hufiec: '...'`
/// (V1) oraz org-tylko fallback `org: Org.xxx` → `Srodowisko.org(...)`.
///
/// Pola, które były w mejlu, ale nie zostały rozpoznane (np. `rankHarc: HO`
/// po refaktorze enuma), trafiają do [warnings] jako gotowe komunikaty.
Person? _personFromLegacyBody(String body, List<String> warnings){
  final name = _captureLegacyString(body, 'name');
  if(name == null || name.trim().isEmpty) return null;

  final druzyna = _captureLegacyString(body, 'druzyna');
  final comment = _captureLegacyString(body, 'comment');

  Srodowisko? srodowisko;

  // V2 structural path: srodowisko: Srodowisko.hufiec('slug', showX: false, ...)
  // (also .choragiew / .okreg / .org). Musi być przed `.custom`, bo to jest
  // domyślny format emitowany przez `contrib_song_email_legacy.dart`.
  final structMatch = RegExp(
      r"srodowisko:\s*Srodowisko\.(hufiec|choragiew|okreg|org)\(\s*'((?:\\'|[^'])*)'([^)]*)\)")
      .firstMatch(body);
  if(structMatch != null) {
    final kind = structMatch.group(1)!;
    final slug = structMatch.group(2)!.replaceAll(r"\'", "'");
    final rest = structMatch.group(3) ?? '';
    bool show(String name) => !RegExp('$name:\\s*false').hasMatch(rest);
    final customMatch = RegExp(r"custom:\s*'((?:\\'|[^'])*)'").firstMatch(rest);
    final customVal = customMatch?.group(1)?.replaceAll(r"\'", "'");
    switch(kind){
      case 'hufiec':
        srodowisko = Srodowisko(
          hufiecSlug: slug, custom: customVal,
          showHufiec: show('showHufiec'), showChoragiew: show('showChoragiew'),
          showOkreg: show('showOkreg'), showOrg: show('showOrg'),
        );
        break;
      case 'choragiew':
        srodowisko = Srodowisko(
          choragiewSlug: slug, custom: customVal,
          showChoragiew: show('showChoragiew'), showOkreg: show('showOkreg'),
          showOrg: show('showOrg'),
        );
        break;
      case 'okreg':
        srodowisko = Srodowisko(
          okregSlug: slug, custom: customVal,
          showOkreg: show('showOkreg'), showOrg: show('showOrg'),
        );
        break;
      case 'org':
        srodowisko = Srodowisko(
          orgSlug: slug, custom: customVal, showOrg: show('showOrg'),
        );
        break;
    }
  }

  // V2 custom path: srodowisko: Srodowisko.custom('value')
  if(srodowisko == null) {
    final v2Match = RegExp(r"srodowisko:\s*Srodowisko\.custom\('((?:\\'|[^'])*)'\)")
        .firstMatch(body);
    if(v2Match != null) {
      final value = v2Match.group(1)?.replaceAll(r"\'", "'");
      if(value != null && value.isNotEmpty) srodowisko = Srodowisko.custom(value);
    }
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
  if(rankHarcRaw != null){
    rankHarc = RankHarc.values.where((r) => r.name == rankHarcRaw).firstOrNull;
    if(rankHarc == null)
      warnings.add('rankHarc: $rankHarcRaw — nierozpoznana wartość, pole pominięte.');
  }

  RankInstr? rankInstr;
  if(rankInstrRaw != null){
    rankInstr = RankInstr.values.where((r) => r.name == rankInstrRaw).firstOrNull;
    if(rankInstr == null)
      warnings.add('rankInstr: $rankInstrRaw — nierozpoznana wartość, pole pominięte.');
  }

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
  // Szukamy tylko przed sekcją „### Kod piosenki:" — wszystko poniżej (np.
  // quoted reply chain w mejlu zwrotnym) nie powinno być źródłem nadawcy.
  final int cutoff = content.indexOf('### Kod piosenki:');
  final String haystack = cutoff == -1 ? content : content.substring(0, cutoff);
  final Match? m = _emailAngleRe.firstMatch(haystack);
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
