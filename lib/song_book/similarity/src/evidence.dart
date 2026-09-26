/// Dowody podobieństwa: **co** jest podobne i **jak bardzo**. Same fakty —
/// wniosek (`MatchLevel`) to reguła nad listą, a progi żyją w regułach.
library;

import 'dart:math';

import 'chords.dart';
import 'lines.dart';
import 'normalize.dart';
import 'profile.dart';

/// Jeden dowód. Zbieramy wszystkie, jakie są; co z nich wynika, mówi
/// `levelOf`.
sealed class Similarity {
  const Similarity();
  /// Gotowe zdanie do pastylki i raportu.
  String get text;
}

/// To samo id (`lclId`). Najtwardszy sygnał z możliwych: w apce piosenki są
/// referencjonowane po id, a po `prepare` poprawka **ma** id pierwowzoru.
/// Dwie różne piosenki pod jednym id to konflikt, nawet gdy nic poza tym
/// ich nie łączy.
class SameId extends Similarity {
  const SameId();
  @override
  String get text => 'to samo id';
}

/// Tytuł główny jednej to tytuł (główny albo ukryty) drugiej, po
/// normalizacji jak w wyszukiwarce. Sam wspólny tytuł ukryty się nie liczy —
/// patrz [SongProfile.sharesTitleWith].
class SameTitle extends Similarity {
  const SameTitle();
  @override
  String get text => 'ten sam tytuł';
}

/// Tekst **dosłownie** równy po zbiciu białych znaków. [SharedLines] 100%
/// to nie to samo — nie widzi kolejności zwrotek ani interpunkcji.
class SameText extends Similarity {
  const SameText();
  @override
  String get text => 'ten sam tekst';
}

/// Które wersy jednej piosenki mają swój odpowiednik w drugiej.
///
/// Surowe miary; próg podaje pytający. „Ta piosenka” to pierwsza podana do
/// [compare], „tamta” — druga. Wersy liczą się raz (refren nie waży tyle,
/// ile razy go zaśpiewano), a pokrycie waży je długością — wokalizy
/// („laj la laj la”) ważą zero.
class SharedLines extends Similarity {
  /// Najlepsze podobieństwo każdego wersu tej piosenki do wersu tamtej.
  final List<double> best;
  /// To samo z drugiej strony.
  final List<double> otherBest;
  final List<ProfileLine> _lines;
  final List<ProfileLine> _otherLines;

  SharedLines._(this.best, this.otherBest, this._lines, this._otherLines);

  static double _coverage(List<double> best, List<ProfileLine> lines, double min) {
    var total = 0.0, covered = 0.0;
    for (var i = 0; i < lines.length; i++) {
      total += lines[i].weight;
      if (best[i] >= min) covered += lines[i].weight;
    }
    return total == 0 ? 0 : covered / total;
  }

  static double _mean(List<double> best, List<ProfileLine> lines) {
    var total = 0.0, acc = 0.0;
    for (var i = 0; i < lines.length; i++) {
      total += lines[i].weight;
      acc += best[i] * lines[i].weight;
    }
    return total == 0 ? 0 : acc / total;
  }

  /// Ile tekstu (wagą wersów) ma ta piosenka i tamta — przy kilku słowach
  /// każde pokrycie jest przypadkiem.
  double get total => _lines.fold(0.0, (a, l) => a + l.weight);
  double get otherTotal => _otherLines.fold(0.0, (a, l) => a + l.weight);

  /// Jaka część tej piosenki (wagą wersów) jest w tamtej.
  double coverage([double min = kLineMatch]) => _coverage(best, _lines, min);
  /// Jaka część tamtej piosenki jest w tej.
  double otherCoverage([double min = kLineMatch]) => _coverage(otherBest, _otherLines, min);
  /// Średnie podobieństwo wersów tej piosenki do najbliższych w tamtej —
  /// przeróbka ma wersy „w połowie te same”, choć żaden nie przechodzi
  /// [kLineMatch].
  double get mean => _mean(best, _lines);
  double get otherMean => _mean(otherBest, _otherLines);

  int _count(List<double> best, List<ProfileLine> lines, bool Function(double) test) {
    var n = 0;
    for (var i = 0; i < lines.length; i++) {
      if (lines[i].weight > 0 && test(best[i])) n++;
    }
    return n;
  }

  /// Wersy tej piosenki, które są w tamtej.
  int get common => _count(best, _lines, (s) => s >= kLineMatch);
  /// Wersy tamtej piosenki, które są w tej.
  int get otherCommon => _count(otherBest, _otherLines, (s) => s >= kLineMatch);
  /// …z czego nie dosłownie (literówka, zmienione słowo).
  int get changed => _count(best, _lines, (s) => s >= kLineMatch && s < 0.999);
  /// Wersy tej piosenki, których w tamtej nie ma.
  int get added => _count(best, _lines, (s) => s < kLineMatch);
  /// Wersy tamtej piosenki, których w tej nie ma.
  int get missing => _count(otherBest, _otherLines, (s) => s < kLineMatch);

  @override
  String get text => [
        plural(common, 'wspólny wers', 'wspólne wersy', 'wspólnych wersów'),
        if (changed > 0) 'w tym ${plural(changed, 'zmieniony', 'zmienione', 'zmienionych')}',
        if (added > 0) plural(added, 'nowy', 'nowe', 'nowych'),
        if (missing > 0) plural(missing, 'brakujący', 'brakujące', 'brakujących'),
      ].join(', ');
}

