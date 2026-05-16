/// Proste reguły odmiany nazw własnych do dopełniacza (genitive). Pokrywają
/// nazwy chorągwi/okręgów ZHP+ZHR. Dla nieznanych form zwracają wyraz bez
/// zmian — wywołujący powinien wiedzieć, że jakość zależy od wejścia.
library;

/// „Chorągiew Krakowska" → „krakowskiej". Strip prefixu „Chorągiew" + odmiana
/// ostatniego wyrazu. Nazwy już w dopełniaczu („Ziemi Lubuskiej") oraz formy
/// typu „Harcerek Okręgu Dolnośląskiego" nie są ruszane (ostatni wyraz nie
/// kończy się na -a/-i).
String choragiewGenitive(String name) {
  final stripped = name.startsWith('Chorągiew ')
      ? name.substring('Chorągiew '.length)
      : name;
  return _phraseGenitive(stripped).toLowerCase();
}

/// „Okręg Dolnośląski" → „okręgu dolnośląskiego".
String okregGenitive(String name) {
  final stripped = name.startsWith('Okręg ')
      ? 'okręgu ${name.substring('Okręg '.length)}'
      : name;
  return _phraseGenitive(stripped).toLowerCase();
}

/// Odmienia ostatni wyraz frazy do dopełniacza.
String _phraseGenitive(String phrase) {
  final parts = phrase.split(' ');
  parts[parts.length - 1] = _wordGenitive(parts.last);
  return parts.join(' ');
}

String _wordGenitive(String w) {
  // Wyraz z myślnikiem („Kujawsko-Pomorska") — odmień ostatni człon.
  if (w.contains('-')) {
    final segs = w.split('-');
    segs[segs.length - 1] = _wordGenitive(segs.last);
    return segs.join('-');
  }
  // Przymiotnik żeński „-a" → „-ej" (Krakowska → Krakowskiej, Stołeczna → Stołecznej).
  if (w.endsWith('a')) return '${w.substring(0, w.length - 1)}ej';
  // Przymiotnik męski „-i" → „-iego" (Dolnośląski → Dolnośląskiego).
  if (w.endsWith('i')) return '${w}ego';
  // Już w dopełniaczu albo nieznana forma — zostaw.
  return w;
}
