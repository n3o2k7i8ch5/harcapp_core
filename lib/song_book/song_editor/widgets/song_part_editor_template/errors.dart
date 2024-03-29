import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common.dart';
import 'providers.dart';

const int MAX_CHORDS_IN_LINE = 8;
const int MAX_TEXT_LINE_LENGTH = 52;

isChordMissing(String text, String? chords) => text.length>0 && (chords == null || chords.length==0);

int handleAllErrors(BuildContext context){
  int errCount = 0;
  errCount += TextTooLongError.handleNotifyErrorsFrom(context);
  errCount += ChordsMissingError.handleNotifyErrorsFrom(context);
  
  return errCount;
}

abstract class SongEditError{

  final int? line;
  final Color color;
  final String text;

  const SongEditError({
    this.line,
    required this.color,
    required this.text
  });

}

class ChordsMissingError extends SongEditError{

  ChordsMissingError({int? line}): super(
    line: line,
    color: COLOR_WAR,
    text: 'Każda linijka tekstu, której akompniuje instrument wymaga podania chwytów.'
  );

  static int handleNotifyErrorsFrom(BuildContext context){
    ErrorProvider<ChordsMissingError> chordsMissingErrProv = Provider.of<ErrorProvider<ChordsMissingError>>(context, listen: false);
    return handleNotifyErrors(context, chordsMissingErrProv);
  }
  
  static int handleNotifyErrors(BuildContext context, ErrorProvider<ChordsMissingError> errProv){

    List<String> textLines = TextProvider.of(context).text.split('\n');
    List<String> chordLines = ChordsProvider.of(context).chords.split('\n');

    errProv.clear();
    for(int i=0; i<textLines.length; i++)
      if (isChordMissing(textLines[i], i < chordLines.length ? chordLines[i] : null))
        errProv.add(ChordsMissingError(line: i));

    errProv.notify();
    return errProv.length;
  }

  static bool hasError(String text, String chords){

    List<String> textLines = text.split('\n');
    List<String> chordsLines = chords.split('\n');

    for(int i=0; i<textLines.length; i++)
      if (isChordMissing(textLines[i], i<chordsLines.length?chordsLines[i]:null))
        return true;

    return false;
  }

}

class TextTooLongError extends SongEditError{

  TextTooLongError({int? line}): super(
      line: line,
      color: COLOR_ERR,
      text: 'Linijka tekstu nie powinna przekraczać $MAX_TEXT_LINE_LENGTH znaków.'
  );

  static int handleNotifyErrorsFrom(BuildContext context){
    ErrorProvider<TextTooLongError> textTooLongErrProv = Provider.of<ErrorProvider<TextTooLongError>>(context, listen: false);
    return handleNotifyErrors(context, textTooLongErrProv);
  }
  
  static int handleNotifyErrors(BuildContext context, ErrorProvider<TextTooLongError> errProv){

    List<String> textLines = Provider.of<TextProvider>(context, listen: false).text.split('\n');

    errProv.clear();
    for(int i=0; i<textLines.length; i++)
      if(textLines[i].length>MAX_TEXT_LINE_LENGTH)
        errProv.add(TextTooLongError(line: i));

    return errProv.length;

  }

  static bool hasError(String text, String chords){

    List<String> textLines = text.split('\n');

    for(int i=0; i<textLines.length; i++)
      if(textLines[i].length>MAX_TEXT_LINE_LENGTH)
        return true;

    return false;
  }
}

class AnyError extends StatelessWidget{

  final Widget Function(BuildContext context, int errCont) builder;

  const AnyError({required this.builder});

  @override
  Widget build(BuildContext context) => Consumer2<ErrorProvider<ChordsMissingError>, ErrorProvider<TextTooLongError>>(builder: (context, chordsMissingErrProv, textTooLongErrProv, child) =>
      builder(
          context,
          chordsMissingErrProv.length + textTooLongErrProv.length
      )
  );

}

bool hasAnyErrors(String text, String chords) =>
  ChordsMissingError.hasError(text, chords) || TextTooLongError.hasError(text, chords);