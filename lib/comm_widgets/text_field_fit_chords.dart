import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/text_field_chords.dart';

class TextFieldFitChords extends StatefulWidget {

  final double minWidth;
  final InputDecoration? decoration;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final int? minLines;
  final int? maxLines;
  final FocusNode? focusNode;
  final bool expands;
  final TextEditingController? controller;
  final bool autofocus;
  final bool enabled;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;

  const TextFieldFitChords({this.minWidth: 30, this.decoration, this.style, this.textAlign, this.textDirection, this.locale, this.strutStyle, this.minLines, this.maxLines, this.focusNode, this.expands: false, this.controller, this.autofocus: false, this.enabled: true, this.onChanged, this.keyboardType});

  @override
  State<StatefulWidget> createState() => TextFieldFitChordsState();
}

class TextFieldFitChordsState extends State<TextFieldFitChords>{

  // We will use this text style for the TextPainter used to calculate the width
  // and for the TextField so that we calculate the correct size for the text
  // we are actually displaying
  //TextStyle textStyle = TextStyle(color: Colors.grey[600]);

  TextEditingController? _controller;

  @override
  void initState() {
    if(widget.controller == null)
      _controller = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    TextFieldChords textField = TextFieldChords(
      textStyle: widget.style,
      decoration: widget.decoration,
      controller: widget.controller??_controller,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      focusNode: widget.focusNode,
      expands: widget.expands,
      autofocus: widget.autofocus,
      onChanged: (String text){
        setState(() {});
        if(widget.onChanged != null) widget.onChanged!(text);
      },
      enabled: widget.enabled,
    );

    // Use TextPainter to calculate the width of our text
    TextSpan ts = TextSpan(style: textField.textStyle, text: textField.controller!.text);
    TextPainter tp = TextPainter(
      text: ts,
      textAlign: widget.textAlign ?? TextAlign.left,
      textDirection: widget.textDirection ?? TextDirection.ltr,
      textScaleFactor: 1,
      locale: widget.locale,
      strutStyle: widget.strutStyle,
    );

    tp.layout();
    var textWidth = tp.width + 4; // We will use this width for the container wrapping our TextField

    // Enforce a minimum width
    if ( textWidth < widget.minWidth ) {
      textWidth = widget.minWidth;
    }

    return Container(
      width: textWidth,
      child: textField
    );
  }
}