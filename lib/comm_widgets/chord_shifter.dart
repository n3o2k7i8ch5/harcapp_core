import 'chord_draw.dart';

class ChordShifter{

  List<ChordDraw> chordList = [];
  List<String> separatorList = [];

  int _shift;
  bool separatorFirst = false;

  ChordShifter(String string, int shift){

    if(string == null || string.length==0) {
      this._shift = shift;
      return;
    }
    List<String> lines = string.split('\n');
    try {decode(lines, shift);}
    on Exception{throw Exception();}
  }

  static String run(String text, int shift){
    return ChordShifter(text, shift).getText(true);
  }

  void decode(List<String> lines, int shift){

    List<ChordDraw> _chordList = [];
    List<String> _separatorList = [];

    bool _separatorFirst = false;

    try {
      if (lines[0].length == 0)
        _separatorFirst = true;

      for (int i = 0; i < lines.length; i++) {
        List<String> chordsStringArray = lines[i].split(' ');
        if (lines[i].length > 0) {
          for (String chord in chordsStringArray) {
            if(chord.length == 0) continue;
            _chordList.add(ChordDraw.decode(chord));
            _separatorList.add(' ');
          }
          if (lines.length - 1 != i)
            _separatorList[_separatorList.length - 1] = '\n';
        } else {
          if (i == 0)
            _separatorList.add('\n');
          else if (i != lines.length - 1) {
            int lastPos = _separatorList.length - 1;
            _separatorList[lastPos] = _separatorList[lastPos] + '\n';
          }
        }
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
  int get shift => _shift;

  static int shiftToneUp(int shift) {
    shift = (shift + 1)%12;
    return shift;
  }

  static int shiftToneDown(int shift) {
    shift = (shift + 11)%12;
    return shift;
  }
}