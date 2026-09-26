/// Wniosek z dowodów: jak bardzo to ta sama piosenka. Jedna tabela reguł;
/// progi żyją tu, nie w danych i nie w UI.
///
/// Progi są skalibrowane na całym śpiewniku (2619 piosenek, 3,4 mln par):
/// pokrycie wersów ≥ 0,08 ma 1 na 10 000 par niepowiązanych piosenek, a od
/// 0,15 w górę są już prawie same pary spokrewnione.
library;

import 'dart:math';

import 'evidence.dart';

/// Tyle wersów (wagą) musi mieć odpowiednik, żeby to była ta sama piosenka.
const double kSameLines = 0.9;
/// Tyle wersów w którąś stronę to już wariant tej samej piosenki albo
/// bliska przeróbka.
const double kVariantLines = 0.5;
/// Poniżej tylu znaków treści (wagą wersów) pokrycie niczego nie dowodzi:
/// jeden wpisany w edytorze wers „Kocham cię” jest „w całości” w pięciu
/// piosenkach. Dosłownie równy tekst ([SameText]) liczy się zawsze.
const double kMinLinesWeight = 40;

/// Wniosek z dowodów. Kolejność to siła trafienia — po niej sortuje
/// `SongIndex.matches`.
///
/// Opisy są od strony piosenki, **którą sprawdzamy** (pierwszej w
/// [compare]): „„Barka” w apce: ta sama piosenka, dopisane zwrotki” znaczy,
/// że sprawdzana ma zwrotki, których „Barka” w apce nie ma.
enum MatchLevel {
  /// Każde pole dosłownie równe — to jest ta sama piosenka. Tylko na tym
  /// piosenkomat odrzuca sam.
  identical('ta sama piosenka, bez różnic'),
  /// Wersy pokrywają się w obie strony. Tytuł, chwyty, kolejność zwrotek,
  /// literówki czy metadane mogą się różnić — to mówią dowody.
  sameSong('ta sama piosenka, drobne różnice'),
  /// Cała tamta jest w tej, a ta ma więcej: dopisane zwrotki.
  longer('ta sama piosenka, dopisane zwrotki'),
  /// Cała ta jest w tamtej, ale tamta ma więcej: fragment, ucięte zwrotki.
  shorter('ta sama piosenka, brak części zwrotek'),
  /// Połowa wersów w którąś stronę: wariant albo przeróbka blisko oryginału.
  variant('mocno podobna — wariant albo przeróbka'),
  /// Część wersów, melodia albo nagranie wspólne: możliwa przeróbka.
  related('podobna — możliwa przeróbka'),
  /// Ten sam tytuł, treść nie jest podobna.
  sameTitleDifferentText('ten sam tytuł, inna treść'),
  /// To samo id, a poza tym nic — id zajęte przez inną piosenkę. Ostatnie,
  /// bo o **treści** nie mówi nic; ważne jest przez to, co id znaczy w apce,
  /// i po to UI patrzy na dowód [SameId], nie na poziom.
  sameIdDifferentSong('inna piosenka pod tym samym id');

  const MatchLevel(this.text);

  /// Polskie zdanie na poziom — do belki i podpowiedzi.
  final String text;

  /// Czy to ta sama piosenka (w całości albo z dopisanymi / uciętymi
  /// zwrotkami) — czerwień w UI.
  bool get isSameSong => index <= shorter.index;

  /// Czy wniosek wynika z treści (tekst, melodia, nagranie), a nie tylko
  /// z tytułu czy id.
  bool get byContent => index <= related.index;
}

/// Podobna, choć żaden próg „tej samej piosenki” nie przeszedł. Każdy
/// z warunków osobno jest rzadki wśród niepowiązanych par:
/// - wspólne wersy w obie strony (≥ 10% tekstu każdej, co najmniej dwa) —
///   mniej niż 1 na 30 000 par niepowiązanych. Jeden wspólny wers to za
///   mało: krótkie pieśni dzielą frazy („Duchu Święty, przyjdź”), a
///   jednostronne pokrycie bywa przypadkiem, gdy krótka piosenka ma
///   ogólnikowy wers;
/// - wersy „w połowie te same” (przeróbka zmienia słowa w każdym wersie);
/// - te same chwyty albo to samo metrum przy częściowo podobnym tekście —
///   przeróbka zostaje przy melodii. To łapie te, w których tekstu
///   wspólnego jest mało (na śpiewniku: z samego tekstu 14/18 znanych
///   przeróbek, z chwytami i metrum 18/18).
bool _related(SharedLines lines, List<Similarity> s) {
  final a = lines.coverage(), b = lines.otherCoverage();
  final hi = max(a, b), lo = min(a, b);
  final mean = max(lines.mean, lines.otherMean);
  if ((lo >= 0.1 && min(lines.common, lines.otherCommon) >= 2) || (mean >= 0.45 && hi >= 0.08)) return true;
  // Melodia dowodzi czegoś dopiero przy całej piosence: przy kilku wersach te
  // same trzy akordy i podobna liczba sylab to przypadek.
  if (min(lines.total, lines.otherTotal) < _melodyNeeds) return false;
  final chords = s.chordsMatch?.similarity ?? 0;
  final meter = s.meterMatch?.similarity ?? 0;
  return (chords >= 0.6 && mean >= 0.35) || (meter >= 0.75 && mean >= 0.33 && chords >= 0.25);
}

const double _melodyNeeds = 3 * kMinLinesWeight;

MatchLevel? levelOf(List<Similarity> s) {
  final sameText = s.has<SameText>();
  if (sameText && s.has<SameChords>() && !s.has<MetadataDiff>()) return MatchLevel.identical;

  final lines = s.sharedLines;
  if (sameText) return MatchLevel.sameSong;
  if (lines != null) {
    final a = lines.coverage(), b = lines.otherCoverage();
    // O wniosku przesądza pokrycie strony, która jest „w całości” w drugiej
    // — i to ona musi mieć dość tekstu.
    final enoughA = lines.total >= kMinLinesWeight, enoughB = lines.otherTotal >= kMinLinesWeight;
    if (a >= kSameLines && b >= kSameLines && enoughA && enoughB) return MatchLevel.sameSong;
    if (b >= kSameLines && enoughB) return MatchLevel.longer;
    if (a >= kSameLines && enoughA) return MatchLevel.shorter;
    if ((a >= kVariantLines && enoughA) || (b >= kVariantLines && enoughB)) return MatchLevel.variant;
    if (enoughA && enoughB && _related(lines, s)) return MatchLevel.related;
  }
  if (s.has<SameRecording>()) return MatchLevel.related;
  if (s.has<SameTitle>()) return MatchLevel.sameTitleDifferentText;
  if (s.has<SameId>()) return MatchLevel.sameIdDifferentSong;
  return null;
}

/// Jak blisko są teksty — do kolejności trafień w obrębie poziomu: średnia
/// pokrycia w obie strony, a przy remisie średnie podobieństwo wersów.
double similarityScore(List<Similarity> s) {
  final l = s.sharedLines;
  if (l == null) return s.has<SameText>() ? 1 : 0;
  return (l.coverage() + l.otherCoverage()) / 2 + (l.mean + l.otherMean) / 1000;
}
