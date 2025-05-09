import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/meto.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/comm_widgets/title_show_row_widget.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/tag/tags_widget.dart';

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

class LevelSelectableGridWidget extends StatelessWidget{

  final Set<Meto> availableLevels;
  final Set<Meto> selectedLevels;
  final void Function(Meto meto, bool checked)? onLevelTap;

  const LevelSelectableGridWidget(this.availableLevels, this.selectedLevels, {this.onLevelTap, super.key});

  @override
  Widget build(BuildContext context){

    List<Widget> children = [];

    for(Meto meto in availableLevels){
      children.add(

        _AnimatedSelectedWrapper(
          enabled: selectedLevels.contains(meto),
          onTap: () => onLevelTap?.call(meto, selectedLevels.contains(meto)),
          child: MetoTile(
            meto: meto,
            iconSize: 42.0,
            trailing: Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                selectedLevels.contains(meto)?Icons.check_circle:Icons.radio_button_unchecked,
                color: Colors.white,
              ),
            ),
            intrinsicWidth: false,
          ),
        ),

      );
    }

    return LayoutGrid(
      columnSizes: [1.fr, 1.fr],
      rowSizes: List.filled((availableLevels.length/2).ceil(), auto),
      columnGap: Dimen.defMarg,
      rowGap: Dimen.defMarg,
      children: children,
    );

  }

}

class _AnimatedSelectedWrapper extends StatelessWidget{

  final bool enabled;
  final Widget child;
  final void Function()? onTap;

  const _AnimatedSelectedWrapper({
    required this.enabled,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => Opacity(
    opacity: enabled?1:0.5,
    child: SimpleButton(
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      elevation: enabled?AppCard.bigElevation:0,
      borderRadius: BorderRadius.circular(AppCard.defRadius),
      onTap: onTap,
      child: child,
    ),
  );

}