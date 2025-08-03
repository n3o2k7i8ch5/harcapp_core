import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/comm_widgets/title_show_row_widget.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/tag/tags_widget.dart';

import '../widgets/level_selectable_grid_widget.dart';
import 'konspekt_filters.dart';

abstract class KonspektFiltersWidget<T extends KonspektFilters> extends StatefulWidget{

  final T filters;
  final void Function(T filters) onChanged;

  const KonspektFiltersWidget(this.filters, {required this.onChanged, super.key});

}

class KonspektHarcerskieFiltersWidget extends KonspektFiltersWidget<KonspektHarcerskieFilters>{

  const KonspektHarcerskieFiltersWidget(super.filters, {required super.onChanged, super.key});

  @override
  State<StatefulWidget> createState() => KonspektHarcerskieFiltersWidgetState();

}

class KonspektHarcerskieFiltersWidgetState extends State<KonspektHarcerskieFiltersWidget>{

  KonspektHarcerskieFilters get filters => widget.filters;
  void Function(KonspektHarcerskieFilters filters) get onChanged => widget.onChanged;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: [

      const TitleShortcutRowWidget(title: 'Metodyki', textAlign: TextAlign.left),

      LevelSelectableGridWidget(
        {Meto.zuch, Meto.harc, Meto.hs, Meto.wedro},
        filters.selectedMetos,
        onLevelTap: (Meto meto, bool checked){
          Set<Meto> _selectedMetos = filters.selectedMetos;
          if(checked) _selectedMetos.remove(meto);
          else _selectedMetos.add(meto);
          onChanged(
              KonspektHarcerskieFilters(
                  phrase: filters.phrase,
                  selectedMetos: _selectedMetos,
                  selectedSpheres: filters.selectedSpheres
              )
          );
          // `setState()` is needed here in case `onChanged` changes the values
          // of objects used as argument of this widget while the widget is
          // open in the dialog.
          setState(() {});
        },
      ),

      SizedBox(height: Dimen.sideMarg),

      const TitleShortcutRowWidget(title: 'Sfery rozwoju', textAlign: TextAlign.left),

      TagsWidget.wrap<KonspektSphere>(
        allTags: KonspektSphere.values,
        tagToName: (KonspektSphere sphere) => sphere.displayName,
        checkedTags: filters.selectedSpheres.toList(),
        onTagTap: (KonspektSphere sphere, bool checked){
          Set<KonspektSphere> _selectedSpheres = filters.selectedSpheres;
          if(checked) _selectedSpheres.remove(sphere);
          else _selectedSpheres.add(sphere);
          onChanged(
              KonspektHarcerskieFilters(
                  phrase: filters.phrase,
                  selectedMetos: filters.selectedMetos,
                  selectedSpheres: _selectedSpheres
              )
          );
          // `setState()` is needed here in case `onChanged` changes the values
          // of objects used as argument of this widget while the widget is
          // open in the dialog.
          setState(() {});
        },
      )

    ],
  );

}

class KonspektKsztalcenieFiltersWidget extends KonspektFiltersWidget<KonspektKsztalcenieFilters>{

  const KonspektKsztalcenieFiltersWidget(super.filters, {required super.onChanged, super.key});

  @override
  State<StatefulWidget> createState() => KonspektKsztalcenieFiltersWidgetState();

}

class KonspektKsztalcenieFiltersWidgetState extends State<KonspektKsztalcenieFiltersWidget>{

  KonspektKsztalcenieFilters get filters => widget.filters;
  void Function(KonspektKsztalcenieFilters filters) get onChanged => widget.onChanged;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [

      const TitleShortcutRowWidget(title: 'Poziomy', textAlign: TextAlign.left),

      LevelSelectableGridWidget(
        {Meto.kadra},
        filters.selectedLevels,
        onLevelTap: (Meto meto, bool checked){
          Set<Meto> _selectedLevels = filters.selectedLevels;
          if(checked) _selectedLevels.remove(meto);
          else _selectedLevels.add(meto);
          onChanged(
              KonspektKsztalcenieFilters(
                  phrase: filters.phrase,
                  selectedLevels: _selectedLevels
              )
          );
          // `setState()` is needed here in case `onChanged` changes the values
          // of objects used as argument of this widget while the widget is
          // open in the dialog.
          setState(() {});
        },
      ),

    ],
  );

}

/// ---

