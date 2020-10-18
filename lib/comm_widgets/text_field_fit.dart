import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldFit extends StatefulWidget {

  final double minWidth;
  final InputDecoration decoration;
  final TextStyle style;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final Locale locale;
  final StrutStyle strutStyle;
  final int minLines;
  final int maxLines;
  final bool expands;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool autofocus;
  final bool enabled;
  final Function(String) onChanged;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;

  const TextFieldFit({this.minWidth: 30, this.decoration, this.style,
  this.textAlign, this.textDirection, this.locale, this.strutStyle, this.minLines,
  this.maxLines, this.expands: false, this.controller, this.focusNode, this.autofocus: false, this.enabled: true, this.onChanged, this.inputFormatters, this.keyboardType});

  @override
  State<StatefulWidget> createState() => TextFieldFitState();
}

class TextFieldFitState extends State<TextFieldFit>{

  // We will use this text style for the TextPainter used to calculate the width
  // and for the TextField so that we calculate the correct size for the text
  // we are actually displaying

  TextEditingController _controller;

  @override
  void initState() {
    if(widget.controller == null)
      _controller = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    TextField textField = TextField(
      style: widget.style,
      decoration: widget.decoration,
      controller: widget.controller?? _controller,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      expands: widget.expands,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      enabled: widget.enabled,
      onChanged: (text) {
        // Tells the framework to redraw the widget
        // The widget will redraw with a new width
        setState(() {});
        if(widget.onChanged != null) widget.onChanged(text);
      },
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
    );

    // Use TextPainter to calculate the width of our text
    TextSpan ts = new TextSpan(style: textField.style, text: textField.controller.text);
    TextPainter tp = new TextPainter(
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