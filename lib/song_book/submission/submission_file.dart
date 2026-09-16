import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/values/people/models.dart';

/// Rozszerzenie pliku zgłoszenia. Reguła na przyszłość: format plus `sbm`,
/// czyli `hrcpartclsbm` dla artykułów i tak dalej.
const String kSubmissionFileExtension = 'hrcpsngsbm';

/// Wersja **protokołu zgłoszeń z apki**, nie samego pliku. Podbija ją zmiana
/// któregokolwiek z trzech elementów: znacznika w temacie, kontraktu treści
/// (gdzie kończy się dopisek autora) albo kształtu pliku. Jeden numer na jeden
/// protokół — inaczej za pół roku nie odpowiesz na pytanie „co dokładnie
/// wysyłała apka w wersji X”.
const int kSubmissionFormat = 1;

/// Znacznik w temacie mejla. **Zamrożony na zawsze**, nie podlega
/// wersjonowaniu: gdyby podlegał, mejl w nowszym protokole nie wpadłby do
/// kolejki starszego narzędzia i reguła „nieznana wersja → ostrzeżenie” nigdy
/// by się nie odpaliła.
String submissionSubjectMarker(SubmissionOrigin origin) => '[hrcpsng/${origin.tag}]';

/// Skąd przyszło zgłoszenie. Identyfikator, nie napis do pokazania —
/// piosenkomat obsługuje wyłącznie [SubmissionOrigin.web] **odsiewając** je.
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
  /// Załącznika nie da się wczytać jako JSON albo nie ma kształtu pliku
  /// zgłoszenia. Obcięty plik wpada tutaj.
  corrupted,
  /// Suma kontrolna się nie zgadza — ktoś plik edytował ręcznie.
  badDigest,
  /// Plik poprawny, ale w wersji protokołu nowszej niż znana. **Nie zgadujemy**
  /// jego zawartości.
  unknownFormat,
  /// Zero zgłoszeń w liście — nie ma czego przyjąć.
  noSubmissions;
}

class SubmissionFileError implements Exception{
  final SubmissionFileErrorKind kind;
  final String message;
  const SubmissionFileError(this.kind, this.message);
  @override
  String toString() => 'SubmissionFileError(${kind.name}): $message';
}

/// Kanoniczna postać JSON-a: klucze posortowane alfabetycznie na każdym
/// poziomie, bez białych znaków między elementami. Obie strony — apka
/// i piosenkomat — liczą sumę z **tej samej** funkcji, nie z dwóch własnych.
String canonicalJson(Object? value) => jsonEncode(_canonical(value));

Object? _canonical(Object? value){
  if(value is Map){
    final keys = value.keys.map((k) => k.toString()).toList()..sort();
    return {for(final k in keys) k: _canonical(value[k])};
  }
  if(value is List) return [for(final item in value) _canonical(item)];
  return value;
}

/// Suma kontrolna liczona z **całego pliku po wyrzuceniu samego pola
/// `digest`**: wszystko inne wchodzi, razem z tekstem piosenki, chwytami,
/// kartą osoby i wersją regulaminu.
///
/// Nie broni przed połamaniem linii — od tego jest sam załącznik, który idzie
/// bajt w bajt. Broni przed ręczną edycją pliku i przed obcięciem.
String submissionDigest(Map<String, dynamic> fileMap){
  final withoutDigest = {...fileMap}..remove(SongSubmissionFile.PARAM_DIGEST);
  final bytes = utf8.encode(canonicalJson(withoutDigest));
  return 'sha256:${sha256.convert(bytes)}';
}

/// Jedno zgłoszenie: **jedna piosenka** plus jej własne metadane. Kilka
/// piosenek to kilka zgłoszeń w liście, nigdy lista piosenek w zgłoszeniu.
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

  /// Piosenka niesie swoje `id`, jeśli je ma — przy poprawce to samo, co
  /// [correctedSongId], przy nowej piosence tylko podpowiedź. Id ostateczne
  /// i tak nadaje piosenkomat.
  static const String PARAM_SONG_ID = 'id';

  final SubmissionKind kind;
  /// Co autor **deklaruje**, że poprawia. Wygrywa z `corrected_song_id`
  /// w JSON-ie piosenki, które znaczy co innego: tam „piosenka pamięta swój
  /// pierwowzór”, tu „autor deklaruje, co poprawia”.
  final String? correctedSongId;
  /// Miejsce na odcisk wersji pierwowzoru, którą autor widział. Na razie
  /// zawsze `null` — pole jest od początku, żeby nie podbijać [kSubmissionFormat].
  final String? correctedSongDigest;
  final String? correctionMessage;
  /// Apka pyta przed wysyłką: „wysyłam piosenkę proponowaną przeze mnie” albo
  /// „wysyłam w imieniu innej osoby”. `false` znaczy: adres nadawcy służy
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

  static SongSubmission fromJsonMap(Map<String, dynamic> map){
    final songMap = map[PARAM_SONG];
    if(songMap is! Map)
      throw const SubmissionFileError(
          SubmissionFileErrorKind.corrupted, 'Zgłoszenie bez piosenki.');

    final title = songMap[SongCore.PARAM_TITLE];
    if(title is! String)
      throw const SubmissionFileError(
          SubmissionFileErrorKind.corrupted, 'Piosenka bez tytułu.');

    final id = songMap[PARAM_SONG_ID] as String?;
    final SongRaw song;
    try {
      song = SongRaw.fromApiRespMap(
        id ?? 'o!_${SongCore.filenameFromTitle(title)}',
        songMap,
      );
    } catch(e){
      throw SubmissionFileError(
          SubmissionFileErrorKind.corrupted, 'Nie udało się wczytać piosenki: $e');
    }

    RegisteredContributor? contributor;
    final contributorMap = map[PARAM_CONTRIBUTOR];
    if(contributorMap is Map){
      final personMap = contributorMap[PARAM_CONTRIBUTOR_PERSON];
      if(personMap is Map){
        try {
          contributor = RegisteredContributor(
            person: Person.fromApiJsonMap(personMap.cast<String, dynamic>()),
            emails: [
              for(final e in (contributorMap[PARAM_CONTRIBUTOR_EMAILS] as List? ?? const []))
                if(e is String) e
            ],
            userKey: contributorMap[PARAM_CONTRIBUTOR_USER_KEY] as String?,
          );
        } catch(e){
          throw SubmissionFileError(SubmissionFileErrorKind.corrupted,
              'Nie udało się wczytać osoby dodającej: $e');
        }
      }
    }

    return SongSubmission(
      kind: SubmissionKind.byId(map[PARAM_KIND] as String?),
      correctedSongId: _nonEmpty(map[PARAM_CORRECTED_SONG_ID]),
      correctedSongDigest: _nonEmpty(map[PARAM_CORRECTED_SONG_DIGEST]),
      correctionMessage: _nonEmpty(map[PARAM_CORRECTION_MESSAGE]),
      senderIsContributor: map[PARAM_SENDER_IS_CONTRIBUTOR] as bool? ?? true,
      contributor: contributor,
      song: song,
    );
  }

}

