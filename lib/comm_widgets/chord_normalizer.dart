import 'package:harcapp_core/comm_classes/text_utils.dart';

// Zamienia nieobsługiwane akordy (np. "Dadd11", "Gsus4") na podstawowy stopień
// ("D", "G"). ChordDraw rozumie tylko: <stopień><opcjonalna cyfra><opcjonalny '+'>.

// Sprawdzane przed jednoznakowymi (dłuższe dopasowanie wygrywa).
const List<String> _multiCharRoots = ['cis', 'dis', 'fis', 'gis'];

const List<String> _singleCharRoots = ['c', 'd', 'e', 'f', 'g', 'a', 'b', 'h'];

const List<String> chordRoots = [..._multiCharRoots, ..._singleCharRoots];

String _capitalize(String s) =>
    s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';

// Dokładny stopień, małą literą lub z wielkiej pierwszej (jak akceptuje ChordDraw).
bool _isExactRoot(String chord) {
  String lower = chord.toLowerCase();
  if (!chordRoots.contains(lower)) return false;
  return chord == lower || chord == _capitalize(lower);
}

// Czy token mieści się w obsługiwanej whitelisie.
bool isChordSupported(String token) {
  String chord = token;
  if (chord.isEmpty) return false;

  if (chord.endsWith('+')) chord = chord.substring(0, chord.length - 1);
  if (chord.isEmpty) return false;

  if (isDigit(chord.substring(chord.length - 1))) {
    chord = chord.substring(0, chord.length - 1);
  }
  if (chord.isEmpty) return false;

  return _isExactRoot(chord);
}

// Sam stopień, z zachowaniem dur/moll wg pierwszej litery. Nierozpoznany -> bez zmian.
String baseChord(String token) {
  if (token.isEmpty) return token;

  String lower = token.toLowerCase();

  String? root;
  for (String r in _multiCharRoots) {
    if (lower.startsWith(r)) {
      root = r;
      break;
    }
  }
  root ??= _singleCharRoots.contains(lower.substring(0, 1))
      ? lower.substring(0, 1)
      : null;

  if (root == null) return token;

  bool isDur = token.substring(0, 1) == token.substring(0, 1).toUpperCase();
  return isDur ? _capitalize(root) : root;
}

String normalizeChord(String token) =>
    isChordSupported(token) ? token : baseChord(token);

// Cały zapis akordów; \S+ zostawia spacje i nowe linie (separatory ChordShiftera).
String normalizeChords(String chordsString) =>
    chordsString.replaceAllMapped(
      RegExp(r'\S+'),
      (m) => normalizeChord(m.group(0)!),
    );
