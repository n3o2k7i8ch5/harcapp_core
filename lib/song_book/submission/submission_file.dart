import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/values/people/models.dart';

/// Rozszerzenie pliku zgłoszenia: nazwa formatu plus `sbm`.
const String kSubmissionFileExtension = 'hrcpsngsbm';

/// Nazwa załącznika — zawsze ta sama, krótka i czysto ASCII, żeby klient
/// pocztowy nie zakodował jej po RFC 2231. Plik rozpoznajemy po rozszerzeniu.
const String kSubmissionFileName = 'submission.$kSubmissionFileExtension';

/// Wersja **protokołu**, nie samego pliku: podbija ją zmiana znacznika
/// w temacie, kontraktu treści albo kształtu pliku.
const int kSubmissionFormat = 1;

/// Znacznik w temacie, np. `[hrcpsng/app]`. Zamrożony: nie podlega
/// wersjonowaniu, bo po nim kolejka łapie **każdą** wersję protokołu.
String submissionSubjectMarker(SubmissionOrigin origin) => '[hrcpsng/${origin.tag}]';

/// Skąd przyszło zgłoszenie. Identyfikator, nie napis do pokazania.
enum SubmissionOrigin{
  appAndroid('app-android', 'app'),
  appIos('app-ios', 'app'),
  web('web', 'web');

  const SubmissionOrigin(this.id, this.tag);

  /// Wartość pola `source` w pliku.
  final String id;
  /// Człon znacznika w temacie: `app` albo `web`.
  final String tag;

  bool get isWeb => this == SubmissionOrigin.web;

  static SubmissionOrigin? byId(String? id) =>
      values.where((s) => s.id == id).firstOrNull;
}

/// Co poszło nie tak z plikiem zgłoszenia.
enum SubmissionFileErrorKind{
  /// Nie JSON, nie ten kształt albo plik obcięty.
  corrupted,
  /// Suma kontrolna się nie zgadza — ktoś plik edytował ręcznie.
  badDigest,
  /// Wersja protokołu nowsza niż znana.
  unknownFormat,
  /// Zero zgłoszeń w liście — nie ma czego przyjąć.
  noSubmissions;
}

/// Skrót na najczęstszy powód odmowy.
Never _corrupted(String message) =>
    throw SubmissionFileError(SubmissionFileErrorKind.corrupted, message);

class SubmissionFileError implements Exception{
  final SubmissionFileErrorKind kind;
  final String message;
  const SubmissionFileError(this.kind, this.message);
  @override
  String toString() => 'SubmissionFileError(${kind.name}): $message';
}

/// Kanoniczna postać JSON-a: klucze posortowane na każdym poziomie, bez
/// białych znaków. Podstawa sumy kontrolnej po obu stronach.
String canonicalJson(Object? value) => jsonEncode(_canonical(value));

Object? _canonical(Object? value){
  if(value is Map){
    final keys = value.keys.map((k) => k.toString()).toList()..sort();
    return {for(final k in keys) k: _canonical(value[k])};
  }
  if(value is List) return [for(final item in value) _canonical(item)];
  return value;
}

/// `sha256` z całego pliku po wyrzuceniu samego pola `digest`. Wykrywa ręczną
/// edycję i obcięcie; łamanie linii nie dotyczy załącznika, który idzie bajt
/// w bajt.
String submissionDigest(Map<String, dynamic> fileMap){
  final withoutDigest = {...fileMap}..remove(SongSubmissionFile.PARAM_DIGEST);
  final bytes = utf8.encode(canonicalJson(withoutDigest));
  return 'sha256:${sha256.convert(bytes)}';
}

/// Jedno zgłoszenie: **jedna** piosenka plus jej metadane.
class SongSubmission{

  static const String PARAM_KIND = 'kind';
  static const String PARAM_CORRECTED_SONG_ID = 'corrected_song_id';
  static const String PARAM_CORRECTED_SONG_DIGEST = 'corrected_song_digest';
  static const String PARAM_CORRECTION_MESSAGE = 'correction_message';
  static const String PARAM_SENDER_IS_CONTRIBUTOR = 'sender_is_contributor';
  static const String PARAM_CONTRIBUTOR = 'contributor';
  static const String PARAM_SONG = 'song';