/// Chwyty dosłownie równe po zbiciu białych znaków; wielkość liter zostaje
/// (`a` ≠ `A`).
class SameChords extends Similarity {
  const SameChords();
  @override
  String get text => 'te same chwyty';
}

/// Pary sąsiednich akordów, najlepsze z 12 transpozycji. Przesunięty refren
/// czy inna kolejność zwrotek tego nie ruszają; przeróbka zwykle zostaje przy
/// melodii, więc i przy chwytach.
class ChordsMatch extends Similarity {
  final double similarity;
  /// O ile półtonów ta piosenka jest wyżej od tamtej (−5…+6). Zero, gdy
  /// w tej samej tonacji.
  final int shift;
  const ChordsMatch(this.similarity, this.shift);
  @override
  String get text => shift == 0
      ? 'chwyty ${pct(similarity)}'
      : 'chwyty ${pct(similarity)} po transpozycji o ${shift > 0 ? '+' : ''}$shift';
}

/// Metrum: te same liczby sylab w kolejnych wersach.
class MeterMatch extends Similarity {
  final double similarity;
  const MeterMatch(this.similarity);
  @override
  String get text => 'metrum ${pct(similarity)}';
}

/// Ten sam film YouTube — to samo nagranie, choćby tekst spisano inaczej.
class SameRecording extends Similarity {
  const SameRecording();
  @override
  String get text => 'to samo nagranie';
}

/// Które pola metadanych się różnią. Nieemitowany, gdy nic.
class MetadataDiff extends Similarity {
  final List<String> fields;
  const MetadataDiff(this.fields);
  @override
  String get text => 'inne: ${fields.join(', ')}';
}

/// Od tego podobieństwa par akordów chwyty są te same z dokładnością do
/// kolejności (przesunięty refren, inna kolejność zwrotek).
const double kSameChordPairs = 0.8;

/// Wszystkie dowody, jakie da się zebrać między [a] („ta”) i [b] („tamta”).
List<Similarity> compare(SongProfile a, SongProfile b) {
  final out = <Similarity>[];
  if (a.id.isNotEmpty && a.id == b.id) out.add(const SameId());
  if (a.sharesTitleWith(b)) out.add(const SameTitle());
  if (a.text.isNotEmpty && a.text == b.text) out.add(const SameText());
  if (a.lines.isNotEmpty && b.lines.isNotEmpty) {
    final aligned = alignLines(a, b);
    out.add(SharedLines._(aligned.a, aligned.b, a.lines, b.lines));
  }
  if (a.chords == b.chords) out.add(const SameChords());
  if (a.hasChords && b.hasChords) {
    final m = matchChordPairs(a.chordPairsSet, b.chordPairsSet);
    // matchChordPairs mówi, o ile przesunąć tę, żeby wyszła tamta.
    final up = (12 - m.shift) % 12;
    out.add(ChordsMatch(m.similarity, up > 6 ? up - 12 : up));
  }
  if (a.meter.length >= 2 && b.meter.length >= 2) {
    out.add(MeterMatch(meterSimilarity(a.meter, b.meter)));
  }
  if (a.youtubeId.isNotEmpty && a.youtubeId == b.youtubeId) out.add(const SameRecording());
  final diff = [
    for (final e in a.metadata.entries)
      if (e.value != b.metadata[e.key]) e.key,
  ];
  if (diff.isNotEmpty) out.add(MetadataDiff(diff));
  return out;
}

/// Typowany dostęp do listy dowodów — reguły czyta się wtedy jak tabelę.
extension SimilarityList on List<Similarity> {
  bool has<T extends Similarity>() => any((e) => e is T);
  SharedLines? get sharedLines => whereType<SharedLines>().firstOrNull;
  ChordsMatch? get chordsMatch => whereType<ChordsMatch>().firstOrNull;
  MeterMatch? get meterMatch => whereType<MeterMatch>().firstOrNull;
  MetadataDiff? get metadataDiff => whereType<MetadataDiff>().firstOrNull;

  /// Chwyty te same, choćby w innej kolejności (przesunięty refren).
  /// Transpozycja to już inne chwyty.
  bool get sameChordsUpToOrder {
    if (has<SameChords>()) return true;
    final c = chordsMatch;
    return c != null && c.shift == 0 && c.similarity >= kSameChordPairs;
  }

  /// Największe pokrycie wersów w którąś stronę.
  double get lineCoverage {
    final l = sharedLines;
    return l == null ? (has<SameText>() ? 1 : 0) : max(l.coverage(), l.otherCoverage());
  }
}

/// Dowody do pokazania: bez tego, co powtarza inny dowód (wspólne wersy
/// obok „ten sam tekst”, podobieństwo chwytów obok „te same chwyty”), i bez
/// metrum tam, gdzie o podobieństwie mówi już tekst — ono ma znaczenie
/// tylko przy przeróbkach.
List<Similarity> similaritiesToShow(List<Similarity> s) {
  final sameText = s.has<SameText>();
  final sameChords = s.has<SameChords>();
  final meterSays = (s.meterMatch?.similarity ?? 0) >= 0.75 && s.lineCoverage < 0.5;
  return [
    for (final e in s)
      if (!(sameText && e is SharedLines) &&
          !(sameChords && e is ChordsMatch) &&
          !(e is MeterMatch && !meterSays))
        e,
  ];
}

String similaritiesText(List<Similarity> s) => similaritiesToShow(s).map((e) => e.text).join(', ');
