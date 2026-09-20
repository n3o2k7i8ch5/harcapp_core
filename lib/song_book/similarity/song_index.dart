/// Indeks piosenek do szukania podobnych: śpiewnik apki, warsztat na stronie,
/// paczka zgłoszeń. Jeden typ dla wszystkich trzech — różni się tylko to,
/// co do niego wpada.
library;

import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';

import 'similarity.dart';

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

  /// Pokrycie tekstu — do sortowania w obrębie poziomu.
  late final double overlap =
      similarities.whereType<TextOverlap>().firstOrNull?.jaccard ?? 0;

  /// Gotowe zdanie do pastylki i raportu:
  /// `„Barka” w apce: ten sam tytuł, tekst 82%`.
  String get detail => '„${song.title}” ${source.inText}: ${similaritiesText(similarities)}';
}

/// Od najsilniejszego: poziom, potem pokrycie tekstu malejąco. Jedna reguła
/// dla listy z jednego indeksu i dla zszytej listy z kilku.
int compareSongMatches(SongMatch a, SongMatch b) {
  final byLevel = (a.level?.index ?? MatchLevel.values.length)
      .compareTo(b.level?.index ?? MatchLevel.values.length);
  if (byLevel != 0) return byLevel;
  return b.overlap.compareTo(a.overlap);
}

/// Piosenki, z którymi porównujemy.
class SongIndex<T extends SongCore> {
  final List<T> songs;
  final List<SongProfile> profiles;
  final Map<String, List<int>> _byTitleKey = {};
  final Map<String, List<int>> _byId = {};
  /// Id bez członu `@wykonawca` → numery. Do drugiej rundy [byId] bez
  /// skanowania i bez `split` na każdym profilu.
  final Map<String, List<int>> _byBareId = {};
  /// Tekst dosłownie (po zbiciu białych znaków) → numery. Jedyna droga do
  /// `identical` dla piosenki, której tekst nie ma ani jednego słowa
  /// (`♪ ♪`, same kropki) — zbiór słów jest wtedy pusty i odwrócony indeks
  /// słów jej nie widzi.
  final Map<String, List<int>> _byText = {};
  /// Słowo → numery piosenek, w których występuje. Z niego liczymy przecięcia
  /// zbiorów słów bez odwiedzania każdej piosenki — przy 2,5 tys. piosenek
  /// i przeliczaniu z każdym znakiem w edytorze to jest różnica między
  /// „nie widać” a „zacina się”.
  final Map<String, List<int>> _byWord = {};

  SongIndex(this.songs) : profiles = [for (final s in songs) SongProfile(s)] {
    for (var i = 0; i < profiles.length; i++) {
      final p = profiles[i];
      if (p.id.isNotEmpty) {
        _byId.putIfAbsent(p.id, () => []).add(i);
        _byBareId.putIfAbsent(_bare(p.id), () => []).add(i);
      }
      for (final k in p.titleKeys) {
        _byTitleKey.putIfAbsent(k, () => []).add(i);
      }
      if (p.text.isNotEmpty) _byText.putIfAbsent(p.text, () => []).add(i);
      for (final w in p.words) {
        _byWord.putIfAbsent(w, () => []).add(i);
      }
    }
  }

  static String _bare(String id) => id.split('@').first;

  int get length => songs.length;
  bool get isEmpty => songs.isEmpty;

  bool has(String songId) => _byId.containsKey(songId);

  /// Numery piosenek pod tym id: dokładnie, a przy chybieniu bez członu
  /// `@wykonawca` — zgłoszenie bywa sprzed zmiany wykonawcy w apce, a to
  /// dalej ta sama piosenka. Puste id to nie id: nic nie pasuje.
  List<int> _indicesById(String id) {
    if (id.isEmpty) return const [];
    return _byId[id] ?? _byBareId[_bare(id)] ?? const [];
  }

  /// Piosenka po `lclId`. Przy powtórzonym id — pierwsza z listy; wszystkie
  /// daje [allById].
  T? byId(String id) {
    final indices = _indicesById(id);
    return indices.isEmpty ? null : songs[indices.first];
  }

  /// **Wszystkie** piosenki pod tym id — w warsztacie id potrafi się
  /// powtarzać, a wtedy „ta jedna” to za mało.
  List<T> allById(String id) => [for (final i in _indicesById(id)) songs[i]];

  SongMatch<T> _match(int i, SongProfile song, MatchSource source) => SongMatch(
        song: songs[i],
        source: source,
        similarities: compare(song, profiles[i]),
      );

