import 'package:flutter/widgets.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../providers.dart';
import '../song_raw.dart';

class AddButtonsWidget extends StatelessWidget{

  final Function? onPressed;
  final Color? accentColor;
  const AddButtonsWidget({this.onPressed, this.accentColor, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) => Row(
    children: [

      Expanded(
        child: SimpleButton(
          radius: AppCard.bigRadius,
          padding: EdgeInsets.all(Dimen.iconMarg),
          onTap: (){
            Provider.of<CurrentItemProvider>(context, listen: false).addPart(SongPart.empty());
            onPressed?.call();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(MdiIcons.plus, color: accentColor??accent_(context)),
              Icon(MdiIcons.musicBox, color: accentColor??accent_(context)),
              SizedBox(width: Dimen.iconMarg),
              Text('Zwrotka', style: AppTextStyle(fontSize: Dimen.TEXT_SIZE_BIG))
            ],
          ),
        ),
      ),

      Expanded(
        child: Consumer<CurrentItemProvider>(
            builder: (context, currItemProv, child) => SimpleButton(
              radius: AppCard.bigRadius,
              padding: EdgeInsets.all(Dimen.iconMarg),
              onTap: currItemProv.hasRefren?(){
                currItemProv.addPart(SongPart.from(currItemProv.song.refrenPart.element));
                onPressed?.call();
              }:null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(MdiIcons.plus, color: currItemProv.hasRefren?(accentColor??accent_(context)):iconDisab_(context)),
                  Icon(MdiIcons.musicBoxOutline, color: currItemProv.hasRefren?(accentColor??accent_(context)):iconDisab_(context)),
                  SizedBox(width: Dimen.iconMarg),
                  Text(
                      'Refren',
                      style: AppTextStyle(
                          fontSize: Dimen.TEXT_SIZE_BIG,
                          color: currItemProv.hasRefren?textEnab_(context):iconDisab_(context)
                      )
                  )
                ],
              ),
            )
        ),
      )

    ],
  );

}