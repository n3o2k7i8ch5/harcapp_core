// =====================================================================
// Najstarsze legacy: parsowanie mejli z apki, która NIE JEST JUŻ ROZWIJANA.
// Trzymane osobno od `parse_contrib_email.dart`, żeby łatwo było to wywalić,
// gdy uznamy, że stara apka już nie krąży po świecie.
// =====================================================================

import 'package:harcapp_core/song_book/song_core.dart';

/// Charakterystyczny nagłówek z najstarszej wersji apki.
const String _oldestFormatMarker = 'Dzięki za chęć dzielenia się swoimi piosenkami!';

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
    'Nowe piosenki (w tym ta) lądują tylko w nowej wersji apki!\n'
    '\n'
    'Daj proszę przy okazji znać o tym w swoim środowisku! :)\n'
    '\n'
    'Czuwaj!';

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
  if(content.contains(_oldestFormatMarker))
    return OldestFormatDetection(songMap, true);
  return OldestFormatDetection(songMap, false);
}
