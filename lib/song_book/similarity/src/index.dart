/// Indeks piosenek do szukania podobnych: śpiewnik apki, warsztat na stronie,
/// paczka zgłoszeń. Jeden typ dla wszystkich trzech — różni się tylko to,
/// co do niego wpada.
library;

import 'dart:math';
import 'dart:typed_data';

import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';

import 'evidence.dart';
import 'level.dart';
import 'profile.dart';

/// Skąd jest piosenka, do której coś jest podobne. Na trafieniu, nie na
/// indeksie: UI pokazuje jedną listę z dwóch indeksów, a przy każdej pozycji
/// podpis „w apce” / „w warsztacie”.
enum MatchSource {
  app('w apce'),
  workspace('w warsztacie');

  const MatchSource(this.inText);

  /// Człon zdania: „„Barka” **w apce**: ten sam tytuł”.
  final String inText;
}

/// Jedno trafienie: pełna piosenka (nie tylko id i tytuł), skąd jest,
/// i dowody. Poziom to reguła nad dowodami — liczona raz, przy pierwszym
/// odczycie, bo sortowanie i filtrowanie pytają o niego wielokrotnie.
class SongMatch<T extends SongCore> {
  final T song;
  final MatchSource source;
  final List<Similarity> similarities;

  SongMatch({
    required this.song,
    required this.similarities,
    this.source = MatchSource.app,
  });

  late final MatchLevel? level = levelOf(similarities);

  /// Jak blisko są teksty — do sortowania w obrębie poziomu.
  late final double score = similarityScore(similarities);

  /// Gotowe zdanie do pastylki i raportu:
  /// `„Barka” w apce: ten sam tytuł, 12 wspólnych wersów, 4 nowe`.
  String get detail => '„${song.title}” ${source.inText}: ${similaritiesText(similarities)}';
}

/// Od najsilniejszego: poziom, potem bliskość tekstów. Jedna reguła dla
/// listy z jednego indeksu i dla zszytej listy z kilku.
int compareSongMatches(SongMatch a, SongMatch b) {
  final byLevel = (a.level?.index ?? MatchLevel.values.length)
      .compareTo(b.level?.index ?? MatchLevel.values.length);
  if (byLevel != 0) return byLevel;
  return b.score.compareTo(a.score);
}

/// Jak [SongIndex.lookupId] trafiło. Id ma postać `o!_tytuł@wykonawca`,
/// a zmiana wykonawcy w apce zmienia id — zgłoszenie bywa sprzed niej.
enum IdLookup {
  /// Dokładnie to id — fakt.
  exact,
  /// Tylko bez członu `@wykonawca`, i tylko jedna piosenka — **domysł**.
  /// Wołający ma go oznaczyć, nie podawać jak trafienia.
  withoutPerformer,
  /// Bez `@wykonawca` pasuje kilka różnych piosenek — nic nie wybieramy.
  ambiguous,
}

/// Wynik [SongIndex.lookupId]: piosenki i to, **jak** je znaleziono.
class IdHit<T extends SongCore> {
  final IdLookup how;
  /// [IdLookup.exact] i [IdLookup.withoutPerformer]: wszystkie pod znalezionym
  /// id (w warsztacie id potrafi się powtarzać). [IdLookup.ambiguous]:
  /// kandydaci, po jednym na każde id.
  final List<T> songs;

  const IdHit(this.how, this.songs);

  bool get isGuessed => how != IdLookup.exact;
}

/// Piosenki, z którymi porównujemy.
///
/// Dwa kroki: najpierw tanio wybieramy kandydatów (ten sam tytuł, id,
/// nagranie, a z odwróconego indeksu słów — najbliższe tekstem), potem
/// każdego porównujemy dokładnie ([compare]). Przy 2,5 tys. piosenek
/// i przeliczaniu z każdym znakiem w edytorze to jest różnica między
/// „nie widać” a „zacina się”.
class SongIndex<T extends SongCore> {
  /// Tylu najbliższych po słowach porównujemy dokładnie, choćby byli daleko.
  static const int _nearest = 10;
  /// …a ponad nich każdego, kto jest przynajmniej tak blisko (Jaccard słów
  /// ważonych rzadkością). Piosenka z kilkunastoma wersjami w śpiewniku nie
  /// straci żadnej.
  static const double _nearEnough = 0.2;

