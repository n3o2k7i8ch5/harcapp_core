
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/primitive_wrapper.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';

import '../comm_classes/color_pack.dart';
import '../colors.dart';
import '../dimen.dart';
import 'app_card.dart';
import 'chord.dart';

class _Fretboard extends StatelessWidget{

  final double size;
  final Color color;

  final int frets;
  final int strings;

  const _Fretboard({
    this.size: ChordWidget.DEF_SIZE,
    this.color,
    this.frets,
    this.strings
  });

  @override
  Widget build(BuildContext context) {

    double sizePart = size/frets;
    double heightFactor = .8;

    List<Widget> horLines = [SizedBox(
      height: heightFactor*sizePart,
      child: Center(child: Container(height: 2, width: size, color: color)),
    )];

    for(int i=0; i<strings-1; i++)
      horLines.insert(0, SizedBox(
        height: heightFactor*sizePart,
        child: Center(child: Container(height: 1, width: size, color: color)),
      ));

    List<Widget> verLines = [];

    for(int i=0; i<frets; i++)
      verLines.add(SizedBox(
        width: sizePart,
        child: Align(child: Container(height: heightFactor*sizePart*(strings-1), width: 1, color: color), alignment: Alignment.centerLeft),
      ));

    return Stack(
      children: [
        Column(children: horLines),
        Positioned.fill(child: Center(child: Row(children: verLines)))
      ],
    );
  }

}

class ChordWidget extends StatelessWidget{

  static const double DEF_SIZE = 32.0;
  static const double POSITION_TEXT_HEIGHT = 7.0;
  static const double CHORD_NAME_HEIGHT = Dimen.TEXT_SIZE_SMALL;
  static const int DEF_FRET_CNT = 5;


  static double height(int strCnt, {double size = DEF_SIZE, int frets = DEF_FRET_CNT}){

    double sizePart = size/frets;
    double heightFactor = .8;

    return strCnt*frets + CHORD_NAME_HEIGHT + POSITION_TEXT_HEIGHT + 2*SimpleButton.DEF_MARG + 2*SimpleButton.DEF_PADDING;
  }

  final Chord chord;
  final double size;
  final Color color;
  final double elevation;

  final int frets;
  final int strings;

  final void Function() onTap;

  const ChordWidget({
    this.chord,
    this.size: DEF_SIZE,
    this.color,
    this.elevation: 4.0,

    this.frets: 5,
    this.strings,

    this.onTap,
  });

  static ChordWidget fromGChord(
      GChord chord,
      {
        Color color,
        void Function() onTap,
      }) => ChordWidget(
    chord: chord,
    strings: 6,
    color: color,
    onTap: onTap,
  );

  static ChordWidget fromUChord(
      UChord chord,
      {
        Color color,
        void Function() onTap,
      }) => ChordWidget(
    chord: chord,
    strings: 4,
    color: color,
    onTap: onTap,
  );


  @override
  Widget build(BuildContext context) {

    Chord _chord = chord.shiftToFirstDot();
    int nearestDotPosition = chord.nearestDotPosition;

    double sizePart = size/frets;
    double heightFactor = .8;
    double barFactor = .7;

    List<Widget> dotsOnString = [];

    for(int pos in _chord.strings)
      dotsOnString.insert(0, 
        pos == 0?
        SizedBox(height: sizePart*heightFactor):
        Row(
          children: [
            SizedBox(
                width:
                nearestDotPosition == 1?
                sizePart*(pos-1) + (1-heightFactor)*sizePart:
                sizePart*(pos) + (1-heightFactor)*sizePart
            ),
            Container(
              width: sizePart*heightFactor,
              height: sizePart*heightFactor,
              child: Material(
                borderRadius: BorderRadius.circular(100),
                color: color??iconEnab_(context),
                elevation: elevation,
              ),
            )
          ],
        ),
      );

    return SimpleButton(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
                nearestDotPosition==1?
                nearestDotPosition.toString():
                (nearestDotPosition-1).toString(),
                style: AppTextStyle(
                    fontSize: POSITION_TEXT_HEIGHT,
                    fontWeight: weight.bold,
                    color: color??iconEnab_(context)
                ),
                textAlign: TextAlign.start
            ),

            SizedBox(
              width: size,
              height: strings*heightFactor*sizePart,
              child: Stack(
                children: [

                  _Fretboard(
                      size: size,
                      color: color??iconEnab_(context),
                      frets: frets,
                      strings: strings
                  ),

                  if(_chord.bar != 0)
                    Positioned(
                      top: 0,
                      left: (1-heightFactor)*sizePart + (nearestDotPosition == 1?0:sizePart),
                      child: Container(
                        width: barFactor*sizePart,
                        height: strings*heightFactor*sizePart,
                        child: Material(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          elevation: elevation,
                          color: color??iconEnab_(context),
                        ),
                      ),
                    ),

                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: dotsOnString
                  )

                ],
              ),
            ),

