import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';

import '../comm_classes/color_pack.dart';
import '../values/dimen.dart';
import 'chord.dart';
import 'instrument_type.dart';


class _Fretboard extends StatelessWidget{

  final double size;
  final Color? color;

  final int? frets;
  final int? strings;

  const _Fretboard({
    this.size = ChordWidget.defSize,
    this.color,
    this.frets,
    this.strings
  });

  @override
  Widget build(BuildContext context) {

    double sizePart = size/frets!;
    double heightFactor = .8;

    List<Widget> horLines = [SizedBox(
      height: heightFactor*sizePart,
      child: Center(child: Container(height: 2, width: size, color: color)),
    )];

    for(int i=0; i<strings!-1; i++)
      horLines.insert(0, SizedBox(
        height: heightFactor*sizePart,
        child: Center(child: Container(height: 1, width: size, color: color)),
      ));

    List<Widget> verLines = [];

    for(int i=0; i<frets!; i++)
      verLines.add(SizedBox(
        width: sizePart,
        child: Align(child: Container(height: heightFactor*sizePart*(strings!-1), width: 1, color: color), alignment: Alignment.centerLeft),
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

  static const double defSize = 32.0;
  static const double defPositionTextSize = 7.0;
  static const double defChordNameSize = Dimen.textSizeSmall;
  static const double defMarg = SimpleButton.defMargVal;
  static const double defPadding = SimpleButton.defPaddVal;

  static const int defFretCnt = 5;

  static double positionTextSize(double size) => defPositionTextSize * size/defSize;
  static double chordNameSize(double size) => defChordNameSize * size/defSize;
  static double marg(double size) => defMarg * size/defSize;
  static double padding(double size) => defPadding * size/defSize;
  
  
  static double height(int strCnt, {double size = defSize, int frets = defFretCnt}){
    return strCnt*frets + chordNameSize(size) + positionTextSize(size) + 2*marg(size) + 2*padding(size);
  }

  final Chord? chord;
  final double size;
  final Color? color;
  final double elevation;

  final int frets;
  final int? strings;

  final void Function()? onTap;

  const ChordWidget({
    this.chord,
    this.size = defSize,
    this.color,
    this.elevation = 4.0,

    this.frets = defFretCnt,
    this.strings,

    this.onTap,
  });

  static ChordWidget fromGChord(
      GChord chord,
      { Color? color,
        double size = ChordWidget.defSize,
        void Function()? onTap,
      }) => ChordWidget(
    chord: chord,
    strings: 6,
    color: color,
    size: size,
    onTap: onTap,
  );

  static ChordWidget fromUChord(
      UChord chord,
      { Color? color,
        double size = ChordWidget.defSize,
        void Function()? onTap,
      }) => ChordWidget(
    chord: chord,
    strings: 4,
    color: color,
    size: size,
    onTap: onTap,
  );

  static ChordWidget fromMChord(
    MChord chord,
    { Color? color,
      double size = ChordWidget.defSize,
      void Function()? onTap,
    }) => ChordWidget(
    chord: chord,
    strings: 4,
    color: color,
    size: size,
    onTap: onTap,
  );

  @override
  Widget build(BuildContext context) {

    Chord _chord = chord!.shiftToFirstDot();
    int nearestDotPosition = chord!.nearestDotPosition;

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
        margin: EdgeInsets.all(marg(size)),
        padding: EdgeInsets.all(padding(size)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
                nearestDotPosition==1?
                nearestDotPosition.toString():
                (nearestDotPosition-1).toString(),
                style: AppTextStyle(
                    fontSize: positionTextSize(size),
                    fontWeight: weight.bold,
                    color: color??iconEnab_(context)
                ),
                textAlign: TextAlign.start
            ),

            SizedBox(
              width: size,
              height: strings!*heightFactor*sizePart,
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
                        height: strings!*heightFactor*sizePart,
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
                chord!.name,
                style: AppTextStyle(
                    fontSize: chordNameSize(size),
                    fontWeight: weight.halfBold,
                    color: color??iconEnab_(context)
                )

            )
          ],
        ),
    );
  }


}