  final List<T> songs;
  final List<SongProfile> profiles;
  final Map<String, List<int>> _byTitleKey = {};
  final Map<String, List<int>> _byId = {};
  /// Id bez członu `@wykonawca` → numery. Do drugiej rundy [byId] bez
  /// skanowania i bez `split` na każdym profilu.
  final Map<String, List<int>> _byBareId = {};
  final Map<String, List<int>> _byYoutube = {};
  /// Tekst dosłownie → numery, tylko dla piosenek bez ani jednego słowa
  /// (`♪ ♪`, same kropki): odwrócony indeks słów ich nie widzi, a to jedyna
  /// droga do `identical`.
  final Map<String, List<int>> _byWordlessText = {};
  /// Słowo → numery piosenek, w których występuje.
  final Map<String, List<int>> _byWord = {};

  SongIndex(List<T> songs) : this._(songs, [for (final s in songs) SongProfile(s)]);

  /// Jak konstruktor, ale co [slice] oddaje wątek. Na webie `compute` nie ma
  /// osobnego wątku, a odciski 2,5 tys. piosenek liczone jednym ciągiem
  /// zamroziłyby stronę na start; tak strona żyje, a indeks dochodzi w tle.
  static Future<SongIndex<T>> inSlices<T extends SongCore>(List<T> songs,
      {Duration slice = const Duration(milliseconds: 12)}) async {
    final profiles = <SongProfile>[];
    final sw = Stopwatch()..start();
    for (final s in songs) {
      profiles.add(SongProfile(s));
      if (sw.elapsed >= slice) {
        await Future<void>.delayed(Duration.zero);
        sw.reset();
      }
    }
    return SongIndex._(songs, profiles);
  }

  SongIndex._(this.songs, this.profiles) {
    for (var i = 0; i < profiles.length; i++) {
      final p = profiles[i];
      if (p.id.isNotEmpty) {
        _byId.putIfAbsent(p.id, () => []).add(i);
        _byBareId.putIfAbsent(_bare(p.id), () => []).add(i);
      }
      for (final k in p.titleKeys) {
        _byTitleKey.putIfAbsent(k, () => []).add(i);
      }
      if (p.youtubeId.isNotEmpty) _byYoutube.putIfAbsent(p.youtubeId, () => []).add(i);
      if (p.words.isEmpty && p.text.isNotEmpty) _byWordlessText.putIfAbsent(p.text, () => []).add(i);
      for (final w in p.words) {
        _byWord.putIfAbsent(w, () => []).add(i);
      }
    }
  }

  static String _bare(String id) => id.split('@').first;

  int get length => songs.length;
  bool get isEmpty => songs.isEmpty;

  bool has(String songId) => _byId.containsKey(songId);

  /// Jedno wyszukiwanie po id dla wszystkich — edytora i piosenkomatu —
  /// żeby ta sama poprawka nie miała w jednym miejscu celu, a w drugim nie.
  /// Dokładnie, a przy chybieniu bez członu `@wykonawca` (zgłoszenie bywa
  /// sprzed zmiany wykonawcy w apce); to drugie jest domysłem i wynik to mówi
  /// ([IdHit.how]). Kilka różnych piosenek bez `@wykonawca` → [IdLookup.ambiguous],
  /// nie pierwsza z brzegu. Puste id to nie id: `null`.
  IdHit<T>? lookupId(String id) {
    if (id.isEmpty) return null;
    if (_byId[id] case final exact?) {
      return IdHit(IdLookup.exact, [for (final i in exact) songs[i]]);
    }
    final bare = _byBareId[_bare(id)];
    if (bare == null) return null;
    final byFullId = <String, List<int>>{};
    for (final i in bare) {
      byFullId.putIfAbsent(profiles[i].id, () => []).add(i);
    }
    if (byFullId.length > 1) {
      return IdHit(IdLookup.ambiguous, [for (final ids in byFullId.values) songs[ids.first]]);
    }
    return IdHit(IdLookup.withoutPerformer, [for (final i in byFullId.values.single) songs[i]]);
  }