  static const String PARAM_CONTRIBUTOR_PERSON = 'person';
  static const String PARAM_CONTRIBUTOR_EMAILS = 'emails';
  static const String PARAM_CONTRIBUTOR_USER_KEY = 'user_key';

  /// Id piosenki, jeśli je ma — podpowiedź, bo ostateczne nadaje piosenkomat.
  static const String PARAM_SONG_ID = 'id';

  final SubmissionKind kind;
  /// Co autor **deklaruje**, że poprawia. Wygrywa z `corrected_song_id`
  /// w JSON-ie piosenki, które znaczy co innego: pierwowzór, z którego powstała.
  final String? correctedSongId;
  /// Odcisk wersji pierwowzoru, którą autor widział. Na razie zawsze `null`.
  final String? correctedSongDigest;
  final String? correctionMessage;
  /// Czy nadawca zgłasza **własną** piosenkę. `false`: jego adres służy
  /// wyłącznie do odpisania i nie trafia do karty osoby dodającej.
  final bool senderIsContributor;
  final RegisteredContributor? contributor;
  final SongRaw song;

  const SongSubmission({
    required this.kind,
    required this.song,
    this.correctedSongId,
    this.correctedSongDigest,
    this.correctionMessage,
    this.senderIsContributor = true,
    this.contributor,
  });

  bool get isCorrection => kind == SubmissionKind.correction;

  Map<String, dynamic> toJsonMap() => {
    PARAM_KIND: kind.id,
    PARAM_CORRECTED_SONG_ID: correctedSongId,
    PARAM_CORRECTED_SONG_DIGEST: correctedSongDigest,
    PARAM_CORRECTION_MESSAGE: correctionMessage,
    PARAM_SENDER_IS_CONTRIBUTOR: senderIsContributor,
    PARAM_CONTRIBUTOR: contributor == null? null: {
      PARAM_CONTRIBUTOR_PERSON: contributor!.person.toApiJsonMap(),
      PARAM_CONTRIBUTOR_EMAILS: contributor!.emails,
      PARAM_CONTRIBUTOR_USER_KEY: contributor!.userKey,
    },
    PARAM_SONG: {
      ...song.toApiJsonMap(withId: false).cast<String, dynamic>(),
      if(song.id.isNotEmpty) PARAM_SONG_ID: song.id,
    },
  };

  static SongSubmission fromJsonMap(Map<String, dynamic> map) => SongSubmission(
    kind: SubmissionKind.byId(map[PARAM_KIND] as String?),
    correctedSongId: _nonEmpty(map[PARAM_CORRECTED_SONG_ID]),
    correctedSongDigest: _nonEmpty(map[PARAM_CORRECTED_SONG_DIGEST]),
    correctionMessage: _nonEmpty(map[PARAM_CORRECTION_MESSAGE]),
    senderIsContributor: map[PARAM_SENDER_IS_CONTRIBUTOR] as bool? ?? true,
    contributor: _contributorOf(map[PARAM_CONTRIBUTOR]),
    song: _songOf(map[PARAM_SONG]),
  );

  static SongRaw _songOf(Object? raw){
    if(raw is! Map) _corrupted('Zgłoszenie bez piosenki.');
    final title = raw[SongCore.PARAM_TITLE];
    if(title is! String) _corrupted('Piosenka bez tytułu.');
    try {
      return SongRaw.fromApiRespMap(
        raw[PARAM_SONG_ID] as String? ?? 'o!_${SongCore.filenameFromTitle(title)}',
        raw,
      );
    } catch(e){
      _corrupted('Nie udało się wczytać piosenki: $e');
    }
  }

  static RegisteredContributor? _contributorOf(Object? raw){
    if(raw is! Map) return null;
    final person = raw[PARAM_CONTRIBUTOR_PERSON];
    if(person is! Map) return null;
    try {
      return RegisteredContributor(
        person: Person.fromApiJsonMap(person.cast<String, dynamic>()),
        emails: [
          for(final e in (raw[PARAM_CONTRIBUTOR_EMAILS] as List? ?? const []))
            if(e is String) e
        ],
        userKey: raw[PARAM_CONTRIBUTOR_USER_KEY] as String?,
      );
    } catch(e){
      _corrupted('Nie udało się wczytać osoby dodającej: $e');
    }
  }

}

