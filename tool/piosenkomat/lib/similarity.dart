/// Podobieństwo piosenek — algorytmika mieszka w rdzeniu
/// (`harcapp_core/song_book/similarity/`), bo tego samego używa edytor na
/// stronie. Tu zostaje to, co jest pojęciem **kolejki**, nie śpiewnika:
/// najbliższe zgłoszenie w paczce i reguła zgadywania celu poprawki.
library;

import 'package:harcapp_core/song_book/similarity/similarity.dart';
import 'package:harcapp_core/song_book/similarity/song_index.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';

export 'package:harcapp_core/song_book/similarity/similarity.dart';
export 'package:harcapp_core/song_book/similarity/song_index.dart';

/// Najbliższa piosenka **w apce**.
class AppMatch extends SongMatch<SongRaw> {
  AppMatch({required super.song, required super.similarities})
      : super(source: MatchSource.app);

  AppMatch.of(SongMatch<SongRaw> m)
      : this(song: m.song, similarities: m.similarities);

  String get songId => song.id;
  /// Tylko podpis do wyświetlenia.
  String get title => song.title;

  /// Czy na tę piosenkę wolno wskazać poprawkę, która **nie powiedziała**,
  /// co poprawia. `SongBook.closest` przy trafieniu w tytuł zwraca wynik bez
  /// względu na tekst, więc bez tego progu poprawka podmieniałaby po id
  /// zupełnie inną piosenkę o tym samym tytule. Wymagamy tytułu i tekstu
  /// ≥ [kGuessableTarget] — albo tekstu ≥ [kSameText]: poprawka może właśnie
  /// zmieniać tytuł, a (prawie) ten sam tekst to ta sama piosenka.
  bool get guessable {
    if (overlap >= kSameText) return true;
    return similarities.any((e) => e is SameTitle) && overlap >= kGuessableTarget;
  }
}

/// Najbliższe **inne zgłoszenie (inny wątek)** w tej paczce.
class BatchMatch {
  final String threadId;
  /// Reprezentant drugiego zgłoszenia — do `detail`.
  final String msgId;
  final String title;
  final DateTime? sentAt;
  final List<Similarity> similarities;
  /// Czy TO zgłoszenie jest najnowsze w grupie identycznych, do której należy
  /// razem z [msgId]. Fakt o porównaniu, nie o zgłoszeniu. Ma sens tylko przy
  /// `level == identical`.
  final bool isNewestInBatch;
  /// Którą piosenkę w apce poprawia TAMTO zgłoszenie. `null` dla nowych
  /// piosenek i poprawek bez celu. Po tym poznajemy, czy obie poprawki celują
  /// w tę samą piosenkę — podobny tekst tego jeszcze nie znaczy.
  final String? correctionTarget;
  const BatchMatch({
    required this.threadId,
    required this.msgId,
    required this.title,
    required this.sentAt,
    required this.similarities,
    this.isNewestInBatch = true,
    this.correctionTarget,
  });
  MatchLevel? get level => levelOf(similarities);
  String get detail => '„$title” [$msgId]: ${similaritiesText(similarities)}';
}

/// Piosenki już w apce. [SongIndex] z wynikami jako [AppMatch].
class SongBook extends SongIndex<SongRaw> {
  SongBook(super.songs);

  static final SongBook empty = SongBook(const []);

  @override
  AppMatch? matchTo(String songId, SongProfile song, {MatchSource source = MatchSource.app}) {
    final m = super.matchTo(songId, song, source: source);
    return m == null ? null : AppMatch.of(m);
  }

  @override
  AppMatch? closest(SongProfile song, {MatchSource source = MatchSource.app}) {
    final m = super.closest(song, source: source);
    return m == null ? null : AppMatch.of(m);
  }
}
