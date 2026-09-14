// =====================================================================
// Najstarsze legacy: parsowanie mejli z apki, która NIE JEST JUŻ ROZWIJANA.
// Trzymane osobno od `parse_contrib_email.dart`, żeby łatwo było to wywalić,
// gdy uznamy, że stara apka już nie krąży po świecie.
// =====================================================================

import 'package:harcapp_core/song_book/song_core.dart';

/// Charakterystyczny nagłówek z najstarszej wersji apki. Klienty pocztowe
/// łamią długie linie, więc dopuszczamy dowolny odstęp między słowami —
/// sztywne `contains` gubiło mejle przełamane w środku nagłówka.
final RegExp _oldestFormatMarkerRe = RegExp(
    r'Dzięki\s+za\s+chęć\s+dzielenia\s+się\s+swoimi\s+piosenkami',
    caseSensitive: false);

/// Najstarsza apka nie miała sekcji `### Kod piosenki:` — JSON piosenki wkleja
/// między dwa znaczniki „nie edytuj". Wielkość liter i liczba wykrzykników
/// bywają różne (`!!! NIE EDYTUJ PONIŻSZEGO TEKSTU !!!`, `(!) Nie edytuj
/// poniższego tekstu`), więc rozpoznajemy je luźno.
final RegExp _oldestSongStartRe =
    RegExp(r'!{0,3}\s*\(?!?\)?\s*nie\s+edytuj\s+poniższego\s+tekstu\s*!{0,3}',
        caseSensitive: false);
final RegExp _oldestSongEndRe =
    RegExp(r'!{0,3}\s*\(?!?\)?\s*nie\s+edytuj\s+powyższego\s+tekstu\s*!{0,3}',
        caseSensitive: false);

/// Fragment treści między znacznikami „nie edytuj", albo null, gdy mejl
/// nie jest z najstarszej apki.
///
/// Po drodze zdejmuje to, co dokłada poczta: prefiksy cytowania (`> `) z
/// odpowiedzi w wątku i znaczniki HTML, gdy klient odesłał treść jako HTML
/// (adres w `email_ref` bywa wtedy owinięty w `<a href="mailto:…">`).
String? oldestFormatSongRegion(String content){
  final start = _oldestSongStartRe.firstMatch(content);
  if(start == null) return null;

  String region = content.substring(start.end);
  final end = _oldestSongEndRe.firstMatch(region);
  if(end != null) region = region.substring(0, end.start);

  region = region
      .split('\n')
      .map((l) => l.replaceFirst(RegExp(r'^\s*>+ ?'), ''))
      .join('\n');
  return _stripHtml(region).trim();
}

/// Po czym poznać, że klient odesłał treść jako HTML. Samo `<` nie wystarczy:
/// `Refren <powtórz 2x>` albo `Zosia -> Kasia` w tekście piosenki to nie tagi,
/// a zdejmowanie ich po cichu psuło piosenkę bez błędu parsowania.
final RegExp _htmlTagRe = RegExp(
    r'<(a|br|div|p|span|b|i|u|font|html|body|blockquote)(\s[^>]*)?/?>',
    caseSensitive: false);

/// `<a href="mailto:x@y">x@y</a>` → `x@y`, `<br>` → nowa linia, reszta tagów
/// won. Encje wracają do postaci, w jakiej były w JSON-ie.
String _stripHtml(String s){
  if(!_htmlTagRe.hasMatch(s)) return s;
  return s
      .replaceAllMapped(RegExp(r'<a[^>]*href="mailto:([^"]*)"[^>]*>.*?</a>',
          caseSensitive: false, dotAll: true), (m) => m.group(1)!)
      .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
      .replaceAll(RegExp(r'<[^>]+>'), '')
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll('&quot;', '"')
      .replaceAll('&#39;', "'")
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&amp;', '&');
}

