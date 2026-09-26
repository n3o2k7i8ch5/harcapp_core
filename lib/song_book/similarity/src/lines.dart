/// Dopasowanie wersów dwóch piosenek: dla każdego wersu najbliższy wers
/// drugiej, w obie strony. Kolejność zwrotek, powtórzenia refrenu
/// i literówki nie mają znaczenia; dopisane i ucięte zwrotki widać po
/// asymetrii.
library;

import 'dart:math';

import 'profile.dart';

/// Od tego podobieństwa (Dice na trigramach znaków) dwa wersy to „ten sam
/// wers”. Literówka psuje 2–3 trigramy, nie całe słowo, więc wers
/// z literówką zostaje tym samym wersem, a przeróbka („kilka słów inaczej”)
/// już nie.
const double kLineMatch = 0.7;

/// Poniżej tego wers nie ma w drugiej piosence nawet połówki siebie — nie ma
/// sensu szukać go w oknach.
const double _windowFrom = 0.4;

/// Okna sprawdzamy też dla wersów dopasowanych słabo: sklejony wers
/// „a1 a2” potrafi przekroczyć [kLineMatch] z samą dłuższą połówką, a wtedy
/// krótsza zostaje bez pary.
const double _windowBelow = 0.9;

double _dice(List<int> a, List<int> b) {
  if (a.isEmpty || b.isEmpty) return 0;
  var i = 0, j = 0, shared = 0;
  while (i < a.length && j < b.length) {
    final x = a[i], y = b[j];
    if (x == y) {
      shared++;
      i++;
      j++;
    } else if (x < y) {
      i++;
    } else {
      j++;
    }
  }
  return 2 * shared / (a.length + b.length);
}

/// Najlepsze podobieństwo każdego wersu [a] do wersu [b] i odwrotnie.
({List<double> a, List<double> b}) alignLines(SongProfile a, SongProfile b) {
  final la = a.lines, lb = b.lines;
  final bestA = List<double>.filled(la.length, 0);
  final bestB = List<double>.filled(lb.length, 0);
  for (var i = 0; i < la.length; i++) {
    final x = la[i].trigrams;
    for (var j = 0; j < lb.length; j++) {
      final y = lb[j].trigrams;
      // Dice nie przekroczy 2·min/(suma): gdy to nie poprawi żadnej ze stron,
      // nie ma czego liczyć. Większość par odpada tu, zanim policzymy wspólne.
      final bound = 2 * min(x.length, y.length) / (x.length + y.length);
      if (bound <= bestA[i] && bound <= bestB[j]) continue;
      final s = _dice(x, y);
      if (s > bestA[i]) bestA[i] = s;
      if (s > bestB[j]) bestB[j] = s;
    }
  }

  void windows(SongProfile p, List<double> bestP, SongProfile q, List<double> bestQ) {
    for (var i = 0; i < p.lines.length; i++) {
      if (bestP[i] < _windowFrom || bestP[i] >= _windowBelow) continue;
      for (final w in q.windows) {
        final s = _dice(p.lines[i].trigrams, w.trigrams);
        if (s > bestP[i]) bestP[i] = s;
        // Wers pasuje do dwóch sklejonych — oba mają parę.
        if (s >= kLineMatch) {
          if (s > bestQ[w.first]) bestQ[w.first] = s;
          if (s > bestQ[w.second]) bestQ[w.second] = s;
        }
      }
    }
  }

  windows(a, bestA, b, bestB);
  windows(b, bestB, a, bestA);
  return (a: bestA, b: bestB);
}

/// Najdłuższy wspólny podciąg liczb sylab w wersach, przez długość
/// krótszej piosenki. Przeróbka trzyma metrum, choć zmienia słowa. Ucięte
/// do [_meterCap] wersów — dalej niczego to nie zmienia, a koszt rośnie
/// z kwadratem.
double meterSimilarity(List<int> a, List<int> b) {
  if (a.isEmpty || b.isEmpty) return 0;
  final x = a.length > _meterCap ? a.sublist(0, _meterCap) : a;
  final y = b.length > _meterCap ? b.sublist(0, _meterCap) : b;
  var prev = List<int>.filled(y.length + 1, 0);
  for (var i = 1; i <= x.length; i++) {
    final cur = List<int>.filled(y.length + 1, 0);
    for (var j = 1; j <= y.length; j++) {
      cur[j] = x[i - 1] == y[j - 1] ? prev[j - 1] + 1 : max(prev[j], cur[j - 1]);
    }
    prev = cur;
  }
  return prev[y.length] / min(x.length, y.length);
}

const _meterCap = 150;