String? _nonEmpty(Object? raw){
  if(raw is! String) return null;
  final trimmed = raw.trim();
  return trimmed.isEmpty? null: trimmed;
}

/// Plik `.hrcpsngsbm`: fakty o zgłoszeniu, wersjonowane i podpisane sumą
/// kontrolną. Pola przy pliku opisują **wysyłkę**, pola przy zgłoszeniu —
/// **jedną piosenkę**.
class SongSubmissionFile{

  static const String PARAM_FORMAT = 'format';
  static const String PARAM_DIGEST = 'digest';
  static const String PARAM_SOURCE = 'source';
  static const String PARAM_APP_VERSION = 'app_version';
  static const String PARAM_RULES_VERSION = 'rules_version';
  static const String PARAM_SUBMISSIONS = 'submissions';

  final int format;
  final SubmissionOrigin? source;
  final String? appVersion;
  /// Wersja regulaminu zaakceptowana przez **osobę wysyłającą**, nie dodającą.
  final String? rulesVersion;
  final List<SongSubmission> submissions;

  const SongSubmissionFile({
    this.format = kSubmissionFormat,
    required this.submissions,
    this.source,
    this.appVersion,
    this.rulesVersion,
  });

  Map<String, dynamic> toJsonMap(){
    final map = <String, dynamic>{
      PARAM_FORMAT: format,
      PARAM_SOURCE: source?.id,
      PARAM_APP_VERSION: appVersion,
      PARAM_RULES_VERSION: rulesVersion,
      PARAM_SUBMISSIONS: [for(final s in submissions) s.toJsonMap()],
    };
    return {PARAM_DIGEST: submissionDigest(map), ...map};
  }

  /// Zawartość pliku. Wcięcia są dla człowieka; suma liczy się z postaci
  /// kanonicznej, więc formatowanie na nią nie wpływa.
  String encode() => const JsonEncoder.withIndent('  ').convert(toJsonMap());

  String get fileName => kSubmissionFileName;

  /// Wczytuje plik albo rzuca [SubmissionFileError] z rozpoznanym powodem —
  /// piosenkomat robi z każdego osobną etykietę.
  static SongSubmissionFile decode(String raw){
    Object? decoded;
    try {
      decoded = jsonDecode(raw);
    } catch(e){
      _corrupted('Załącznika nie da się wczytać jako JSON: $e');
    }
    if(decoded is! Map) _corrupted('Załącznik nie jest obiektem JSON.');
    final map = decoded.cast<String, dynamic>();

    final format = map[PARAM_FORMAT];
    if(format is! int) _corrupted('Brak wersji formatu.');
    // Wersja przed sumą: pliku z przyszłości nie zgadujemy, choćby suma grała.
    if(format > kSubmissionFormat)
      throw SubmissionFileError(SubmissionFileErrorKind.unknownFormat,
          'Wersja formatu $format jest nowsza niż znana ($kSubmissionFormat).');

    final digest = map[PARAM_DIGEST];
    if(digest is! String) _corrupted('Brak sumy kontrolnej.');
    final expected = submissionDigest(map);
    if(digest != expected)
      throw SubmissionFileError(SubmissionFileErrorKind.badDigest,
          'Suma kontrolna się nie zgadza (w pliku $digest, policzona $expected).');

    final submissions = map[PARAM_SUBMISSIONS];
    if(submissions is! List) _corrupted('Brak listy zgłoszeń.');
    if(submissions.isEmpty)
      throw const SubmissionFileError(SubmissionFileErrorKind.noSubmissions,
          'Plik nie zawiera żadnego zgłoszenia.');

    return SongSubmissionFile(
      format: format,
      source: SubmissionOrigin.byId(map[PARAM_SOURCE] as String?),
      appVersion: _nonEmpty(map[PARAM_APP_VERSION]),
      rulesVersion: _nonEmpty(map[PARAM_RULES_VERSION]),
      submissions: [
        for(final raw in submissions)
          if(raw is Map)
            SongSubmission.fromJsonMap(raw.cast<String, dynamic>())
          else
            _corrupted('Zgłoszenie nie jest obiektem JSON.')
      ],
    );
  }

}
