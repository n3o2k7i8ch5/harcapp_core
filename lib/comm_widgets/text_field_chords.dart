import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldChords extends StatefulWidget{

  final TextStyle? textStyle;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final int? minLines;
  final int? maxLines;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final bool expands;
  final Function(String)? onChanged;
  final bool autofocus;
  final bool enabled;
  final TextAlign textAlign;

  const TextFieldChords({
    this.textStyle,
    this.controller,
    this.decoration,
    this.minLines,
    this.maxLines,
    this.focusNode,
    this.keyboardType:TextInputType.visiblePassword,
    this.expands: false,
    this.onChanged,
    this.autofocus: false,
    this.enabled: true,
    this.textAlign: TextAlign.start});

  @override
  State<StatefulWidget> createState() => TextFieldChordsState();
}

class TextFieldChordsState extends State<TextFieldChords> {

  TextEditingController? _controller;
  TextEditingController? get _effectiveController => widget.controller ?? _controller;

  int? shift;

  bool? recentlyTyped;
  @override
  void initState() {

    if (widget.controller == null) _controller = TextEditingController();

    shift = 0;

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return TextField(
      style: widget.textStyle,
      decoration: widget.decoration,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      focusNode: widget.focusNode,
      controller: _effectiveController,
      expands: widget.expands??false,
      autofocus: widget.autofocus,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      textAlign: widget.textAlign,
      inputFormatters: [
        ChordsTextInputFormatter()
      ],
    );
  }
}

class ChordsTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldVal, TextEditingValue newVal) {

    if (!_isValid(newVal.text)) return oldVal;

    String _new = newVal.text;
    String _old = oldVal.text;

    int selDif;

    if(_new.length > _old.length){

      String pre = _new.substring(0, newVal.selection.start);
      String post = _new.substring(newVal.selection.start);

      int befEditLength = pre.length;
      pre = formatTextAdd(pre, null, post.length==0?null:post.substring(0, 1));
      int aftEditLength = pre.length;

      // ta linijka jest po zliaczniu różnicy długości, bo wtedy kursor zostaje bezpośrednio po literce, którą wpisał
      if((pre.substring(pre.length-1) != ' ' && pre.substring(pre.length-1) != '\n')
          && post.length>0 && post.substring(0, 1) != ' ' && post.substring(0, 1) != '\n')
        pre = pre + ' ';

      post = formatTextAdd(post, pre.substring(pre.length-1), null);

      selDif = aftEditLength - befEditLength;

      return TextEditingValue(
        text: pre + post,
        selection: TextSelection.collapsed(offset: newVal.selection.start + selDif),
      );

    }else if(_old.length > _new.length || (_old.length == _new.length && _old.split('\n').length > _new.split('\n').length)){

      int befEditLength = _new.length;

      String removedString = _old;
      for(int i=0; i<_old.length; i++)
        if(i < _new.length && _old.substring(i, i+1) == _new.substring(i, i+1)) continue;
        else{
          removedString = _old.substring(i, _old.length);
          break;
        }

      for(int i=0; i<removedString.length; i++)
        if(_new.length - i-1 >= 0 &&
            _old.substring(_old.length - i-1, _old.length - i) == _new.substring(_new.length - i-1, _new.length - i)
        ) continue;
        else{removedString = removedString.substring(0, removedString.length - i); break;}

      _new = formatTextRemove(_new, removedString);
      int aftEditLength = _new.length;

      selDif = aftEditLength - befEditLength;

      return TextEditingValue(
        text: _new,
        selection: TextSelection.collapsed(offset: newVal.selection.start + selDif),
      );

    }else
      return oldVal;
  }

  String formatTextAdd(String text, String? charBef, String? charAft){

    // remove double spaces
    if (charAft == ' ') text = text.replaceAll(' ', '');
    else text = text.replaceAll('  ', ' ');

    // Di -> Dis

    text = text.replaceAllMapped(RegExp(r'[CcDdFfGg]i(?=([^s]|$))'),
            (match) => '${match.group(0)}s'
    );

    // Ab -> A b
    text = text.replaceAllMapped(
        RegExp(r'[CcDdEeFfGgAaBbHhs](?=[^i \n0-9])|[0-9+](?=[^ \n\+])'),
            (match) =>
            '${match.group(0)} '
    );

    // remove '\n ' -> '\n'
    if(charBef != null && !RegExp('[CcDdEeFfGgAaBbHhs0-9\+]').hasMatch(charBef))
      text = text.replaceAllMapped(RegExp(r'^ '),
              (match) =>
              ''
      );

    return text;
  }

  String formatTextRemove(String text, String removedText){

    if(removedText == '\n')
      //ab => a b
      text = text.replaceAllMapped(RegExp(r'[CcDdEeFfGgAaBbHhs0-9\+][CcDdEeFfGgAaBbHh]'), (match) {
        return '${match.group(0)![0]} ${match.group(0)![1]}';
      });
    else
      // Gis0+ A -> Gis0+A -> A
      text = text.replaceAllMapped(RegExp(r'[CcDdEeFfGgAaBbHh](?=[^ \ni0-9])|[CcDdEeFfGgAaBbHh][0-9](?=[^ \n\+])|([CcDdFfGg]is)(?=[^ \n0-9])|([CcDdFfGg]is[0-9])(?=[^ \n\+])|[CcDdEeFfGgAaBbHh][0-9]\+(?=[^ \n])|([CcDdFfGg]is[0-9]\+)(?=[^ \n])'), (match) {
        return '';
      });

    // Dis -> Di (remove Di)
    text = text.replaceAllMapped(RegExp(r'[CcDdFfGg]i(?=([^s]|$))'), (match) => '');

    // remove last spaces
    text = text.replaceAllMapped(RegExp(r'( )*[\n]?$'), (match) => '');

    // remove first space
    text = text.replaceAllMapped(RegExp(r'^ '), (match) => '');

    // remove double spaces
    text = text.replaceAll('  ', ' ');

    return text;
  }

  final RegExp _regExp = RegExp(r'^[ ]?(((([CcDdFfGg](is?)?)|[EeAaBbHh\n])(\d\+?)?( |\n+)*)*)$');

  bool _isValid(String value) {
    try {
      final matches = _regExp.allMatches(value);
      for (Match match in matches)
        if (match.start == 0 && match.end == value.length)
          return true;

      return false;
    } catch (e) {
      // Invalid regex
      assert(false, e.toString());
      return true;
    }
  }
}