  /// Porównanie z **wskazaną** piosenką, nie z najbliższą. Tego używa
  /// piosenkomat, gdy apka powiedziała w zgłoszeniu, którą piosenkę autor
  /// poprawiał: wtedy nie ma czego zgadywać, a różnice liczymy względem
  /// właściwego pierwowzoru. `null`, gdy takiego id nie ma. Dokładnie po id,
  /// bez rundy po `@wykonawca` — narzędzie dostaje id z pliku i ma wiedzieć,
  /// gdy go nie ma.
  SongMatch<T>? matchTo(String songId, SongProfile song,
      {MatchSource source = MatchSource.app}) {
    final i = _byId[songId]?.first;
    if (i == null) return null;
    return _match(i, song, source);
  }

  /// Pokrycie tekstu (Jaccard) z każdą piosenką, która dzieli z [song] choć
  /// jedno słowo. Liczone z odwróconego indeksu: gęsty licznik wspólnych
  /// słów, potem ten sam wzór, co [jaccard] — a nie 2,5 tys. przecięć
  /// zbiorów. Piosenek bez wspólnego słowa nie ma w wyniku: ich pokrycie
  /// to 0.
  Map<int, double> _overlaps(SongProfile song) {
    final shared = List<int>.filled(profiles.length, 0);
    for (final w in song.words) {
      for (final i in _byWord[w] ?? const <int>[]) {
        shared[i]++;
      }
    }
    final out = <int, double>{};
    for (var i = 0; i < shared.length; i++) {
      if (shared[i] == 0) continue;
      out[i] = jaccardFromCounts(shared[i], song.words.length, profiles[i].words.length);
    }
    return out;
  }

  /// Najbliższa piosenka: po tytule (przy kilku — najwyższy Jaccard), a gdy
  /// tytuł nie pasuje — najbliższa tekstem, o ile ≥ [kSimilarText].
  SongMatch<T>? closest(SongProfile song, {MatchSource source = MatchSource.app}) {
    final byTitle = {
      for (final k in song.titleKeys) ...?_byTitleKey[k],
    };
    final overlaps = _overlaps(song);

    int? best;
    var bestScore = -1.0;
    for (final i in byTitle.isNotEmpty ? byTitle : overlaps.keys) {
      final score = overlaps[i] ?? 0;
      if (score > bestScore) {
        best = i;
        bestScore = score;
      }
    }
    if (best == null) return null;
    if (byTitle.isEmpty && bestScore < kSimilarText) return null;
    return _match(best, song, source);
  }

  /// Kto w ogóle może mieć poziom. Każda gałąź [levelOf] wymaga jednego
  /// z czterech: wspólnego tytułu, wspólnego id, pokrycia tekstu
  /// ≥ [kSimilarText] albo — dla `identical` — dosłownie równego tekstu.
  /// Reszty nie trzeba porównywać.
  Set<int> _candidates(SongProfile song) {
    final out = <int>{};
    for (final k in song.titleKeys) {
      out.addAll(_byTitleKey[k] ?? const []);
    }
    out.addAll(_indicesById(song.id));
    if (song.text.isNotEmpty) out.addAll(_byText[song.text] ?? const []);
    for (final e in _overlaps(song).entries) {
      if (e.value >= kSimilarText) out.add(e.key);
    }
    return out;
  }

  /// **Wszystkie** trafienia z poziomem, od najsilniejszego. To zasila belkę
  /// i przeglądarkę — [closest] daje jedno, a człowiek chce zobaczyć każdą
  /// kandydatkę.
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
T? correctionTargetOf<T extends SongCore>(SongCore song, SongIndex<T> index) {
  final data = song is SongRaw ? song.piosenkomatData : null;
  final correctedSongId = song is SongRaw ? song.correctedSongId : null;

  // Ślad piosenkomatu jest rozstrzygający: piosenka zgłoszona jako „nowa”
  // nie jest poprawką, choćby niosła `correctedSongId` — przerobiona z cudzej
  // i wysłana jako nowa też je ma, a to żadna deklaracja.
  if (data != null && data.kind != SubmissionKind.correction) return null;

  // Po wszystkich pod tym id, nie po pierwszym: w warsztacie id się
  // powtarza, a sąsiad pod tym samym id to kolizja, nie pierwowzór — tak
  // samo jak sama piosenka.
  T? declared(String? id) {
    if (id == null || id.isEmpty) return null;
    for (final found in index.allById(id)) {
      if (!identical(found, song)) return found;
    }
    return null;
  }

  return declared(data?.correctionTarget) ?? declared(correctedSongId);
}
