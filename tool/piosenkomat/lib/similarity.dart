/// Podobieństwo piosenek — algorytmika mieszka w rdzeniu
/// (`harcapp_core/song_book/similarity/`), bo tego samego używa edytor na
/// stronie. Tu zostaje to, co jest pojęciem **kolejki**, nie śpiewnika:
/// najbliższe zgłoszenie w paczce.
library;

import 'package:harcapp_core/song_book/similarity/similarity.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';

export 'package:harcapp_core/song_book/similarity/similarity.dart';

/// Trafienie **w apce**: piosenka ze śpiewnika i dowody.
typedef AppMatch = SongMatch<SongRaw>;

/// Najbliższe **inne zgłoszenie (inny wątek)** w tej paczce: trafienie jak
/// z indeksu — [song] tamtego zgłoszenia, dowody, poziom — plus fakty
/// o paczce.
class BatchMatch extends SongMatch<SongRaw> {
  /// Wątek drugiego zgłoszenia — do [detail]. Zgłoszenie to wątek, więc
  /// i tu, jak w planie i podsumowaniu, stoi id wątku.
  final String threadId;
  /// Tytuł tamtego zgłoszenia: piosenki albo, gdy pusty, tematu mejla.
  final String title;
  /// `false`: TO zgłoszenie jest starszą kopią identycznego [threadId] —
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
    required super.song,
    required super.similarities,
    required this.threadId,
    required this.title,
    this.isNewestInBatch = true,
    this.correctionTarget,
    this.sameMainTitle = false,
  }) : super(source: MatchSource.batch);

  /// Z id wątku zamiast „w paczce” — po nim znajdziesz tamto zgłoszenie
  /// w raporcie i w planie.
  @override
  String get detail => '„$title” [$threadId]: ${similaritiesText(similarities)}';
}

/// Piosenki już w apce.
class SongBook extends SongIndex<SongRaw> {
  SongBook(super.songs);

  static final SongBook empty = SongBook(const []);
}
