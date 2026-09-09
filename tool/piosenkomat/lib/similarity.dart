import 'package:harcapp_core/comm_classes/text_utils.dart';

/// Ten sam tekst: tylko przy tym progu automat decyduje sam.
const double kSameText = 0.9;
/// Podejrzanie podobny: idzie do Ciebie.
const double kSimilarText = 0.5;

/// Zbiór słów po normalizacji (małe litery, bez polskich znaków, bez
/// interpunkcji). Kolejność zwrotek i literówki w wielkości liter nie liczą się.
Set<String> textWords(String text) => simplifyString(text, spaceStrategy: SpaceStrategy.space)
    .split(' ')
    .where((w) => w.isNotEmpty)
    .toSet();

double jaccard(Set<String> a, Set<String> b) {
  if (a.isEmpty || b.isEmpty) return 0;
  return a.intersection(b).length / a.union(b).length;
}

/// Piosenka ze śpiewnika sprowadzona do tego, co potrzebne do porównań.
class BookSong {
  final String title;
  final String titleKey;
  final Set<String> words;
  BookSong(this.title, String text)
      : titleKey = searchableString(title),
        words = textWords(text);
}

class SongBook {
  final List<BookSong> songs;
  final Map<String, List<BookSong>> _byTitle;

  SongBook(this.songs)
      : _byTitle = {
          for (final s in songs) s.titleKey: [...?_group(songs, s.titleKey)],
        };

  static SongBook empty = SongBook(const []);

  static List<BookSong>? _group(List<BookSong> all, String key) =>
      all.where((s) => s.titleKey == key).toList();

  List<BookSong> withTitle(String title) => _byTitle[searchableString(title)] ?? const [];

  /// Najbardziej podobna piosenka w całym śpiewniku i jej podobieństwo.
  (BookSong, double)? closest(Set<String> words) {
    BookSong? best;
    var bestScore = 0.0;
    for (final s in songs) {
      final score = jaccard(words, s.words);
      if (score > bestScore) {
        best = s;
        bestScore = score;
      }
    }
    return best == null ? null : (best, bestScore);
  }
}

String pct(double score) => '${(score * 100).round()}%';