  /// Piosenka po `lclId` ([lookupId]) — przy powtórzonym id pierwsza z listy,
  /// przy niejednoznacznym `null`. Czy to domysł, mówi dopiero [lookupId].
  T? byId(String id) => allById(id).firstOrNull;

  /// **Wszystkie** piosenki pod tym id ([lookupId]) — w warsztacie id potrafi
  /// się powtarzać, a wtedy „ta jedna” to za mało. Niejednoznaczne → pusto.
  List<T> allById(String id) => switch (lookupId(id)) {
        IdHit(how: IdLookup.exact || IdLookup.withoutPerformer, :final songs) => songs,
        _ => const [],
      };

  SongMatch<T> _match(int i, SongProfile song, MatchSource source) => SongMatch(
        song: songs[i],
        source: source,
        similarities: compare(song, profiles[i]),
      );

  /// Porównanie ze **wskazaną** piosenką, nie z najbliższą — dokładnie po id.
  /// Tego używa piosenkomat, gdy apka powiedziała w zgłoszeniu, którą piosenkę
  /// autor poprawiał; id z rundy bez `@wykonawca` bierze najpierw z [lookupId],
  /// żeby wiedzieć, że to domysł. `null`, gdy takiego id nie ma.
  SongMatch<T>? matchTo(String songId, SongProfile song, {MatchSource source = MatchSource.app}) {
    final i = _byId[songId]?.first;
    if (i == null) return null;
    return _match(i, song, source);
  }

  /// Rzadkość słowa: ln(1 + N/df), wygładzona tak, żeby mały indeks
  /// (warsztat, paczka) nie zerował wag.
  double _idf(int documents) => log(1 + (profiles.length + 1) / (documents + 1));

  late final List<double> _idfSum = [
    for (final p in profiles) p.words.fold(0.0, (a, w) => a + _idf(_byWord[w]!.length)),
  ];

  /// Najbliższe tekstem po słowach: Jaccard zbiorów słów ważonych rzadkością,
  /// liczony z odwróconego indeksu — gęsty licznik, a nie 2,5 tys. przecięć
  /// zbiorów. Częste słowa („i”, „się”, „nie”) ważą mało, więc nie ciągną
  /// wszystkiego do wszystkiego.
  Iterable<int> _nearestByWords(SongProfile song) {
    final shared = Float64List(profiles.length);
    final touched = <int>[];
    var own = 0.0;
    for (final w in song.words) {
      final posting = _byWord[w];
      final weight = _idf(posting?.length ?? 0);
      own += weight;
      if (posting == null) continue;
      for (final i in posting) {
        if (shared[i] == 0) touched.add(i);
        shared[i] += weight;
      }
    }
    final scored = [
      for (final i in touched) (i, shared[i] / (own + _idfSum[i] - shared[i])),
    ]..sort((a, b) => b.$2.compareTo(a.$2));
    return [
      for (var k = 0; k < scored.length; k++)
        if (k < _nearest || scored[k].$2 >= _nearEnough) scored[k].$1,
    ];
  }

  /// Kto w ogóle może mieć poziom: wspólny tytuł, id, nagranie, dosłowny
  /// tekst bez słów albo bliskość po słowach. Reszty nie trzeba porównywać.
  Set<int> _candidates(SongProfile song) => {
        for (final k in song.titleKeys) ...?_byTitleKey[k],
        // Kandydaci, nie wniosek: tu także niejednoznaczne bez `@wykonawca`.
        if (song.id.isNotEmpty) ...?(_byId[song.id] ?? _byBareId[_bare(song.id)]),
        if (song.youtubeId.isNotEmpty) ...?_byYoutube[song.youtubeId],
        if (song.words.isEmpty && song.text.isNotEmpty) ...?_byWordlessText[song.text],
        ..._nearestByWords(song),
      };

