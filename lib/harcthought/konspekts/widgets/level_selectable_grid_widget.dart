import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';

import '../../../comm_widgets/meto.dart';
import '../../../values/dimen.dart';

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

class LevelSelectableGridWidget extends StatelessWidget{

  final Set<Meto> availableLevels;
  final Set<Meto> selectedLevels;
  final bool oneLine;
  final void Function(Meto meto, bool checked)? onLevelTap;

  const LevelSelectableGridWidget(
      this.availableLevels,
      this.selectedLevels,
      { this.oneLine = false,
        this.onLevelTap,
        super.key
      });

  @override
  Widget build(BuildContext context){

    List<Widget> children = [];

    List<Meto> allMetos = availableLevels.toList();
    for(int i=0; i<availableLevels.length; i++){

      Meto meto = allMetos[i];

      children.add(

        _AnimatedSelectedWrapper(
          enabled: selectedLevels.contains(meto),
          onTap: () => onLevelTap?.call(meto, selectedLevels.contains(meto)),
          child: MetoTile(
            meto: meto,
            iconSize: 42.0,
            trailing: Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(
                selectedLevels.contains(meto)?Icons.check_circle:Icons.radio_button_unchecked,
                color: background_(context),
              ),
            ),
            intrinsicWidth: oneLine,
          ),
        ),

      );

      if(oneLine && i<availableLevels.length-1)
        children.add(SizedBox(width: Dimen.defMarg));

    }

    if(oneLine)
      return Row(
        children: children,
      );

    return LayoutGrid(
      columnSizes: [1.fr, 1.fr],
      rowSizes: List.filled((availableLevels.length/2).ceil(), auto),
      columnGap: Dimen.defMarg,
      rowGap: Dimen.defMarg,
      children: children,
    );

  }

}
