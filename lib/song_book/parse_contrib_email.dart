import 'dart:convert';
import 'dart:math';

import 'package:harcapp_core/comm_classes/regexp_email.dart';
import 'package:harcapp_core/song_book/mail_quotes.dart';
import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/song_book/parse_contrib_email_old_app.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/submission/submission_email.dart';
import 'package:harcapp_core/song_book/submission/submission_file.dart';
import 'package:harcapp_core/values/people/contributor_ref.dart';
import 'package:harcapp_core/values/people/models.dart';
import 'package:harcapp_core/values/people/utils.dart';
import 'package:harcapp_core/values/rank_harc.dart';
import 'package:harcapp_core/values/rank_instr.dart';
import 'package:harcapp_core/values/srodowiska/models.dart';

/// Nagłówek sekcji z kodem piosenki w treści mejla (formaty sprzed pliku
/// zgłoszenia). Po nim piosenkomat poznaje zgłoszenie.
const String kSongCodeMarker = '### Kod piosenki:';

/// Kształt mejla zgłoszenia, który rozpoznał parser. [id] idzie do rozkładu
/// w raporcie piosenkomatu — po nim poznać, kiedy wolno skasować czytniki
/// starych kształtów.
enum ContribEmailShape {
  /// Najstarsza apka: JSON między znacznikami „nie edytuj", otoczka `o!_`.
  oldApp('old-app'),
  /// `### Kod piosenki:` bez ogrodzeń, osoba jako literał Darta.
  legacy('legacy'),
  /// Bloki ```, osoba jako JSON.
  fenced('fenced'),
  /// Plik zgłoszenia w załączniku.
  file('file');

  const ContribEmailShape(this.id);
  final String id;
}

class ParsedContribEmail{

  final SongRaw song;
  final String? senderEmail;
  final String? acceptedRulesVersion;
  final RegisteredContributor? registered;
  final String? userMessage;
  /// Treść bloku „Propozycja poprawki”. Apka emituje ten blok zawsze —
  /// dla nowych piosenek pusty — więc niepusty znaczy: autor przysłał poprawkę.
  final String? correctionMessage;
  final ContribEmailShape shape;
  /// Lista pól z bloku `Osoba dodająca`, które były obecne w mejlu, ale
  /// nie udało się ich zmapować na aktualny model (np. `rankHarc: HO` po
  /// refaktorze enuma). Każdy wpis to gotowy do wyświetlenia komunikat.
  final List<String> personParseWarnings;
  /// `lclId` piosenki, którą autor poprawia, zadeklarowany przez apkę w pliku
  /// zgłoszenia. `null` znaczy: zgłoszenie tego nie niesie (nowa piosenka albo
  /// kształt mejla bez pliku) i cel trzeba zgadywać.
  final String? correctionTarget;
  /// Rodzaj zadeklarowany przez apkę. Tylko z załącznika; bez niego `null`
  /// i rodzaj wnioskuje się z tematu.
  final SubmissionKind? declaredKind;
  /// Czy nadawca zgłasza własną piosenkę. Tylko z załącznika.
  final bool? senderIsContributor;
  /// Wersja apki, z której poszło zgłoszenie. Tylko z załącznika.
  final String? appVersion;
  /// Skąd przyszło zgłoszenie. Tylko z załącznika.
  final SubmissionOrigin? origin;
  /// Ile zgłoszeń niesie plik. Więcej niż jedno: piosenkomat ich nie rusza —
  /// jeden wątek to jedna piosenka.
  final int submissionCount;

  ParsedContribEmail({
    required this.song,
    required this.senderEmail,
    required this.acceptedRulesVersion,
    required this.registered,
    required this.userMessage,
    this.correctionMessage,
    required this.shape,
    this.personParseWarnings = const [],
    this.correctionTarget,
    this.declaredKind,
    this.senderIsContributor,
    this.appVersion,
    this.origin,
    this.submissionCount = 1,
  });

  /// Fakty z załącznika plus dopisek z treści — ta sama struktura, co ze
  /// starego parsera.
  factory ParsedContribEmail.fromSubmissionFile(
    SongSubmissionFile file,
    String body, {
    String? senderEmail,
  }){
    final submission = file.submissions.first;
    return ParsedContribEmail(
      song: submission.song,
      senderEmail: senderEmail,
      acceptedRulesVersion: file.acceptedRulesVersion,
      registered: submission.registered,
      userMessage: extractSubmissionUserMessage(body),
      correctionMessage: submission.correctionMessage,
      shape: ContribEmailShape.file,
      correctionTarget: submission.correctionTarget,
      declaredKind: submission.kind,
      senderIsContributor: submission.senderIsContributor,
      appVersion: file.appVersion,
      origin: file.origin,
      submissionCount: file.submissions.length,
    );
  }

}