/// Treść maila zwrotnego, którą Daniel ma wysłać autorowi maila w starym
/// formacie, żeby przesiadł się na nową apkę.
const String oldestFormatReplyMessage =
    'Dzięki za piosenki :)\n'
    '\n'
    'Ważne info!\n'
    'Stara wersja apki, którą masz zainstalowaną, NIE JEST JUŻ ROZWIJANA. '
    'Żeby "przesiąść się" na nową wersję apki wystarczy pobrać HarcAppa od nowa:\n'
    '\n'
    '[Android]\n'
    'https://play.google.com/store/apps/details?id=com.daniwan.harcapp\n'
    '\n'
    '[iOS]\n'
    'https://apps.apple.com/us/app/harcapp/id6754627071\n'
    '\n'
    'Nowe piosenki lądują tylko w nowej wersji apki!\n'
    '\n'
    'Daj proszę przy okazji znać o tym w swoim środowisku! :)\n'
    '\n'
    'Czuwaj!';

/// Najstarsza apka zapisywała `add_pers` swobodnie: raz samym napisem
/// z imieniem, raz listą napisów, raz listą map, w których `name` leży obok
/// `email_ref` zamiast w zagnieżdżonym `person`. Nowszy model tego nie łyka
/// (`respMap['add_pers'] as List`, a potem `ContributorRef.fromApiRespMap`),
/// więc sprowadzamy wszystkie trzy kształty do dzisiejszego.
///
/// Ruszamy wyłącznie mejle rozpoznane jako najstarszy format — nowsze
/// przechodzą bez zmian.
Map<String, dynamic> normalizeOldestSongMap(Map<String, dynamic> songMap){
  final raw = songMap[SongCore.PARAM_CONTRIB_REFS];
  if(raw == null) return songMap;

  final list = raw is List ? raw : [raw];
  final refs = <Map<String, dynamic>>[];
  for(final entry in list){
    if(entry is String){
      if(entry.trim().isNotEmpty)
        refs.add({'person': {'name': entry.trim()}});
    } else if(entry is Map)
      refs.add(_contribRefFromOldest(Map<String, dynamic>.from(entry)));
  }
  songMap[SongCore.PARAM_CONTRIB_REFS] = refs;
  return songMap;
}

/// `{name, email_ref, …}` → `{person: {name}, email_ref, …}`.
Map<String, dynamic> _contribRefFromOldest(Map<String, dynamic> entry){
  if(entry.containsKey('person') || !entry.containsKey('name')) return entry;
  final name = (entry['name'] as String? ?? '').trim();
  return {
    if(name.isNotEmpty) 'person': {'name': name},
    for(final e in entry.entries) if(e.key != 'name') e.key: e.value,
  };
}

/// Wynik rozpoznania najstarszego formatu — możliwa zdejmięta otoczka JSON
/// piosenki + flaga, czy w ogóle mamy do czynienia ze starym formatem.
class OldestFormatDetection {
  final Map<String, dynamic> songMap;
  final bool isOldestFormat;
  const OldestFormatDetection(this.songMap, this.isOldestFormat);
}

/// Najstarszy format mejla owijał piosenkę w `{"o!_filename": {...songFields...}}`.
/// Rozpoznajemy po pojedynczym kluczu z prefiksem `o!_`, którego wartością
/// jest mapa z polem `title`. Wtedy bierzemy zawartość i podnosimy flagę.
/// Dodatkowy sygnał: charakterystyczny nagłówek w treści mejla.
OldestFormatDetection detectOldestFormat(Map<String, dynamic> songMap, String content){
  if(songMap.length == 1){
    final onlyKey = songMap.keys.first;
    final inner = songMap[onlyKey];
    if(onlyKey.startsWith('o!_')
        && inner is Map<String, dynamic>
        && inner[SongCore.PARAM_TITLE] is String){
      return OldestFormatDetection(inner, true);
    }
  }
  // Nagłówek powitalny albo sam kształt mejla (JSON między znacznikami
  // „nie edytuj") — jedno i drugie występuje tylko w najstarszej apce.
  if(_oldestFormatMarkerRe.hasMatch(content) || oldestFormatSongRegion(content) != null)
    return OldestFormatDetection(songMap, true);
  return OldestFormatDetection(songMap, false);
}
