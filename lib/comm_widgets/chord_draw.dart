
import 'package:harcapp_core/comm_classes/common.dart';

class ChordDraw{

  int chordCode;
  bool isDur;
  String? additionalNumber; // ex. d7; null -> nothing
  bool hasPlus = false;

  ChordDraw(this.chordCode, this.isDur, this.additionalNumber, this.hasPlus);

  static ChordDraw decode(String chord){

    List<String> chords = chord.split(' ');
    chords = chords[chords.length-1].split('\n');
    chord = chords[chords.length-1];

    String lastChar = chord.substring(chord.length - 1);

    bool hasPlus;
    if(lastChar == '+') {
      hasPlus = true;
      chord = chord.substring(0, chord.length-1);
    }else hasPlus = false;

    String? additionalNumber;
    if(isDigit(lastChar)) {
      additionalNumber = lastChar;
      chord = chord.substring(0, chord.length-1);
      lastChar = chord.substring(chord.length - 1);
    }else additionalNumber = null;

    //Check Dur-Mol
    bool isDur = chord.substring(0, 1) == chord.substring(0, 1).toUpperCase();

    try { return ChordDraw(_chordToInt(chord), isDur, additionalNumber, hasPlus);}
    on Exception{throw Exception();}
  }

  static int _chordToInt(String chord)
  {
    switch (chord){
      case 'c': case 'C':
        return 0;
      case 'cis': case 'Cis':
        return 1;
      case 'd': case 'D':
        return 2;
      case 'dis': case 'Dis':
        return 3;
      case 'e': case 'E':
        return 4;
      case 'f': case 'F':
        return 5;
      case 'fis': case 'Fis':
        return 6;
      case 'g': case 'G':
        return 7;
      case 'gis': case 'Gis':
        return 8;
      case 'a': case 'A':
        return 9;
      case 'b': case 'B':
        return 10;
      case 'h': case 'H':
        return 11;
      default:
        throw Exception();
    }
  }

  String getChordName(int shift){
    String chordStr = '';

    int chordWithShift = (chordCode + shift + 12) %12;

    switch (chordWithShift) {
      case 0:
        chordStr = isDur?'C':'c';
        break;
      case 1:
        chordStr = isDur?'Cis':'cis';
        break;
      case 2:
        chordStr = isDur?'D':'d';
        break;
      case 3:
        chordStr = isDur?'Dis':'dis';
        break;
      case 4:
        chordStr = isDur?'E':'e';
        break;
      case 5:
        chordStr = isDur?'F':'f';
        break;
      case 6:
        chordStr = isDur?'Fis':'fis';
        break;
      case 7:
        chordStr = isDur?'G':'g';
        break;
      case 8:
        chordStr = isDur?'Gis':'gis';
        break;
      case 9:
        chordStr = isDur?'A':'a';
        break;
      case 10:
        chordStr = isDur?'B':'b';
        break;
      case 11:
        chordStr = isDur?'H':'h';
        break;
    }

    if(additionalNumber != null)
      chordStr += additionalNumber.toString();

    if(hasPlus)
      chordStr += "+";

    return chordStr;
  }

}