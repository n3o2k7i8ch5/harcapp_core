import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/comm_widgets/meto_row.dart';
import 'package:harcapp_core/comm_widgets/title_show_row_widget.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:harcapp_core/tag/tags_widget.dart';

import '../konspekt.dart';
import 'level_selectable_grid_widget.dart';

class KonspektsHarcerskieFilterWidget extends StatelessWidget{

  final Set<Meto> selectedMetos;
  final Set<KonspektSphere> selectedSpheres;
  final void Function(Set<Meto> selectedMetos, Set<KonspektSphere> selectedSpheres) onChanged;

  const KonspektsHarcerskieFilterWidget(this.selectedMetos, this.selectedSpheres, this.onChanged, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: [

      const TitleShortcutRowWidget(title: 'Metodyki', textAlign: TextAlign.left),

      LevelSelectableGridWidget(
        {Meto.zuch, Meto.harc, Meto.hs, Meto.wedro},
        selectedMetos,
        onLevelTap: (Meto meto, bool checked){
          Set<Meto> _selectedMetos = selectedMetos;
          if(checked) _selectedMetos.remove(meto);
          else _selectedMetos.add(meto);
          onChanged(_selectedMetos, selectedSpheres);
        },
      ),

      SizedBox(height: Dimen.sideMarg),

      const TitleShortcutRowWidget(title: 'Sfery rozwoju', textAlign: TextAlign.left),

      TagsWidget.wrap<KonspektSphere>(
        allTags: KonspektSphere.values,
        tagToName: (KonspektSphere sphere) => sphere.displayName,
        checkedTags: selectedSpheres.toList(),
        onTagTap: (KonspektSphere sphere, bool checked){
          Set<KonspektSphere> _selectedSpheres = selectedSpheres;
          if(checked) _selectedSpheres.remove(sphere);
          else _selectedSpheres.add(sphere);
          onChanged(selectedMetos, _selectedSpheres);
        },
      )

    ],
  );

}

class SearchFieldBottomHarcerskieFiltersWidget extends StatelessWidget{

  final Set<Meto> selectedLevels;
  final Set<KonspektSphere> selectedSpheres;

  const SearchFieldBottomHarcerskieFiltersWidget(this.selectedLevels, this.selectedSpheres, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Meto> sortedSelectedLevels = selectedLevels.toList();
    sortedSelectedLevels.sort((t1, t2) => t1.index - t2.index);

    List<KonspektSphere> sortedSelectedSpheres = selectedSpheres.toList();
    sortedSelectedSpheres.sort((t1, t2) => t1.index - t2.index);

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(bottom: 6, left: Dimen.iconMarg, right: Dimen.iconMarg),
        child: SizedBox(
          height: 2*Dimen.defMarg + Dimen.textSizeNormal + 3,
          child: Row(
            children: [

              MetoRow(sortedSelectedLevels),

              ...sortedSelectedSpheres.map<Widget>((sphere) => Padding(
                padding: const EdgeInsets.only(left: MetoRow.separatorWidth),
                child: Icon(sphere.displayIcon, size: 18.0),
              )),

            ],
          ),
        )
    );

  }

}