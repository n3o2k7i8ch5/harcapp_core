/// Podobieństwo piosenek — algorytmika mieszka w rdzeniu
/// (`harcapp_core/song_book/similarity/`), bo tego samego używa edytor na
/// stronie. Tu zostaje to, co jest pojęciem **kolejki**, nie śpiewnika:
/// najbliższe zgłoszenie w paczce i reguła zgadywania celu poprawki.
library;

import 'package:harcapp_core/song_book/similarity/similarity.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';

export 'package:harcapp_core/song_book/similarity/similarity.dart';

/// Trafienie **w apce**: piosenka ze śpiewnika i dowody.
typedef AppMatch = SongMatch<SongRaw>;

extension AppMatchId on AppMatch {
  String get songId => song.id;
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
  /// `false`: TO zgłoszenie jest starszą kopią identycznego [messageId] —
  /// wyparte, odpada. Fakt o porównaniu, nie o zgłoszeniu.
  final bool isNewestInBatch;
  /// Którą piosenkę w apce poprawia TAMTO zgłoszenie. `null` dla nowych
  /// piosenek i poprawek bez celu. Po tym poznajemy, czy obie poprawki celują
  /// w tę samą piosenkę — podobny tekst tego jeszcze nie znaczy.
  final String? correctionTarget;
  /// Ten sam **tytuł główny**. W paczce tylko on robi „ten sam tytuł” —
  /// wspólny tytuł ukryty łapie dopiero tekst. `SameTitle` w [similarities]
  /// liczy też ukryte, bo tak porównujemy z apką.
  final bool sameMainTitle;
  BatchMatch({
    required this.messageId,
    required this.title,
    required this.similarities,
    this.isNewestInBatch = true,
    this.correctionTarget,
    this.sameMainTitle = false,
  });
  late final MatchLevel? level = levelOf(similarities);
  /// Jak blisko są teksty — do wyboru partnera w obrębie poziomu.
  late final double score = similarityScore(similarities);
  String get detail => '„$title” [$messageId]: ${similaritiesText(similarities)}';
}

/// Piosenki już w apce.
class SongBook extends SongIndex<SongRaw> {
  SongBook(super.songs);

  static final SongBook empty = SongBook(const []);

  /// Najsilniejsze trafienia, od najsilniejszego — [limit] pierwszych.
  List<AppMatch> strongest(SongProfile song, {int limit = 3}) =>
      matches(song).take(limit).toList();
}
