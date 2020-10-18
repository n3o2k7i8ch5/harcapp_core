

import 'package:harcapp_core/comm_classes/common.dart';

class ChordDraw{

  int chordCode;
  bool isDur;
  String additionalNumber; // ex. d7; null -> nothing
  bool hasPlus = false;

  ChordDraw(this.chordCode, this.isDur, this.additionalNumber, this.hasPlus);

  static ChordDraw decode(String chord){

    List<String> chords = chord.split(' ');
    chords = chords[chords.length-1].split('\n');
    chord = chords[chords.length-1];

    String lastChar = chord.substring(chord.length - 1, chord.length);

    bool hasPlus;
    if(lastChar == '+') {
      hasPlus = true;
      chord = chord.substring(0, chord.length-1);
    }else hasPlus = false;

    String additionalNumber;
    if(isDigit(lastChar)) {
      additionalNumber = lastChar;
      chord = chord.substring(0, chord.length-1);
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
    String s_chord = null;

    int chord_with_shift;
    chord_with_shift = (chordCode + shift + 12) %12;


    if(isDur) {
      switch (chord_with_shift) {
        case 0:
          s_chord = "C";
          break;
        case 1:
          s_chord = "Cis";
          break;
        case 2:
          s_chord = "D";
          break;
        case 3:
          s_chord = "Dis";
          break;
        case 4:
          s_chord = "E";
          break;
        case 5:
          s_chord = "F";
          break;
        case 6:
          s_chord = "Fis";
          break;
        case 7:
          s_chord = "G";
          break;
        case 8:
          s_chord = "Gis";
          break;
        case 9:
          s_chord = "A";
          break;
        case 10:
          s_chord = "B";
          break;
        case 11:
          s_chord = "H";
          break;
      }
    }else{
      switch (chord_with_shift){
        case 0:
          s_chord = "c";
          break;
        case 1:
          s_chord = "cis";
          break;
        case 2:
          s_chord = "d";
          break;
        case 3:
          s_chord = "dis";
          break;
        case 4:
          s_chord = "e";
          break;
        case 5:
          s_chord = "f";
          break;
        case 6:
          s_chord = "fis";
          break;
        case 7:
          s_chord = "g";
          break;
        case 8:
          s_chord = "gis";
          break;
        case 9:
          s_chord = "a";
          break;
        case 10:
          s_chord = "b";
          break;
        case 11:
          s_chord = "h";
          break;
      }
    }

    if(additionalNumber != null)
      s_chord += additionalNumber.toString();

    if(hasPlus)
      s_chord += "+";

    return s_chord;
  }

  int getChordCode(){return chordCode;}
  bool getIsDur(){return isDur;}
  String getAdditionalNumber(){return additionalNumber;}
}