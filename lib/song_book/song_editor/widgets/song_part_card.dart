import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_button.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_scaffold.dart';
import 'package:harcapp_core/comm_widgets/app_toast.dart';
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

Color _textColorForType(BuildContext context, SongPartType type) {
  switch (type) {
    case SongPartType.REFREN:
      return textDisab_(context);
    case SongPartType.ZWROTKA:
    case SongPartType.REFREN_TEMPLATE:
      return textEnab_(context);
  }
}

int _calculateNewLines(int lineCnt, int otherLineCnt) {
  if (lineCnt < otherLineCnt) {
    if (otherLineCnt > SongPartCard.MIN_LINE_CNT) return otherLineCnt - lineCnt;
    else return SongPartCard.MIN_LINE_CNT - lineCnt;
  } else {
    if (lineCnt < SongPartCard.MIN_LINE_CNT) return SongPartCard.MIN_LINE_CNT - lineCnt;
  }
  return 0;
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

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if(topBuilder!=null) topBuilder!(context, songPart),

          SimpleButton(
              radius: AppCard.bigRadius,
              padding: EdgeInsets.all(Dimen.defMarg),
              margin: EdgeInsets.only(top: Dimen.defMarg, bottom: Dimen.defMarg),
              child: main,
              onTap: onTap
          )


        ],
      );

    },
  );
}

class _SongTextWidget extends StatelessWidget{

  final SongPartType type;
  final SongPart songPart;

  const _SongTextWidget({required this.type, required this.songPart});

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(left: songPart.shift ? Dimen.iconSize : 0),
    child: Text(
      _text,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: Dimen.textSizeNormal,
        color: _textColorForType(context, type),
      ),
    ),
  );

  String get _text {
    String songText = songPart.getText();
    int textLineCnt = songText.split('\n').length;
    int chrdLineCnt = songPart.chords.split('\n').length;
    return songText + '\n' * _calculateNewLines(textLineCnt, chrdLineCnt);
  }
}

class _SongChordsWidget extends StatelessWidget{

  final SongPartType type;
  final SongPart songPart;

  const _SongChordsWidget({required this.type, required this.songPart});

  @override
  Widget build(BuildContext context) => Text(
    _text,
    style: TextStyle(
      fontFamily: 'Roboto',
      fontSize: Dimen.textSizeNormal,
      color: _textColorForType(context, type),
    ),
  );

  String get _text {
    String songChords = songPart.chords;
    int chrdLineCnt = songChords.split('\n').length;
    int textLineCnt = songPart.getText().split('\n').length;
    return songChords + '\n' * _calculateNewLines(chrdLineCnt, textLineCnt);
  }
}

Widget _dragButton(BuildContext context, int index) => ReorderableDragStartListener(
  index: index,
  child: AppButton(
    icon: Icon(MdiIcons.swapVertical, color: iconEnab_(context)),
    onTap: () => showAppToast(context, text: 'Przytrzymaj, by przenieść'),
  ),
);

Widget _nameLabel(BuildContext context, String name, bool showName) => Expanded(
  child: showName
      ? Text(name, style: AppTextStyle(fontSize: Dimen.textSizeBig, fontWeight: weightHalfBold, color: hintEnab_(context)))
      : Container(),
);

Widget _deleteButton(BuildContext context, SongPart songPart, void Function(SongPart)? onDelete) => AppButton(
  icon: Icon(MdiIcons.trashCanOutline, color: iconEnab_(context)),
  onTap: () {
    onDelete?.call(songPart);
    CurrentItemProvider.of(context).removePart(songPart);
  },
);

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
      _dragButton(context, index),
      _nameLabel(context, 'Zwrotka', showName),

      if(songPart.isError)
        AppButton(
          icon: Icon(MdiIcons.alertCircleOutline, color: Colors.red),
          onTap: () => AppScaffold.showMessage(context, text: 'Zwrotka nie spełnia standardów. Podejrzyj ją by dowiedzieć się więcej.'),
        ),

      AppButton(
        icon: Icon(MdiIcons.contentDuplicate, color: iconEnab_(context)),
        onTap: () {
          onDuplicate?.call(songPart);
          CurrentItemProvider.of(context).addPart(songPart.copy());
        },
      ),

      _deleteButton(context, songPart, onDelete),
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
      _dragButton(context, index),
      _nameLabel(context, 'Refren', showName),
      _deleteButton(context, songPart, onDelete),
    ],
  );

}