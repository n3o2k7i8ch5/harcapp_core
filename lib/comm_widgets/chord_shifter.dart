import 'chord_draw.dart';

class ChordShifter{

  List<ChordDraw> chordList = [];
  List<String> separatorList = [];

  late int _shift;
  bool separatorFirst = false;

  ChordShifter(String string, int shift){

    if(string.length==0) {
      this._shift = shift;
      return;
    }
    try {decode(string, shift);}
    on Exception{throw Exception();}
  }

  static String run(String text, int shift){
    return ChordShifter(text, shift).getText(true);
  }

  void decode(String chordsString, int shift){

    List<String> lines = chordsString.split('\n').map((line) => line.trim()).toList();

    List<ChordDraw> _chordList = [];
    List<String> _separatorList = [];

    bool _separatorFirst = false;

    try {
      if (lines[0].length == 0)
        _separatorFirst = true;

      // for (int i = 0; i < lines.length; i++) {
      //   String line = lines[i];
      //   List<String> chordsStrings = line.split(' ');
      //   if (line.length > 0) {
      //     for (int iChord = 0; i<chordsStrings.length; i++) {
      //       String chord = chordsStrings[iChord];
      //       if(chord.length == 0) continue;
      //       _chordList.add(ChordDraw.decode(chord));
      //       _separatorList.add(' ');
      //     }
      //     if (i != lines.length - 1)
      //       _separatorList[_separatorList.length - 1] = '\n';
      //   } else {
      //     if (i == 0)
      //       _separatorList.add('\n');
      //     else if (i != lines.length - 1) {
      //       int lastPos = _separatorList.length - 1;
      //       _separatorList[lastPos] = _separatorList[lastPos] + '\n';
      //     }
      //   }
      // }

      for (int i = 0; i < lines.length; i++) {
        String line = lines[i];
        List<String> chordsStringArray = line.split(' ');
        if (line.isNotEmpty) {
          for (int iChord=0; iChord<chordsStringArray.length; iChord++) {
            String chord = chordsStringArray[iChord];
            if(chord.isEmpty) continue;
            _chordList.add(ChordDraw.decode(chord));
            if(iChord < chordsStringArray.length-1) _separatorList.add(' ');
          }
          if (i < lines.length - 1) _separatorList.add('\n');
        } else  if (i == 0)
          _separatorList.add('\n');
        else if (i < lines.length - 1)
          _separatorList.last = _separatorList.last + '\n';

      }
    } on Exception{
      throw Exception();
    }

    this.chordList = _chordList;
    this.separatorList = _separatorList;
    this._shift = shift;
    this.separatorFirst = _separatorFirst;
  }

  int up() {
    _shift = (_shift + 1)%12;
    return _shift;
  }

  int down() {
    _shift = (_shift + 11)%12;
    return _shift;
  }

  void shiftTo(int shift) => this._shift = shift%12;

  String getText(bool shifted){
    String output = "";

    if(separatorFirst) {
      for(int i = 0; i<separatorList.length; i++) {
        output += separatorList[i];

        if(chordList.length > i) {
          if (shifted) output += chordList[i].getChordName(_shift);
          else output += chordList[i].getChordName(0);
        }
      }
    }
    else {
      for(int i = 0; i<chordList.length; i++){
        if (shifted) output += chordList[i].getChordName(_shift);
        else output += chordList[i].getChordName(0);

        if (separatorList.length > i) output += separatorList[i];
      }
    }

    if(output.length>0 && output.substring(output.length-1, output.length-1) == ' ')
      output = output.substring(0, output.length-1);

    return output;
  }

  List<ChordDraw> getChordList() => chordList;
  List<String> getSeparatorList() => separatorList;
  int? get shift => _shift;

  static int shiftToneUp(int shift) {
    shift = (shift + 1)%12;
    return shift;
  }

  static int shiftToneDown(int shift) {
    shift = (shift + 11)%12;
    return shift;
  }
}