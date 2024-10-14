import 'package:harcapp_core/comm_classes/common.dart';
import 'package:harcapp_core/harcthought/konspekts/data/harcerskie/harcerskie.dart';
import 'package:harcapp_core/harcthought/konspekts/data/ksztalcenie/all.dart';
import 'package:harcapp_core/harcthought/konspekts/filter/konspekt_filters.dart';

import '../konspekt.dart';


List<Konspekt> runKonspektsHarcerskieSearch(KonspektHarcerskieFilters filters){

  if(filters.isEmpty)
    return allHarcerskieKonspekts;

  List<Konspekt> searchedKonspekts = [];

  for(Konspekt konspekt in allHarcerskieKonspekts) {
    if(!remPolChars(konspekt.title).contains(remPolChars(filters.phrase)))
      continue;

    if(!konspekt.containsMetos(filters.selectedMetos))
      continue;

    if(!konspekt.containsSpheres(filters.selectedSpheres))
      continue;

    searchedKonspekts.add(konspekt);
  }

  return searchedKonspekts;

}

List<Konspekt> runKonspektsKsztalcenioweSearch(KonspektKsztalcenioweFilters filters){

  if(filters.phrase.trim().isEmpty && filters.selectedLevels.isEmpty)
    return allKsztalcenieKonspekts;

  List<Konspekt> searchedKonspekts = [];

  for(Konspekt konspekt in allKsztalcenieKonspekts) {
    if(!remPolChars(konspekt.title).contains(remPolChars(filters.phrase)))
      continue;

    if(!konspekt.containsMetos(filters.selectedLevels))
      continue;

    searchedKonspekts.add(konspekt);
  }

  return searchedKonspekts;

}