            Text(
                chord.name,
                style: AppTextStyle(
                    fontSize: CHORD_NAME_HEIGHT,
                    fontWeight: weight.halfBold,
                    color: color??iconEnab_(context)
                )

            )
          ],
        )
    );
  }


}

class ChordDrawBar extends StatefulWidget{
  
  final String chords;
  final Color background;
  final Color chordColor;
  final double elevation;
  final bool changeTypeOnTap;
  final bool initTypeGuitar;
  final bool showLabel;
  final EdgeInsets padding;

  final void Function(Chord, bool) onTap;
  
  const ChordDrawBar(
      this.chords, {
        this.background=Colors.transparent,
        this.chordColor=ColorPack.DEF_ICON_ENAB,
        this.elevation=0,
        this.changeTypeOnTap=true,
        this.initTypeGuitar,
        this.showLabel=true,
        this.padding=EdgeInsets.zero,

        this.onTap,

        Key key
      }):super(key: key);
  
  @override
  State<StatefulWidget> createState() => ChordDrawBarState();
  
}

class ChordDrawBarState extends State<ChordDrawBar>{
  
  bool typeGuitar;

  @override
  void initState() {

    typeGuitar = widget.initTypeGuitar??true;

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {

    List<String> guitChordStrs = [];
    List<String> ukulChordStrs = [];
    List<String> lines = widget.chords.split('\n');

    for(String line in lines) {
      List<String> chordStrs = line.split(' ');
      for(String chordStr in chordStrs) {

        if(chordStr.isEmpty) continue;

        if(!guitChordStrs.contains(chordStr))guitChordStrs.add(chordStr);

        String ukulChordStr = chordStr.replaceAll(RegExp(r'[0-9+]'), '');
        if(!ukulChordStrs.contains(ukulChordStr)) ukulChordStrs.add(ukulChordStr);

      }
    }

    List<Widget> guitChords = [];
    for(String chordStr in guitChordStrs) {
      List<GChord> chordSet = GChord.chordDrawableMap[chordStr];
      if(chordSet == null) continue;
      guitChords.add(
          ChordWidget.fromGChord(
              chordSet[0],
              color: widget.chordColor,
              onTap: (){
                if(widget.changeTypeOnTap)
                  setState(() => typeGuitar = !typeGuitar);

                if(widget.onTap != null)
                  widget.onTap(chordSet[0], typeGuitar);
              }
          )
      );
    }

    List<Widget> ukulChords = [];
    for(String chordStr in ukulChordStrs){
      UChord chord = UChord.chordDrawableMap[chordStr];
      if(chord == null) continue;
      ukulChords.add(
          ChordWidget.fromUChord(
              chord,
              color: widget.chordColor,
              onTap:(){
                if(widget.changeTypeOnTap)
                  setState(() => typeGuitar = !typeGuitar);

                if(widget.onTap != null)
                  widget.onTap(chord, typeGuitar);
              }
          )
      );
    }

    return Material(
      color: widget.background,
      elevation: widget.elevation,
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: widget.padding,
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                typeGuitar?
                guitChords:
                ukulChords,
              ),
            ),
          ),

          if(widget.showLabel)
            Padding(
              padding: EdgeInsets.all(Dimen.DEF_MARG),
              child: RotatedBox(
                child: Text(typeGuitar?'Gitara':'Ukulele', style: AppTextStyle(fontSize: Dimen.TEXT_SIZE_TINY, color: hintEnabled(context))),
                quarterTurns: 3,
              ),
            )
        ],
      ),
    );
  }
  
}