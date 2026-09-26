/// Podobieństwo piosenek — algorytmika mieszka w rdzeniu
/// (`harcapp_core/song_book/similarity/`), bo tego samego używa edytor na
/// stronie. Tu zostaje to, co jest pojęciem **kolejki**, nie śpiewnika:
/// najbliższe zgłoszenie w paczce i reguła zgadywania celu poprawki.
library;

import 'package:harcapp_core/song_book/similarity/similarity.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';

export 'package:harcapp_core/song_book/similarity/similarity.dart';

/// Najbliższa piosenka **w apce**.
class AppMatch extends SongMatch<SongRaw> {
  AppMatch({required super.song, required super.similarities})
      : super(source: MatchSource.app);

  AppMatch.of(SongMatch<SongRaw> m)
      : this(song: m.song, similarities: m.similarities);

  String get songId => song.id;
  /// Tylko podpis do wyświetlenia.
  String get title => song.title;
}

/// Reguła: czy na [m] wolno wskazać poprawkę, która **nie powiedziała**,
/// co poprawia. Podmiana idzie po id, więc sam zbieżny tytuł („Barka” to
/// nie zawsze ta sama „Barka”) nie wystarczy: wymagamy co najmniej połowy
/// wspólnych wersów w którąś stronę ([MatchLevel.variant] i mocniejsze) —
/// poprawka może właśnie zmieniać tytuł, a (prawie) ten sam tekst to ta
/// sama piosenka. Słabsze podobieństwo przechodzi tylko z tym samym tytułem.
bool canGuessCorrectionTarget(AppMatch m) {
  final l = m.level;
  if (l == null) return false;
  if (l.index <= MatchLevel.variant.index) return true;
  return l == MatchLevel.related && m.similarities.has<SameTitle>();
}

/// Najbliższe **inne zgłoszenie (inny wątek)** w tej paczce.
class BatchMatch {
  /// Reprezentant drugiego zgłoszenia — do `detail`.
  final String messageId;
  final String title;
  final List<Similarity> similarities;
  /// Czy TO zgłoszenie jest najnowsze w grupie identycznych, do której należy
  /// razem z [messageId]. Fakt o porównaniu, nie o zgłoszeniu. Ma sens tylko przy
  /// `level == identical`.
  final bool isNewestInBatch;
  /// Którą piosenkę w apce poprawia TAMTO zgłoszenie. `null` dla nowych
  /// piosenek i poprawek bez celu. Po tym poznajemy, czy obie poprawki celują
  /// w tę samą piosenkę — podobny tekst tego jeszcze nie znaczy.
  final String? correctionTarget;
  /// Ten sam **tytuł główny**. W paczce tylko on robi „ten sam tytuł” —
  /// wspólny tytuł ukryty łapie dopiero tekst. `SameTitle` w [similarities]
  /// liczy też ukryte, bo tak porównujemy z apką.
  final bool sameMainTitle;
  const BatchMatch({
    required this.messageId,
    required this.title,
    required this.similarities,
    this.isNewestInBatch = true,
    this.correctionTarget,
    this.sameMainTitle = false,
  });
  MatchLevel? get level => levelOf(similarities);
  String get detail => '„$title” [$messageId]: ${similaritiesText(similarities)}';
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

  /// Najsilniejsze trafienia, od najsilniejszego — [limit] pierwszych.
  List<AppMatch> strongest(SongProfile song, {int limit = 3}) =>
      [for (final m in matches(song).take(limit)) AppMatch.of(m)];

  @override
  AppMatch? closest(SongProfile song, {MatchSource source = MatchSource.app}) {
    final m = super.closest(song, source: source);
    return m == null ? null : AppMatch.of(m);
  }
}
