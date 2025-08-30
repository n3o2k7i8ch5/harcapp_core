import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_scaffold.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../common.dart';
import '../providers.dart';
import '../song_raw.dart';

enum SongPartType{
  ZWROTKA,
  REFREN,
  REFREN_TEMPLATE
}

class SongPartCard extends StatelessWidget{

  static const int MIN_LINE_CNT = 4;

  static const double EMPTY_HEIGHT = MIN_LINE_CNT*Dimen.textSizeNormal+4*Dimen.defMarg;

  final SongPart songPart;
  final SongPartType type;
  final Widget Function(BuildContext, SongPart)? topBuilder;
  final void Function()? onTap;

  final FocusNode focusNode = FocusNode();

  SongPartCard(
      { required this.songPart,
        required this.type,
        this.topBuilder,
        this.onTap
      });

  @override
  Widget build(BuildContext context) => Consumer<RefrenEnabProvider>(
    builder: (context, prov, _){

      String? emptText;
      IconData? iconData;
      bool pressable = false;

      if(type == SongPartType.ZWROTKA){
        if(songPart.isEmpty) {
          emptText = 'Edytuj zwrotkę';
          iconData = MdiIcons.pencilOutline;
          pressable = true;
        }
      }else if(type == SongPartType.REFREN){
        if(prov.refEnab!) {
          if(songPart.isEmpty)
            emptText = 'Refren pusty. Edytuj szablon powyżej.';
        }else
          emptText = 'Refren ukryty. Nie będzie wyświetlany w piosence.';
      }else if(type == SongPartType.REFREN_TEMPLATE){
        if(songPart.isEmpty) {
          emptText = 'Edytuj szablon';
          iconData = MdiIcons.pencilPlusOutline;
          pressable = true;
        }
      }

      Widget main;

      if(emptText==null)
        main = Row(
          children: <Widget>[
            Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: _SongTextWidget(type: type, songPart: songPart),
                )
            ),

            SizedBox(width: Dimen.defMarg),

            ConstrainedBox(
                constraints: BoxConstraints(minWidth: CHORDS_WIDGET_MIN_WIDTH),
                child: _SongChordsWidget(type: type, songPart: songPart)
            )
          ],
        );
      else{

        List<Widget> children = [
          Icon(iconData, color: pressable?iconEnab_(context):hintEnab_(context)),
          SizedBox(height: Dimen.iconMarg, width: Dimen.iconMarg),
          Text(
            emptText,
            style: AppTextStyle(
                color: pressable?iconEnab_(context):hintEnab_(context),
                fontSize: Dimen.textSizeBig,
                fontWeight: pressable?weightHalfBold:weightNormal
            ),
            textAlign: TextAlign.center,
          ),
        ];

        main = SizedBox(
            height: MIN_LINE_CNT*Dimen.textSizeNormal,
            child:
            pressable?
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ):
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            )
        );

      }

      return IgnorePointer(
          ignoring: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if(topBuilder!=null) topBuilder!(context, songPart),

              Stack(
                children: [

                  Positioned.fill(
                    child: IgnorePointer(
                        ignoring: false,
                        child: Container()
                    ),
                  ),

                  SimpleButton(
                      radius: AppCard.bigRadius,
                      padding: EdgeInsets.all(Dimen.defMarg),
                      margin: EdgeInsets.only(top: Dimen.defMarg, bottom: Dimen.defMarg),
                      child: main,
                      onTap: onTap
                  ),

                ],
              )


            ],
          )
      );

    },
  );
}

class _SongTextWidget extends StatelessWidget{

  final SongPartType type;
  final SongPart songPart;

  const _SongTextWidget({required this.type, required this.songPart});

  @override
  Widget build(BuildContext context) {

    Color? textColor;

    if(type == SongPartType.ZWROTKA) textColor = textEnab_(context);
    else if(type == SongPartType.REFREN) textColor = textDisab_(context);
    else if(type == SongPartType.REFREN_TEMPLATE) textColor = textEnab_(context);

    return Padding(
      padding: EdgeInsets.only(left: songPart.shift?Dimen.iconSize:0),
      child: Text(
        text,
        style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: Dimen.textSizeNormal,
            color: textColor
        ),
      ),
    );
  }

  String get text{

    String songText = songPart.getText();
    int textLineCnt = songText.split('\n').length;
    int chrdLineCnt = songPart.chords.split('\n').length;

    int newLinesCnt = 0;
    if(textLineCnt<chrdLineCnt) {
      if(chrdLineCnt>SongPartCard.MIN_LINE_CNT) newLinesCnt = chrdLineCnt - textLineCnt;
      else newLinesCnt = SongPartCard.MIN_LINE_CNT - textLineCnt;
    }else{
      if(textLineCnt<SongPartCard.MIN_LINE_CNT) newLinesCnt = SongPartCard.MIN_LINE_CNT - textLineCnt;
    }

    return songText + '\n'*newLinesCnt;
  }
}

