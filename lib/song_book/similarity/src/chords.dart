/// Chwyty w postaci, którą da się porównać bez względu na tonację i na
/// kolejność zwrotek: sekwencja akordów, a z niej zbiór par sąsiednich.
///
/// Notacja jak w śpiewniku: wielka litera to dur, mała — moll, `is`
/// podwyższa, `es`/`s` obniża, `B` to B♭, a `H` to B. Zapis angielski
/// (`Am`, `Em7`) też przechodzi. Co nie wygląda na akord („x2”, „|”), znika.
library;

/// Rodzaje z dopiskiem, które mają stały numer. Reszta idzie przez skrót
/// napisu — liczy się tylko to, żeby ten sam dopisek dawał ten sam numer.
const _knownSuffixes = ['', '7', '7+', '0', '2', '4', '5', '6', '9', '11', 'sus2', 'sus4', 'maj7', 'dim', 'aug', '+'];

const _roots = {'c': 0, 'd': 2, 'e': 4, 'f': 5, 'g': 7, 'a': 9, 'b': 10, 'h': 11};

/// `es`/`s` przed `us` to nie bemol, tylko `sus` (`Esus4`, `Asus2`).
final _chord = RegExp(r'^([A-Ha-h])(is|es(?!us)|s(?!us))?(.*)$');

/// Akord jako liczba: `dźwięk * 64 + rodzaj * 2 + moll`. `null`, gdy to nie akord.
int? parseChord(String token) {
  var t = token.replaceAll(RegExp(r'[()\[\]]'), '');
  final slash = t.indexOf('/');
  if (slash > 0) t = t.substring(0, slash); // bas (`D/Fis`) nie zmienia akordu
  final m = _chord.firstMatch(t);
  if (m == null) return null;
  final letter = m[1]!;
  var minor = letter == letter.toLowerCase();
  var pitch = _roots[letter.toLowerCase()]!;
  switch (m[2]) {
    case 'is':
      pitch += 1;
    case 'es' || 's':
      pitch -= 1;
  }
  var suffix = m[3]!;
  if (suffix.startsWith('m') && !suffix.startsWith('maj')) {
    minor = true;
    suffix = suffix.substring(1);
  }
  final known = _knownSuffixes.indexOf(suffix);
  final quality = known >= 0 ? known : 16 + suffix.hashCode % 16;
  return (pitch % 12) * 64 + quality * 2 + (minor ? 1 : 0);
}

/// Akordy w kolejności z tekstu.
List<int> chordSequence(String chords) => [
      for (final token in chords.split(RegExp(r'\s+')))
        if (token.isNotEmpty)
          if (parseChord(token) case final c?) c,
    ];

int _shift(int chord, int by) => ((chord ~/ 64 + by) % 12) * 64 + chord % 64;

const _pairBase = 12 * 64;

/// Pary sąsiednich akordów **w obrębie części** (części rozdziela pusta
/// linia). Przesunięty refren czy inna kolejność zwrotek ich nie zmieniają —
/// para na styku dwóch części zależałaby właśnie od kolejności — inna
/// harmonia tak. Pojedynczy akord to „para” sam ze sobą, żeby część na
/// jednym chwycie też miała z czym się porównać.
Set<int> chordPairs(String chords) {
  final out = <int>{};
  for (final part in chords.split(RegExp(r'\n[ \t]*\n'))) {
    final sequence = chordSequence(part);
    if (sequence.length == 1) out.add(sequence.first * _pairBase + sequence.first);
    for (var i = 0; i + 1 < sequence.length; i++) {
      out.add(sequence[i] * _pairBase + sequence[i + 1]);
    }
  }
  return out;
}

/// Najlepsze dopasowanie par [a] do par [b] w 12 transpozycjach: Jaccard
/// i o ile półtonów trzeba przesunąć [a], żeby wyszło [b].
({double similarity, int shift}) matchChordPairs(Set<int> a, Set<int> b) {
  if (a.isEmpty || b.isEmpty) return (similarity: 0, shift: 0);
  var best = -1.0, bestShift = 0;
  for (var k = 0; k < 12; k++) {
    var shared = 0;
    for (final p in a) {
      final shifted = _shift(p ~/ _pairBase, k) * _pairBase + _shift(p % _pairBase, k);
      if (b.contains(shifted)) shared++;
    }
    final j = shared / (a.length + b.length - shared);
    if (j > best + 1e-9) {
      best = j;
      bestShift = k;
    }
  }
  return (similarity: best, shift: bestShift);
}