  /// **Wszystkie** trafienia z poziomem, od najsilniejszego. To zasila belkę
  /// i przeglądarkę — człowiek chce zobaczyć każdą kandydatkę.
  ///
  /// [exclude] wyłącza piosenki, których nie ma sensu porównywać: samą
  /// siebie (ten sam obiekt w warsztacie) i pierwowzór poprawki, który UI
  /// pokazuje osobno.
  List<SongMatch<T>> matches(SongProfile song,
      {MatchSource source = MatchSource.app, bool Function(T song)? exclude}) {
    final out = <SongMatch<T>>[];
    for (final i in _candidates(song)) {
      if (exclude != null && exclude(songs[i])) continue;
      final m = _match(i, song, source);
      if (m.level != null) out.add(m);
    }
    out.sort(compareSongMatches);
    return out;
  }

  /// Najsilniejsze trafienie — po treści, tytuł niczego tu nie przesądza:
  /// piosenka o tym samym tytule i innym tekście przegrywa z piosenką o tym
  /// samym tekście i innym tytule.
  SongMatch<T>? closest(SongProfile song, {MatchSource source = MatchSource.app}) =>
      matches(song, source: source).firstOrNull;
}

/// Którą piosenkę z [index] [song] **deklaruje**, że poprawia — albo `null`,
/// gdy nic nie deklaruje albo pierwowzoru nie ma w indeksie.
///
/// Szukamy **po id, nie po tytule**: poprawka wolno zmienia tytuł, a dalej
/// dotyczy tej samej piosenki. Dwa źródła deklaracji: `correctionTarget` ze
/// śladu piosenkomatu i `correctedSongId` z JSON-a piosenki (piosenka własna
/// pamięta, z czego powstała). Sama kolizja id deklaracją **nie jest** — nowa
/// piosenka o zajętym id to konflikt, nie poprawka; o nim mówi dowód
/// [SameId] w [SongIndex.matches].
T? correctionTargetOf<T extends SongCore>(SongCore song, SongIndex<T> index) =>
    correctionTargetLookupOf(song, index)?.song;

/// To samo, co [correctionTargetOf], plus **czy to domysł**: pierwowzór
/// znaleziony dopiero bez członu `@wykonawca` ([IdLookup.withoutPerformer]).
/// Przy kilku pasujących bez wykonawcy nic nie wybieramy — `null`.
({T song, bool guessed})? correctionTargetLookupOf<T extends SongCore>(
    SongCore song, SongIndex<T> index) {
  final data = song is SongRaw ? song.piosenkomatData : null;
  final correctedSongId = song is SongRaw ? song.correctedSongId : null;

  // Ślad piosenkomatu jest rozstrzygający: piosenka zgłoszona jako „nowa”
  // nie jest poprawką, choćby niosła `correctedSongId` — przerobiona z cudzej
  // i wysłana jako nowa też je ma, a to żadna deklaracja.
  if (data != null && data.kind != SubmissionKind.correction) return null;

  // Po wszystkich pod tym id, nie po pierwszym: w warsztacie id się
  // powtarza, a sąsiad pod tym samym id to kolizja, nie pierwowzór — tak
  // samo jak sama piosenka.
  ({T song, bool guessed})? declared(String? id) {
    if (id == null || id.isEmpty) return null;
    final hit = index.lookupId(id);
    if (hit == null || hit.how == IdLookup.ambiguous) return null;
    for (final found in hit.songs) {
      if (!identical(found, song)) return (song: found, guessed: hit.isGuessed);
    }
    return null;
  }

  return declared(data?.correctionTarget) ?? declared(correctedSongId);
}