class _SongChordsWidget extends StatelessWidget{

  final SongPartType type;
  final SongPart songPart;

  const _SongChordsWidget({required this.type, required this.songPart});

  @override
  Widget build(BuildContext context) {

    Color? textColor;

    if(type == SongPartType.ZWROTKA) textColor = textEnab_(context);
    else if(type == SongPartType.REFREN) textColor = textDisab_(context);
    else if(type == SongPartType.REFREN_TEMPLATE) textColor = textEnab_(context);

    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: Dimen.textSizeNormal,
          color: textColor
      ),
    );
  }

  String get text{

    String songChords = songPart.chords;
    int chrdLineCnt = songChords.split('\n').length;
    int textLineCnt = songPart.getText().split('\n').length;

    int newLinesCnt = 0;
    if(chrdLineCnt<textLineCnt) {
      if(textLineCnt>SongPartCard.MIN_LINE_CNT) newLinesCnt = textLineCnt - chrdLineCnt;
      else newLinesCnt = SongPartCard.MIN_LINE_CNT - chrdLineCnt;
    }else{
      if(chrdLineCnt<SongPartCard.MIN_LINE_CNT) newLinesCnt = SongPartCard.MIN_LINE_CNT - chrdLineCnt;
    }

    return songChords + '\n'*newLinesCnt;
  }

}

class TopZwrotkaButtons extends StatelessWidget{

  final SongPart songPart;
  final int index;
  final void Function(SongPart)? onDuplicate;
  final void Function(SongPart)? onDelete;
  final bool showName;

  const TopZwrotkaButtons(
      this.songPart,
      { required this.index,
        this.onDuplicate,
        this.onDelete,
        this.showName = true
      });

  @override
  Widget build(BuildContext context) => Row(
    children: <Widget>[

      Padding(
        padding: EdgeInsets.all(Dimen.iconMarg),
        child: ReorderableDragStartListener(index: index, child: Icon(MdiIcons.swapVertical, color: iconEnab_(context))),
      ),

      Expanded(
          child: showName?
          Text('Zwrotka', style: AppTextStyle(fontSize: Dimen.textSizeBig, fontWeight: weightHalfBold, color: hintEnab_(context))):
          Container()
      ),

      if(songPart.isError)
        IconButton(
          icon: Icon(MdiIcons.alertCircleOutline, color: Colors.red),
          onPressed: () => AppScaffold.showMessage(context, 'Zwrotka nie spełnia standardów. Podejrzyj ją by dowiedzieć się więcej.'),
        ),

      IconButton(
        icon: Icon(MdiIcons.contentDuplicate, color: iconEnab_(context)),
        onPressed: (){
          onDuplicate?.call(songPart);
          CurrentItemProvider.of(context).addPart(songPart.copy());
        },
      ),

      IconButton(
        icon: Icon(MdiIcons.trashCanOutline, color: iconEnab_(context)),
        onPressed: (){
          onDelete?.call(songPart);
          CurrentItemProvider.of(context).removePart(songPart);
        },
      ),

    ],
  );

}

class TopRefrenButtons extends StatelessWidget{

  final SongPart songPart;
  final int index;
  final void Function(SongPart)? onDelete;
  final bool showName;

  const TopRefrenButtons(
      this.songPart,
      { required this.index,
        this.onDelete,
        this.showName = true
      });

  @override
  Widget build(BuildContext context) => Row(
    children: <Widget>[

      Padding(
        padding: EdgeInsets.all(Dimen.iconMarg),
        child: ReorderableDragStartListener(index: index, child: Icon(MdiIcons.swapVertical, color: iconEnab_(context))),
      ),

      Expanded(
          child: showName?
          Text('Refren', style: AppTextStyle(fontSize: Dimen.textSizeBig, fontWeight: weightHalfBold, color: hintEnab_(context))):
          Container()
      ),

      IconButton(
        icon: Icon(MdiIcons.trashCanOutline, color: iconEnab_(context)),
        onPressed: (){
          onDelete?.call(songPart);
          CurrentItemProvider.of(context).removePart(songPart);
        },
      ),

    ],
  );

}