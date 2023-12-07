import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_scaffold.dart';
import 'package:harcapp_core/comm_widgets/title_show_row_widget.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../providers.dart';
import 'song_part_card.dart';


class RefrenTemplate extends StatelessWidget{

  final Function()? onPartTap;
  final Function(bool value)? onRefrenEnabledChanged;
  final Color? accentColor;

  const RefrenTemplate({this.onPartTap, this.onRefrenEnabledChanged, this.accentColor});

  @override
  Widget build(BuildContext context) => Consumer2<CurrentItemProvider, RefrenPartProvider>(
    builder: (context, currItemProv, refProv, child) => Padding(
      padding: EdgeInsets.only(left: Dimen.defMarg, right: Dimen.defMarg),
      child: SongPartCard(
        songPart: currItemProv.song.refrenPart,
        type: SongPartType.REFREN_TEMPLATE,
        topBuilder: (context, part) => Padding(
          padding: EdgeInsets.only(left: Dimen.ICON_MARG - Dimen.defMarg),
          child: Consumer<CurrentItemProvider>(
            builder: (context, currItemProv, child) => TitleShortcutRowWidget(
                title: 'Szablon refrenu',
                titleColor:
                currItemProv.hasRefren?textEnab_(context):textDisab_(context),
                textAlign: TextAlign.start,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    if(currItemProv.song.refrenPart.isError)
                      IconButton(
                        icon: Icon(MdiIcons.alertCircleOutline, color: Colors.red),
                        onPressed: () => AppScaffold.showMessage(context, 'Refren nie spełnia standardów. Podejrzyj go by dowiedzieć się więcej.'),
                      ),

                    Switch(
                      value: currItemProv.hasRefren,
                      onChanged: (bool value){
                        currItemProv.setHasRefren(!currItemProv.hasRefren);
                        if(onRefrenEnabledChanged != null) onRefrenEnabledChanged!(value);
                      },
                      activeColor: accentColor??accent_(context),
                    ),

                  ],
                )
            ),
          ),
        ),
        onTap: () => onPartTap?.call(),
      ),
    ),
  );
}