import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/common.dart';
import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/comm_widgets/title_show_row_widget.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import '../../../comm_widgets/meto_row.dart';
import '../data/ksztalcenie/all.dart';
import 'level_selectable_grid_widget.dart';

class KonspektsKsztalcenioweFilterWidget extends StatelessWidget{

  final Set<Meto> selectedLevels;
  final void Function(Set<Meto> selectedMetos) onChanged;

  const KonspektsKsztalcenioweFilterWidget(this.selectedLevels, this.onChanged, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [

      const TitleShortcutRowWidget(title: 'Poziomy', textAlign: TextAlign.left),

      LevelSelectableGridWidget(
        {Meto.kadra},
        selectedLevels,
        onLevelTap: (Meto meto, bool checked){
          Set<Meto> _selectedLevels = selectedLevels;
          if(checked) _selectedLevels.remove(meto);
          else _selectedLevels.add(meto);
          onChanged(_selectedLevels);
        },
      ),

    ],
  );

}


class SearchFieldBottomKsztalcenioweFiltersWidget extends StatelessWidget{

  final Set<Meto> selectedLevels;

  const SearchFieldBottomKsztalcenioweFiltersWidget(this.selectedLevels, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Meto> sortedSelectedLevels = selectedLevels.toList();
    sortedSelectedLevels.sort((t1, t2) => t1.index - t2.index);

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(bottom: 6, left: Dimen.iconMarg, right: Dimen.iconMarg),
        child: SizedBox(
          height: 2*Dimen.defMarg + Dimen.textSizeNormal + 3,
          child: Row(
            children: [

              MetoRow(sortedSelectedLevels),

            ],
          ),
        )
    );

  }

}

List<Konspekt> runKonspektsKsztalcenioweSearch(String phrase, Set<Meto> selectedLevels){

  if(phrase.isEmpty && selectedLevels.isEmpty)
    return allKsztalcenieKonspekts;

  List<Konspekt> searchedKonspekts = [];

  for(Konspekt konspekt in allKsztalcenieKonspekts) {
    if(!remPolChars(konspekt.title).contains(remPolChars(phrase)))
      continue;

    if(!konspekt.containsMetos(selectedLevels))
      continue;

    searchedKonspekts.add(konspekt);
  }

  return searchedKonspekts;

}