class ContribEmailParseError implements Exception {
  final String message;
  ContribEmailParseError(this.message);
  @override
  String toString() => 'ContribEmailParseError: $message';
}

/// Zgłoszenie z treści mejla, w każdym kształcie sprzed pliku zgłoszenia.
///
/// Piosenkę bierze z [songAttachment] (`.hrcpsng`, który apka dołączała),
/// gdy jest i da się go odczytać — załącznik jedzie bajt w bajt, a JSON
/// w treści klienty pocztowe łamią. Resztę (osoba, zgoda, dopisek) zawsze
/// z treści. Bez załącznika JSON z treści czytamy odpornie na łamanie linii
/// ([_unwrapped]).
ParsedContribEmail parseContribEmail(String content, {String? songAttachment}){
  final attached = songAttachment == null? null: _attachedSong(songAttachment);
  if(attached != null){
    try {
      return _parseAnyShape(content, attached: attached);
    } catch(_){
      // Załącznik nie pasuje do treści — zostaje sama treść.
    }
  }
  return _parseAnyShape(content);
}

ParsedContribEmail _parseAnyShape(String content, {_AttachedSong? attached}){
  try {
    return _parseFenced(content, attached: attached);
  } catch(eFenced){
    try {
      return _parseLegacy(content, attached: attached);
    } catch(eLegacy){
      throw ContribEmailParseError(
        'Nie udało się odczytać piosenki z mejla.\n'
            'Próba formatu z blokami ```: $eFenced\n'
            'Próba formatu legacy: $eLegacy',
      );
    }
  }
}

/// Piosenka z załącznika `.hrcpsng`.
typedef _AttachedSong = ({String id, Map<String, dynamic> map});

/// Pierwsza oficjalna piosenka załącznika albo sam załącznik, gdy to goła
/// piosenka. `null`, gdy nie da się go odczytać.
_AttachedSong? _attachedSong(String attachment){
  try {
    final map = jsonDecode(attachment) as Map<String, dynamic>;
    final official = map['official'];
    if(official is Map && official.isNotEmpty){
      final id = official.keys.first as String;
      final entry = official[id];
      final song = entry is Map? entry['song']: null;
      if(song is Map) return (id: id, map: song.cast<String, dynamic>());
    }
    if(map[SongCore.PARAM_TITLE] case final String title)
      return (id: SongCore.officialIdFromTitle(title), map: map);
  } catch(_){}
  return null;
}

/// Łamanie linii przez klienta pocztowego w JSON-ie z treści.
final RegExp _lineBreakRe = RegExp(r'\r?\n');

/// To samo w regionie starej apki: po zdjęciu cytowania i HTML-a przy
/// łamaniu zostają tam jeszcze odstępy.
final RegExp _oldAppLineBreakRe = RegExp(r'\s*\r?\n\s*');

/// Pierwszy wariant [text], z którego [read] coś odczyta: jak jest, z liniami
/// sklejonymi spacją, sklejonymi bez niej. Klienty pocztowe (np. Gmail na
/// Androidzie) łamią długie linie co ~76 znaków — w miejscu spacji albo
/// w środku słowa — a JSON piosenki w treści to jedna długa linia.
T _unwrapped<T>(String text, RegExp lineBreak, T Function(String) read){
  Object? firstError;
  for(final variant in [text, text.replaceAll(lineBreak, ' '), text.replaceAll(lineBreak, '')]){
    try {
      return read(variant);
    } catch(e){
      firstError ??= e;
    }
  }
  throw firstError!;
}

Map<String, dynamic> _decodeSongMap(String json){
  try {
    return jsonDecode(json) as Map<String, dynamic>;
  } catch(e){
    throw ContribEmailParseError('Nie udało się sparsować JSON-a piosenki: $e');
  }
}

/// Piosenka z mapy JSON-a; bez tytułu nie ma zgłoszenia. Po sklejeniu linii
/// w `email_ref` bywa zbłąkana spacja — adres jej mieć nie może, więc won.
SongRaw _songFromMap(Map<String, dynamic> songMap){
  String? title = songMap[SongCore.PARAM_TITLE] as String?;
  if(title == null || title.isEmpty)
    throw ContribEmailParseError('Brak tytułu piosenki w JSON-ie.');

  SongRaw song = SongRaw.fromApiRespMap(SongCore.officialIdFromTitle(title), songMap);
  song.contribRefs = [
    for(final c in song.contribRefs)
      ContributorRef(
        person: c.person,
        emailRef: c.emailRef?.replaceAll(RegExp(r'\s'), ''),
        userKeyRef: c.userKeyRef?.trim(),
      ),
  ];
  return song;
}

