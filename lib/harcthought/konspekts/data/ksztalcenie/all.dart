import 'package:harcapp_core/harcthought/konspekts/data/ksztalcenie/dwie_roty_dwoch_przyrzeczen_harcerskich.dart';
import 'package:harcapp_core/harcthought/konspekts/data/ksztalcenie/warsztaty_wychowania_duchowego.dart';
import 'package:harcapp_core/harcthought/konspekts/data/ksztalcenie/warsztaty_wychowania_duchowego_old.dart';
import 'package:harcapp_core/harcthought/konspekts/data/ksztalcenie/wstep_do_wychowania_duchowego.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';

import 'czynniki_i_mechanizmy_ksztaltowania_duchowosci.dart';

Future<List<Konspekt>> _loadAllKsztalcenieKonspekts() async => [
  konspekt_kszt_dwie_roty_dwoch_przyrzeczen_harcerskich,
  konspekt_kszt_warsztaty_wychowania_duchowego,
  konspekt_kszt_warsztaty_wychowania_duchowego_old,
  konspekt_kszt_wstep_do_wychowania_duchowego,
  konspekt_kszt_czynniki_i_mechanizmy_ksztaltowania_duchowosci,
];

bool initialized = false;
late List<Konspekt> _allKsztalcenieKonspekts;
List<Konspekt> get allKsztalcenieKonspekts{
  if(!initialized)
    throw Exception("'allKsztalcenieKonspekts' not initialized. Did you forget to call 'initializeKonspekts()'?");

  return _allKsztalcenieKonspekts;
}

Future<void> initializeKsztalcenieKonspekts() async {
  if(initialized) return;
  _allKsztalcenieKonspekts = await _loadAllKsztalcenieKonspekts();
  initialized = true;
}