String? _nonEmpty(Object? raw){
  if(raw is! String) return null;
  final trimmed = raw.trim();
  return trimmed.isEmpty? null: trimmed;
}

/// Plik `.hrcpsngsbm`: fakty o zgłoszeniu wyjęte z treści mejla, wersjonowane
/// i podpisane sumą kontrolną. Pola przy pliku opisują **wysyłkę**, pola przy
/// zgłoszeniu — **jedną piosenkę**.
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

  /// Zawartość pliku. Wcięcia są dla człowieka, który go otworzy — suma liczy
  /// się z postaci kanonicznej, więc formatowanie na nią nie wpływa.
  String encode() => const JsonEncoder.withIndent('  ').convert(toJsonMap());

  /// Nazwa pliku: `song_<nazwa>.hrcpsngsbm` przy jednym zgłoszeniu,
  /// `songs_<liczba>.hrcpsngsbm` przy wielu.
  String get fileName => submissions.length == 1
      ? 'song_${submissions.single.song.generateFileName(withPerformer: true)}.$kSubmissionFileExtension'
      : 'songs_${submissions.length}.$kSubmissionFileExtension';

  /// Wczytanie z rzuceniem [SubmissionFileError] o rozpoznanym powodzie —
  /// piosenkomat robi z niego osobną etykietę, więc powód musi być rozróżnialny.
  static SongSubmissionFile decode(String raw){
    Object? decoded;
    try {
      decoded = jsonDecode(raw);
    } catch(e){
      throw SubmissionFileError(SubmissionFileErrorKind.corrupted,
          'Załącznika nie da się wczytać jako JSON: $e');
    }
    if(decoded is! Map)
      throw const SubmissionFileError(
          SubmissionFileErrorKind.corrupted, 'Załącznik nie jest obiektem JSON.');
    final map = decoded.cast<String, dynamic>();

    final format = map[PARAM_FORMAT];
    if(format is! int)
      throw const SubmissionFileError(
          SubmissionFileErrorKind.corrupted, 'Brak wersji formatu.');
    // Nieznana wersja idzie przed sumą: pliku z przyszłości nie zgadujemy,
    // nawet gdyby suma się zgadzała.
    if(format > kSubmissionFormat)
      throw SubmissionFileError(SubmissionFileErrorKind.unknownFormat,
          'Wersja formatu $format jest nowsza niż znana ($kSubmissionFormat).');

    final digest = map[PARAM_DIGEST];
    if(digest is! String)
      throw const SubmissionFileError(
          SubmissionFileErrorKind.corrupted, 'Brak sumy kontrolnej.');
    final expected = submissionDigest(map);
    if(digest != expected)
      throw SubmissionFileError(SubmissionFileErrorKind.badDigest,
          'Suma kontrolna się nie zgadza (w pliku $digest, policzona $expected).');

    final rawSubmissions = map[PARAM_SUBMISSIONS];
    if(rawSubmissions is! List)
      throw const SubmissionFileError(
          SubmissionFileErrorKind.corrupted, 'Brak listy zgłoszeń.');
    if(rawSubmissions.isEmpty)
      throw const SubmissionFileError(
          SubmissionFileErrorKind.noSubmissions, 'Plik nie zawiera żadnego zgłoszenia.');

    return SongSubmissionFile(
      format: format,
      source: SubmissionOrigin.byId(map[PARAM_SOURCE] as String?),
      appVersion: _nonEmpty(map[PARAM_APP_VERSION]),
      rulesVersion: _nonEmpty(map[PARAM_RULES_VERSION]),
      submissions: [
        for(final raw in rawSubmissions)
          if(raw is Map)
            SongSubmission.fromJsonMap(raw.cast<String, dynamic>())
          else
            throw const SubmissionFileError(
                SubmissionFileErrorKind.corrupted, 'Zgłoszenie nie jest obiektem JSON.')
      ],
    );
  }

}