// =====================================================================
// Bloki ``` (kształt sprzed pliku zgłoszenia).
// =====================================================================

ParsedContribEmail _parseFenced(String content, {_AttachedSong? attached}){
  String songJson = _extractFencedBlockAfter(content, kSongCodeMarker);
  SongRaw song = attached != null
      ? _songFromMap(attached.map)
      : _unwrapped(songJson, _lineBreakRe, (json) => _songFromMap(_decodeSongMap(json)));

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
    correctionMessage: extractCorrectionMessage(content),
    shape: ContribEmailShape.fenced,
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

ParsedContribEmail _parseLegacy(String content, {_AttachedSong? attached}){
  int codeHeaderIdx = content.indexOf(kSongCodeMarker);

  // Najstarsza apka sekcji `### Kod piosenki:` nie ma — JSON wkleja między
  // znaczniki „nie edytuj". Patrz `parse_contrib_email_old_app.dart`.
  String songSection;
  if(codeHeaderIdx != -1)
    songSection = content.substring(codeHeaderIdx + kSongCodeMarker.length);
  else {
    final oldApp = oldAppSongRegion(content);
    if(oldApp == null)
      throw ContribEmailParseError('Brak sekcji "### Kod piosenki:".');
    songSection = oldApp;
  }

  // Najstarsze legacy — patrz `parse_contrib_email_old_app.dart`.
  //
  // Znacznik „nie edytuj" liczy się tylko przed sekcją `### Kod piosenki:`.
  // Odpowiedź z nowej apki cytuje stary mejl pod spodem — gdyby ten cytat
  // robił z niej zgłoszenie ze starej apki, przeszłaby bez sprawdzenia zgody.
  final String textBeforeCode = codeHeaderIdx == -1 ? content : content.substring(0, codeHeaderIdx);
  ({SongRaw song, bool isOldAppFormat}) songOf(Map<String, dynamic> songMap){
    final oldAppDetection = detectOldAppFormat(songMap, textBeforeCode);
    songMap = oldAppDetection.songMap;
    // Najstarsza apka bywa niechlujna w `add_pers` — patrz
    // `normalizeOldAppSongMap`. Nowszych formatów to nie dotyka.
    if(oldAppDetection.isOldAppFormat) songMap = normalizeOldAppSongMap(songMap);
    return (song: _songFromMap(songMap), isOldAppFormat: oldAppDetection.isOldAppFormat);
  }

  // Otoczka `{"o!_id": {...}}` to znak rozpoznawczy najstarszej apki
  // (`detectOldAppFormat`), więc piosenkę z załącznika owijamy tylko wtedy,
  // gdy treść też ją miała — inaczej mejl z nowszej apki bez ``` wyglądałby
  // na stary format.
  final read = attached != null
      ? songOf(_oldAppWrapperRe.hasMatch(songSection) ? {attached.id: attached.map} : attached.map)
      : _unwrapped(
          songSection,
          codeHeaderIdx != -1 ? _lineBreakRe : _oldAppLineBreakRe,
          (section) => songOf(_decodeSongMap(_extractFirstJsonObject(section))),
        );
  final SongRaw song = read.song;
  final bool isOldAppFormat = read.isOldAppFormat;

  String? acceptedRulesVersion = _extractAcceptedRulesVersion(content);
  String? senderEmail = _extractSenderEmail(content);

  RegisteredContributor? registered;
  List<String> personWarnings = const [];
  int personHeaderIdx = content.indexOf('### Osoba dodająca');
  if(personHeaderIdx != -1 && codeHeaderIdx != -1 && personHeaderIdx < codeHeaderIdx){
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
    correctionMessage: extractCorrectionMessage(content),
    // Najstarsza apka — rozpoznana po otoczce `{"o!_filename": {...}}`,
    // nagłówku „Dzięki za chęć dzielenia się…" albo znacznikach „nie edytuj".
    shape: isOldAppFormat? ContribEmailShape.oldApp: ContribEmailShape.legacy,
    personParseWarnings: personWarnings,
  );
}

final RegExp _oldAppWrapperRe = RegExp(r'^\s*\{\s*"o!_');

/// Wynik parsowania bloku osoby: zarejestrowany kontrybutor (jeśli się udało)
/// i lista ostrzeżeń o polach, które były obecne w mejlu, ale nie udało się
/// ich zmapować na aktualny model.
class _LegacyPersonParse {
  final RegisteredContributor? registered;
  final List<String> warnings;
  const _LegacyPersonParse(this.registered, this.warnings);
  static const empty = _LegacyPersonParse(null, []);
}

/// Parses the newer legacy block — the shape `registeredContributorDartCode` emits:
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
  // domyślny format emitowany przez `registeredContributorDartCode`.
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

String? _extractSenderEmail(String content){
  // Szukamy tylko przed sekcją „### Kod piosenki:" — wszystko poniżej (np.
  // quoted reply chain w mejlu zwrotnym) nie powinno być źródłem nadawcy.
  final int cutoff = content.indexOf(kSongCodeMarker);
  final String haystack = cutoff == -1 ? content : content.substring(0, cutoff);
  final String? email = regExpAngledEmail.firstMatch(haystack)?.group(1);
  return email == null? null: normalizedEmail(email);
}

final RegExp _acceptRulesRe = RegExp(
  r'akceptuj[ęe]\s+zasady\s+dodawania\s+piosenek\s+do\s+aplikacji\s+HarcApp\s*\(\s*([^,\)]+?)\s*[,\)]',
  caseSensitive: false,
);

/// Znaczniki, od których zaczyna się to, co dokłada szablon zgłoszenia
/// w starszych kształtach mejla; belki kształtu z załącznikiem są
/// w [submissionBarRes]. W zwykłej odpowiedzi ich nie ma — ale klient
/// pocztowy bywa kreatywny i cytuje treść bez `>`, a wtedy do „wiadomości”
/// wpadłby cały kod piosenki.
final RegExp _templateStartRe = RegExp(
  r'^(\s*-\s*){6}\s*(Zasady dodawania piosenek|Nie edytuj poniższego)'
  r'|^###\s*(Kod piosenki|Osoba dodająca|Propozycja poprawki|Źródło piosenki)',
  multiLine: true,
);

/// Sama belka „Miejsce na własną wiadomość” — nagłówek pola, nie treść.
final RegExp _userMessageBarRe = RegExp(
  r'^(\s*-\s*){6}\s*Miejsce na własną wiadomość(\s*-\s*){6}\s*$',
  multiLine: true,
);

/// Treść wiadomości bez tego, co dokłada szablon: belek, kodu piosenki,
/// karty osoby dodającej i podpowiedzi w nawiasach kwadratowych.
/// `null`, gdy po wycięciu nie zostaje nic.
String? stripSubmissionTemplate(String body){
  final starts = [
    for (final re in [_templateStartRe, ...submissionBarRes])
      if (re.firstMatch(body) case final m?) m.start,
  ];
  String text = starts.isEmpty? body: body.substring(0, starts.reduce(min));
  text = text
      .replaceAll(_userMessageBarRe, '')
      .replaceAll(submissionUserMessagePlaceholderRe, '')
      .trim();
  return text.isEmpty? null: text;
}

/// Dopisek autora w zgłoszeniu z załącznikiem: wszystko nad zamrożoną belką
/// ([kSubmissionConsentBar]). `null`, gdy belki nie ma — mejl w starym
/// kształcie.
String? extractSubmissionUserMessage(String body) => _authorNote(body, _consentBarRe);

final RegExp _consentBarRe = submissionBarRe(kSubmissionConsentBar);

String? _extractUserMessage(String content) => _authorNote(content, _userMessageBarRe);

/// Dopisek autora w każdym kształcie zgłoszenia: to, co nad szablonem, bez
/// znaczników cytatu i bez podpowiedzi ([stripSubmissionTemplate]). Tylko
/// w mejlu z polem na dopisek, rozpoznanym po belce [fieldBar] — najstarsza
/// apka pola nie miała, a nad jej JSON-em stoi tylko powitanie.
String? _authorNote(String body, RegExp fieldBar){
  final text = unquoted(body);
  return fieldBar.hasMatch(text)? stripSubmissionTemplate(text): null;
}

final RegExp _correctionFenceRe = RegExp(
  r'### Propozycja poprawki:\s*```[a-zA-Z]*\s*\n([\s\S]*?)```',
);

/// Blok „Propozycja poprawki” — `null`, gdy pusty albo go nie ma.
String? extractCorrectionMessage(String content){
  final m = _correctionFenceRe.firstMatch(content);
  final text = m?.group(1)?.trim();
  return text == null || text.isEmpty? null: text;
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
