
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/primitive_wrapper.dart';

import '../comm_classes/color_pack.dart';
import '../colors.dart';
import '../dimen.dart';
import 'app_card.dart';
import 'chord.dart';

const Duration CHORD_WIDGET_GROW_DURATION = const Duration(milliseconds: 200);

class ChordWidget extends StatelessWidget{

  static const double STRING_HEIGHT = 5;

  final Chord _chord;
  final int nearestDotPosition;
  final Function onTap;

  final Color background;
  final Color hint;
  final Color color;
  final double elevation;

  const ChordWidget(
      this._chord,
      this.nearestDotPosition,
      this.onTap,
      this.background,
      this.hint,
      this.color,
      this.elevation,
      );

  static ChordWidget from(Chord chord, {Function onTap, Color background: Colors.white, Color hint: AppColors.text_hint_enab, Color color: AppColors.text_def_enab, elevation: AppCard.defElevation}){
    int nearestDotPosition = chord.getNearestDotPosition();
    chord = chord.shiftChordToFirstDot();
    return ChordWidget(chord, nearestDotPosition, onTap, background, hint, color, elevation);
  }

  Widget _getBar(int index){

    final Widget stringElementFat = Container(
      height: ChordWidget.STRING_HEIGHT,
      width: ChordWidget.STRING_HEIGHT,
      child: Center(child: Container(
        width: ChordWidget.STRING_HEIGHT,
        height: 2,
        color: color,
      )),
    );

    final Widget stringElement = Container(
      height: ChordWidget.STRING_HEIGHT,
      width: ChordWidget.STRING_HEIGHT,
      child: Center(child: Container(
        width: ChordWidget.STRING_HEIGHT,
        height: 1,
        color: color,
      )),
    );

    List<Widget> childBar = [];
    List<Widget> childDot = [];

    for(int i=0; i<_chord.strings.length; i++){
      childBar.add(i==_chord.strings.length-1?stringElementFat:stringElement);
      childDot.add(Stack(children: <Widget>[
        i==_chord.strings.length-1?stringElementFat:stringElement,
        _chord.strings[_chord.strings.length-i-1]==index?RoundContainer(ChordWidget.STRING_HEIGHT, color: color):Container(width: ChordWidget.STRING_HEIGHT),
      ])
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 1,
          height: ChordWidget.STRING_HEIGHT*(_chord.strings.length-1)+1,
          margin: EdgeInsets.only(top: 1),
          color: color,
        ),

        _chord.bar==index?
        Stack(children: <Widget>[

          RoundContainer(ChordWidget.STRING_HEIGHT*6, width: ChordWidget.STRING_HEIGHT-1, color: color),

          Column(children: childBar)
        ])
            :
        Column(children: childDot)

      ],
    );

  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      elevation: elevation,
      color: background,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(nearestDotPosition.toString(), style: AppTextStyle(fontSize: 7.0, color: hint), textAlign: TextAlign.start,),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _getBar(1),
              _getBar(2),
              _getBar(3),
              _getBar(4),
            ],
          ),

          Text(
              _chord.name,
              style: AppTextStyle(
                  fontSize: Dimen.TEXT_SIZE_SMALL,
                  fontWeight: weight.halfBold,
                  color: color
              )

          )

        ],
      ),
    );
  }

  static double height(int stringCount){
    return (stringCount-1)*STRING_HEIGHT +
        stringCount+
        7.0 +
        Dimen.TEXT_SIZE_NORMAL +
        2*Dimen.DEF_MARG;
  }

}

class ChordDrawBar extends StatefulWidget{

  final String text;
  final PrimitiveWrapper<bool> typeGuitar;
  final Function(bool) onTypeChanged;
  final Function(Chord chord) onChordTap;
  final bool changeTypeOnTap;
  final BorderRadius borderRadius;
  final EdgeInsets margin;
  final double elevation;
  final Color chordBackground;
  final Widget leading, trailing;

  const ChordDrawBar(this.text, {@required this.typeGuitar, this.onTypeChanged, this.onChordTap, this.changeTypeOnTap: true, this.borderRadius, this.margin:const EdgeInsets.all(Dimen.DEF_MARG/2), this.elevation: 1.0, this.chordBackground, this.leading, this.trailing});

  @override
  State<StatefulWidget> createState() => ChordDrawBarState();

}

class ChordDrawBarState extends State<ChordDrawBar> with TickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {

    List<String> chordsString;
    chordsString = [];
    List<String> lines = widget.text.split('\n');

    for(String line in lines) {
      List<String> items = line.split(' ');
      for(String item in items) {
        if (!widget.typeGuitar.get()) item = item.replaceAll(RegExp(r'[0-9+]'), '');
        if (item.length > 0 && !chordsString.contains(item)) chordsString.add(item);
      }
    }

    return AnimatedSize(
      vsync: this,
      duration: CHORD_WIDGET_GROW_DURATION,
      child: Row(
        children: <Widget>[
          if(widget.leading != null) widget.leading,

          Expanded(
              child: Row(
                children: <Widget>[

                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: chordsString.map((item){

                        Chord chord;

                        if(widget.typeGuitar.get()){
                          if(GChord.chordDrawableMap[item] == null)
                            chord = GChord.empty;
                          else
                            chord = GChord.chordDrawableMap[item][0];
                        }else{
                          if(UChord.chordDrawableMap[item] == null)
                            chord = UChord.empty;
                          else
                            chord = UChord.chordDrawableMap[item];
                        }

                        Function() onTap = widget.onTypeChanged==null && widget.onChordTap==null?null:(){
                          if(widget.onChordTap!=null) widget.onChordTap(chord);
                          if(widget.onTypeChanged!=null) widget.onTypeChanged(!widget.typeGuitar.get());
                          if(widget.changeTypeOnTap) setState(() => widget.typeGuitar.set(!widget.typeGuitar.get()));
                        };

                        return chord == null?Container(width: 0, height: 0,):
                        ChordWidget.from(
                            chord,
                            background: widget.chordBackground??defCardEnabled(context),
                            hint: textEnabled(context),
                            color: iconEnabledColor(context),
                            onTap: onTap,
                            elevation: widget.elevation
                        );
                      }).toList()
                      ),
                    ),
                  ),
                ],
              )
          ),

          Padding(
            padding: EdgeInsets.all(Dimen.DEF_MARG),
            child: RotatedBox(
              child: Text(widget.typeGuitar.get()?'Gitara':'Ukulele', style: AppTextStyle(fontSize: Dimen.TEXT_SIZE_TINY, color: hintEnabled(context))),
              quarterTurns: 3,
            ),
          )
        ],
      ),
    );
  }

}

class RoundContainer extends StatelessWidget{

  final double height;
  final double width;
  final Color color;
  const RoundContainer(this.height, {this.width: -1, this.color:Colors.black});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width==-1?height:width,
        height: height,
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(height/2)),
          elevation: 6,
          color: color,
        )
    );
  }
}