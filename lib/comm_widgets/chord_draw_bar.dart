
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
    this.size: ChordWidget2.DEF_SIZE,
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

class ChordWidget2 extends StatelessWidget{

  static const double DEF_SIZE = 32.0;
  static const double POSITION_TEXT_HEIGHT = 7.0;
  static const double CHORD_NAME_HEIGHT = Dimen.TEXT_SIZE_SMALL;

  final Chord chord;
  final double size;
  final Color color;
  final double elevation;

  final int frets;
  final int strings;

  final void Function() onTap;

  const ChordWidget2({
    this.chord,
    this.size: DEF_SIZE,
    this.color,
    this.elevation: 4.0,

    this.frets,
    this.strings,

    this.onTap,
  });

  static ChordWidget2 fromGChord(GChord chord, {Color color}) => ChordWidget2(
    chord: chord,
    frets: 5,
    strings: 6,
    color: color,
  );

  static ChordWidget2 fromUChord(UChord chord, {Color color}) => ChordWidget2(
    chord: chord,
    frets: 5,
    strings: 4,
    color: color,
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
                color: color,
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
                    color: textEnab_(context)
                ),
                textAlign: TextAlign.start
            ),

            Stack(
              children: [

                _Fretboard(
                    size: size,
                    color: color,
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
                        color: color,
                      ),
                    ),
                  ),

                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: dotsOnString
                )

              ],
            ),

            Text(
                chord.name,
                style: AppTextStyle(
                    fontSize: CHORD_NAME_HEIGHT,
                    fontWeight: weight.halfBold,
                    color: color
                )

            )
          ],
        )
    );
  }


}

class ChordDrawBar2 extends StatefulWidget{
  
  final String chords;
  final Color background;
  final Color chordColor;
  final double elevation;

  final void Function(bool) onTap;
  
  const ChordDrawBar2(
      this.chords, {
        this.background=Colors.transparent,
        this.chordColor=ColorPack.DEF_ICON_ENAB,
        this.elevation=0,
        this.onTap
      });
  
  @override
  State<StatefulWidget> createState() => ChordDrawBar2State();
  
}

class ChordDrawBar2State extends State<ChordDrawBar2>{
  
  bool typeGuitar;

  List<Widget> guitChords;
  List<Widget> ukulChords;

  @override
  void initState() {

    typeGuitar = true;

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
      
      guitChords = [];
      for(String chordStr in guitChordStrs) {
        List<GChord> chordSet = GChord.chordDrawableMap[chordStr];
        if(chordSet == null) continue;
        guitChords.add(ChordWidget2.fromGChord(chordSet[0], color: widget.chordColor));
      }

      ukulChords = [];
      for(String chordStr in ukulChordStrs){
        UChord chord = UChord.chordDrawableMap[chordStr];
        if(chord == null) continue;
        ukulChords.add(ChordWidget2.fromUChord(chord, color: widget.chordColor));
      }

    }

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {

    return Material(
      color: widget.background,
      elevation: widget.elevation,
      child: InkWell(
        onTap: (){
          setState(() => typeGuitar = !typeGuitar);
          if(widget.onTap != null)
            widget.onTap(typeGuitar);
        },
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                  typeGuitar?
                  guitChords:
                  ukulChords,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(Dimen.DEF_MARG),
              child: RotatedBox(
                child: Text(typeGuitar?'Gitara':'Ukulele', style: AppTextStyle(fontSize: Dimen.TEXT_SIZE_TINY, color: hintEnabled(context))),
                quarterTurns: 3,
              ),
            )
          ],
        ),
      ),
    );
  }
  
}

class ChordWidget extends StatelessWidget{

  static const double POSITION_TEXT_HEIGHT = 7.0;
  static const double STRING_HEIGHT = 5;
  static const double CHORD_NAME_HEIGHT = Dimen.TEXT_SIZE_SMALL;

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
    int nearestDotPosition = chord.nearestDotPosition;
    chord = chord.shiftToFirstDot();
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

    for(int i=0; i<_chord.strings.length-1; i++){
      childBar.add(stringElement);
      childDot.add(Stack(children: <Widget>[
        stringElement,
        _chord.strings[_chord.strings.length-i-1]==index?RoundContainer(ChordWidget.STRING_HEIGHT, color: color):Container(width: ChordWidget.STRING_HEIGHT),
      ])
      );
    }

    childBar.add(stringElementFat);
    childDot.add(Stack(children: <Widget>[
      stringElementFat,
      _chord.strings[0]==index?RoundContainer(ChordWidget.STRING_HEIGHT, color: color):Container(width: ChordWidget.STRING_HEIGHT),
    ]));

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
          Text(nearestDotPosition.toString(), style: AppTextStyle(fontSize: POSITION_TEXT_HEIGHT, color: hint), textAlign: TextAlign.start,),

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
                  fontSize: CHORD_NAME_HEIGHT,
                  fontWeight: weight.halfBold,
                  color: color
              )

          )

        ],
      ),
    );
  }

  static double height(int stringCount){
    return (stringCount)*STRING_HEIGHT +
        stringCount+
        POSITION_TEXT_HEIGHT +
        CHORD_NAME_HEIGHT +
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
  final double chordElevation;
  final Color background;
  final Color chordBackground;
  final Widget leading, trailing;

  const ChordDrawBar(this.text, {@required this.typeGuitar, this.onTypeChanged, this.onChordTap, this.changeTypeOnTap: true, this.borderRadius, this.margin:const EdgeInsets.all(Dimen.DEF_MARG/2), this.elevation: 1.0, this.chordElevation: 0, this.background, this.chordBackground, this.leading, this.trailing});

  @override
  State<StatefulWidget> createState() => ChordDrawBarState();

}

class ChordDrawBarState extends State<ChordDrawBar>{

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

    return Material(
      color: widget.background??background_(context),
      elevation: widget.elevation,
      child: Row(
        children: <Widget>[
          if(widget.leading != null) widget.leading,

          Expanded(
              child: Row(
                children: <Widget>[

                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
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
                            background: widget.chordBackground??cardEnab_(context),
                            hint: textEnab_(context),
                            color: iconEnab_(context),
                            onTap: onTap,
                            elevation: widget.chordElevation
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