class ChordDrawBar extends StatefulWidget{
  
  final String chords;
  final Color background;
  final Color? chordColor;
  final double elevation;
  final bool changeTypeOnTap;
  final InstrumentType initType;
  final bool showLabel;
  final EdgeInsets padding;

  final void Function(Chord, InstrumentType)? onTap;
  
  const ChordDrawBar(
      this.chords, {
        this.background=Colors.transparent,
        this.chordColor,
        this.elevation=0,
        this.changeTypeOnTap=true,
        this.initType = InstrumentType.GUITAR,
        this.showLabel=true,
        this.padding=EdgeInsets.zero,

        this.onTap,

        Key? key
      }):super(key: key);
  
  @override
  State<StatefulWidget> createState() => ChordDrawBarState();
  
}

class ChordDrawBarState extends State<ChordDrawBar>{

  late InstrumentType type;

  @override
  void initState() {

    type = widget.initType;

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {

    List<String> guitChordStrs = [];
    List<String> ukulChordStrs = [];
    List<String> mandChordStrs = [];

    List<String> lines = widget.chords.split('\n');

    for(String line in lines) {
      List<String> chordStrs = line.split(' ');
      for(String chordStr in chordStrs) {

        if(chordStr.isEmpty) continue;

        if(!guitChordStrs.contains(chordStr))guitChordStrs.add(chordStr);

        String ukulChordStr = chordStr.replaceAll(RegExp(r'[0-9+]'), '');
        if(!ukulChordStrs.contains(ukulChordStr)) ukulChordStrs.add(ukulChordStr);

        String mandChordStr = chordStr.replaceAll(RegExp(r'[1234589+]'), '');
        if(!mandChordStrs.contains(mandChordStr)) mandChordStrs.add(mandChordStr);

      }
    }

    List<Widget> guitChords = [];
    for(String chordStr in guitChordStrs) {
      List<GChord>? chordSet = GChord.chordDrawableMap[chordStr];
      if(chordSet == null) continue;
      guitChords.add(
          ChordWidget.fromGChord(
              chordSet[0],
              color: widget.chordColor,
              onTap: (){
                if(widget.changeTypeOnTap)
                  setState(() => type = type.next);
                widget.onTap?.call(chordSet[0], type);
              }
          )
      );
    }

    List<Widget> ukulChords = [];
    for(String chordStr in ukulChordStrs){
      UChord? chord = UChord.chordDrawableMap[chordStr];
      if(chord == null) continue;
      ukulChords.add(
          ChordWidget.fromUChord(
              chord,
              color: widget.chordColor,
              onTap:(){
                if(widget.changeTypeOnTap)
                  setState(() => type = type.next);
                widget.onTap?.call(chord, type);
              }
          )
      );
    }

    List<Widget> mandChords = [];
    for(String chordStr in mandChordStrs){
      MChord? chord = MChord.chordDrawableMap[chordStr];
      if(chord == null) continue;
      mandChords.add(
          ChordWidget.fromMChord(
              chord,
              color: widget.chordColor,
              onTap:(){
                if(widget.changeTypeOnTap)
                  setState(() => type = type.next);
                widget.onTap?.call(chord, type);
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:
                    type == InstrumentType.GUITAR?
                    guitChords:
                    (type == InstrumentType.UKULELE?
                    ukulChords:
                    // type == InstrumentType.MANDOLIN?
                    mandChords
                    )
                ),
            ),
          ),

          if(widget.showLabel)
            Padding(
              padding: EdgeInsets.all(Dimen.defMarg),
              child: RotatedBox(
                child: Text(type.name, style: AppTextStyle(fontSize: Dimen.textSizeTiny, color: hintEnab_(context))),
                quarterTurns: 3,
              ),
            )
        ],
      ),
    );
  }
  
}