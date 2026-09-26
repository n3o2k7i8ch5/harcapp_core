/// Normalizacja tekstu do porównań. Jeden przebieg po znakach zamiast
/// kilkudziesięciu `replaceAll` z `simplifyString` — te same słowa, ok. 4×
/// szybciej, a to był największy koszt budowy indeksu śpiewnika.
library;

const _foldPairs = {
  'ą': 'a', 'á': 'a', 'ć': 'c', 'ę': 'e', 'é': 'e', 'ě': 'e', 'í': 'i', 'ł': 'l', 'ń': 'n', 'ó': 'o',
  'ö': 'o', 'ő': 'o', 'ř': 'r', 'ś': 's', 'š': 's', 'ú': 'u', 'ü': 'u', 'ű': 'u', 'ý': 'y', 'ź': 'z',
  'ż': 'z', 'ž': 'z',
};
final Map<int, int> _fold = {
  for (final e in _foldPairs.entries) e.key.codeUnitAt(0): e.value.codeUnitAt(0),
};

final _wordChar = RegExp(r'[\p{L}\p{N}_]', unicode: true);
/// Czy znak spoza ASCII jest literą albo cyfrą — `RegExp` raz na znak, nie
/// raz na wystąpienie.
final Map<int, bool> _isWordChar = {};

/// „Ref.:”, „Refren:”, „1.” na początku wersu — podpisy, nie tekst.
final _label = RegExp(r'^\s*(?:(?:ref(?:ren)?|refrain|chorus)\s*\d*\s*[.:)]+|\d{1,2}[.)](?=\s))\s*',
    caseSensitive: false);
/// „x2”, „2x” — znacznik powtórzenia.
final _repeat = RegExp(r'^(?:x\d{1,2}|\d{1,2}x)$');

/// Separatory słów: białe znaki (te same, co `\s`) oraz `:`, `-`, `/`.
bool _isSeparator(int c) =>
    c == 0x20 || (c >= 0x09 && c <= 0x0d) || c == 0x3a || c == 0x2d || c == 0x2f ||
    c == 0xa0 || c == 0x1680 || (c >= 0x2000 && c <= 0x200a) || c == 0x2028 || c == 0x2029 ||
    c == 0x202f || c == 0x205f || c == 0x3000 || c == 0xfeff;

/// Słowa jednej linii: małe litery, bez znaków diakrytycznych, bez
/// interpunkcji. `:`, `-`, `/` i białe znaki dzielą słowa, reszta
/// interpunkcji znika bez śladu („a,b” → „ab”) — tak samo jak
/// w wyszukiwarce. Bez podpisów zwrotek i znaczników powtórzeń.
List<String> lineWords(String line) {
  final s = line.replaceFirst(_label, '').toLowerCase();
  final out = <String>[];
  final buf = StringBuffer();
  void flush() {
    if (buf.isEmpty) return;
    final w = buf.toString();
    buf.clear();
    if (!_repeat.hasMatch(w)) out.add(w);
  }

  for (var i = 0; i < s.length; i++) {
    var c = s.codeUnitAt(i);
    c = _fold[c] ?? c;
    if ((c >= 0x61 && c <= 0x7a) || (c >= 0x30 && c <= 0x39) || c == 0x5f) {
      buf.writeCharCode(c);
    } else if (_isSeparator(c)) {
      flush();
    } else if (c >= 0x80) {
      // Surogaty (znaki spoza BMP) przepuszczamy — nie da się ich ocenić po
      // połówce, a w tekstach piosenek to i tak emotki.
      final word = (c >= 0xd800 && c <= 0xdfff) ||
          _isWordChar.putIfAbsent(c, () => _wordChar.hasMatch(String.fromCharCode(c)));
      if (word) buf.writeCharCode(c);
    }
  }
  flush();
  return out;
}

/// Zbiór słów całego tekstu — do szukania kandydatów i do testów.
Set<String> textWords(String text) => {
      for (final line in text.split('\n')) ...lineWords(line),
    };

/// Białe znaki zbite do jednej spacji, brzegi przycięte. Nic więcej — do
/// porównań „dosłownie równe”.
String squash(String s) => s.replaceAll(RegExp(r'\s+'), ' ').trim();

String pct(double score) => '${(score * 100).round()}%';

/// „1 wspólny”, „2 wspólne”, „5 wspólnych”.
String plural(int n, String one, String few, String many) {
  if (n == 1) return '$n $one';
  final unit = n % 10, tens = n % 100;
  if (unit >= 2 && unit <= 4 && (tens < 12 || tens > 14)) return '$n $few';
  return '$n $many';
}
