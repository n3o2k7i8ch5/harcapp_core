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
/// i dowody. Poziom to reguła nad dowodami, nie pole.
class SongMatch<T extends SongCore> {
  final T song;
  final MatchSource source;
  final List<Similarity> similarities;

  const SongMatch({
    required this.song,
    required this.similarities,
    this.source = MatchSource.app,
  });

  MatchLevel? get level => levelOf(similarities);

  /// Pokrycie tekstu — do sortowania w obrębie poziomu.
  double get overlap =>
      similarities.whereType<TextOverlap>().firstOrNull?.jaccard ?? 0;

  /// Gotowe zdanie do pastylki i raportu:
  /// `„Barka” w apce: ten sam tytuł, tekst 82%`.
  String get detail => '„${song.title}” ${source.inText}: ${similaritiesText(similarities)}';
}

/// Piosenki, z którymi porównujemy.
class SongIndex<T extends SongCore> {
  final List<T> songs;
  final List<SongProfile> profiles;
  final Map<String, List<int>> _byTitleKey = {};
  final Map<String, int> _byId = {};

  SongIndex(this.songs) : profiles = [for (final s in songs) SongProfile(s)] {
    for (var i = 0; i < profiles.length; i++) {
      final p = profiles[i];
      // Pierwsze wystąpienie wygrywa — powtórzone id to sprawa [matches],
      // nie tego słownika.
      _byId.putIfAbsent(p.id, () => i);
      for (final k in p.titleKeys) {
        _byTitleKey.putIfAbsent(k, () => []).add(i);
      }
    }
  }

  int get length => songs.length;
  bool get isEmpty => songs.isEmpty;

  bool has(String songId) => _byId.containsKey(songId);

  /// Piosenka po `lclId`. Przy chybionym trafieniu druga runda bez członu
  /// `@wykonawca`: zgłoszenie bywa sprzed zmiany wykonawcy w apce, a to
  /// dalej ta sama piosenka.
  T? byId(String id) {
    final exact = _byId[id];
    if (exact != null) return songs[exact];
    final bare = id.split('@').first;
    for (var i = 0; i < profiles.length; i++) {
      if (profiles[i].id.split('@').first == bare) return songs[i];
    }
    return null;
  }

  SongMatch<T> _match(int i, SongProfile song, MatchSource source) => SongMatch(
        song: songs[i],
        source: source,
        similarities: compare(song, profiles[i]),
      );

  /// Porównanie z **wskazaną** piosenką, nie z najbliższą. Tego używa
  /// piosenkomat, gdy apka powiedziała w zgłoszeniu, którą piosenkę autor
  /// poprawiał: wtedy nie ma czego zgadywać, a różnice liczymy względem
  /// właściwego pierwowzoru. `null`, gdy takiego id nie ma.
  SongMatch<T>? matchTo(String songId, SongProfile song,
      {MatchSource source = MatchSource.app}) {
    final i = _byId[songId];
    if (i == null) return null;
    return _match(i, song, source);
  }

  /// Najbliższa piosenka: po tytule (przy kilku — najwyższy Jaccard), a gdy
  /// tytuł nie pasuje — najbliższa tekstem, o ile ≥ [kSimilarText].
  SongMatch<T>? closest(SongProfile song, {MatchSource source = MatchSource.app}) {
    final byTitle = {
      for (final k in song.titleKeys) ...?_byTitleKey[k],
    }.toList();
    int? best;
    var bestScore = -1.0;
    for (final i in byTitle.isNotEmpty ? byTitle : List.generate(profiles.length, (i) => i)) {
      final score = jaccard(song.words, profiles[i].words);
      if (score > bestScore) {
        best = i;
        bestScore = score;
      }
    }
    if (best == null) return null;
    if (byTitle.isEmpty && bestScore < kSimilarText) return null;
    return _match(best, song, source);
  }

  /// **Wszystkie** trafienia z poziomem, od najsilniejszego: poziom, potem
  /// pokrycie tekstu malejąco. To zasila belkę i przeglądarkę — [closest]
  /// daje jedno, a człowiek chce zobaczyć każdą kandydatkę.
  ///
  /// [exclude] wyłącza piosenki, których nie ma sensu porównywać: samą
  /// siebie (ten sam obiekt w warsztacie) i pierwowzór poprawki, który UI
  /// pokazuje osobno.
  List<SongMatch<T>> matches(SongProfile song,
      {MatchSource source = MatchSource.app, bool Function(T song)? exclude}) {
    final out = <SongMatch<T>>[];
    for (var i = 0; i < profiles.length; i++) {
      if (exclude != null && exclude(songs[i])) continue;
      final m = _match(i, song, source);
      if (m.level != null) out.add(m);
    }
    out.sort((a, b) {
      final byLevel = a.level!.index.compareTo(b.level!.index);
      if (byLevel != 0) return byLevel;
      return b.overlap.compareTo(a.overlap);
    });
    return out;
  }
}

/// Którą piosenkę z [index] poprawia [song] — albo `null`, gdy to nie
/// poprawka albo pierwowzoru nie da się wskazać.
///
/// Szukamy **po id, nie po tytule**: poprawka wolno zmienia tytuł, a dalej
/// dotyczy tej samej piosenki. Kolejno: `correctionTarget` ze śladu
/// piosenkomatu; id samej poprawki (po `prepare` ślad znika, a id poprawki
/// **jest** id pierwowzoru); `correctedSongId` z JSON-a piosenki (piosenka
/// własna w apce pamięta, z czego powstała). Ta jedna funkcja zastępuje trzy
/// kopie tej reguły: w `stripPiosenkomat`, belce nad edytorem i oknie
/// konfliktu importu.
T? correctionTargetOf<T extends SongCore>(SongCore song, SongIndex<T> index) {
  final data = song is SongRaw ? song.piosenkomatData : null;
  final correctedSongId = song is SongRaw ? song.correctedSongId : null;

  // Bez śladu piosenkomatu poprawkę poznajemy po tym, że id jest zajęte;
  // ze śladem — po deklaracji. Piosenka „nowa” ze śladem nie jest poprawką,
  // choćby jej id kolidowało: to konflikt, nie pierwowzór.
  if (data != null && data.kind != SubmissionKind.correction) return null;

  if (data?.correctionTarget case final target?) {
    if (index.byId(target) case final found?) return found;
  }
  if (song.id.isNotEmpty) {
    if (index.byId(song.id) case final found?) {
      if (!identical(found, song)) return found;
    }
  }
  if (correctedSongId case final id?) return index.byId(id);
  return null;
}
