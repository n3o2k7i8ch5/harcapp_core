import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';

import '../comm_classes/color_pack.dart';
import '../dimen.dart';
import 'multi_text_field.dart';

class AppTextFieldHint extends StatefulWidget{

  final String hint;
  final String? hintTop;
  final TextEditingController? controller;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? counterStyle;
  final int? maxLength;
  final int maxLines;
  final bool showUnderline;
  final Function(List<String>)? onAnyChanged;
  final Function(int, String)? onChanged;
  final bool obscureText;
  final bool? enabled;
  final Widget? leading;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Color? accentColor;

  final bool multi;
  final String? multiHintTop;
  //final List<String> initVals;
  final bool multiExpanded;
  final MultiTextFieldController? multiController;

  const AppTextFieldHint({
    required this.hint,
    this.hintTop,
    this.controller,
    this.style,
    this.hintStyle,
    this.counterStyle,
    this.maxLength,
    this.maxLines: 1,
    this.showUnderline:false,
    this.onAnyChanged,
    this.onChanged,
    this.obscureText: false,
    this.enabled,
    this.leading,
    this.keyboardType,
    this.inputFormatters,
    this.accentColor,
    this.multi: false,
    this.multiHintTop,
    this.multiExpanded: false,
    this.multiController,
    Key? key
  }):super(key: key);

  @override
  State<StatefulWidget> createState() => AppTextFieldHintState();

}

class AppTextFieldHintState extends State<AppTextFieldHint>{

  late TextEditingController _controller;
  TextEditingController get controller => widget.controller??_controller;

  MultiTextFieldController? _multiController;
  MultiTextFieldController? get multiController => widget.multiController??_multiController;

  TextStyle? hintStyle;

  String get hint => widget.hint;
  String get hintTop => widget.hintTop??hint;
  bool get multi => widget.multi;
  String get multiHintTop => widget.multiHintTop??hintTop;
  bool get multiExpanded => widget.multiExpanded;

  void onChangedListener(int index, String text) {
    widget.onChanged?.call(index, text);
  }

  void onAnyChangedListener(List<String> texts) {
    widget.onAnyChanged?.call(texts);
  }

  @override
  void initState() {
    super.initState();

    if(widget.multiController == null)
      _multiController = MultiTextFieldController(texts: ['']);

    if(widget.controller == null)
      _controller = TextEditingController(text: '');

    hintStyle = widget.hintStyle??widget.style;
  }

  /*
  @override
  void dispose() {
    super.dispose();

    if(multi)
      multiController.removeOnChangedListener(onChangedListener);

    if(multi)
      multiController.removeOnAnyChangedListener(onAnyChangedListener);

  }
*/

  @override
  Widget build(BuildContext context) {

    Widget textField;

    if(multi)
      textField = MultiTextField(
        controller: multiController,
        expanded: multiExpanded,
        hint: hint,
        onAnyChanged: onAnyChangedListener,
        onChanged: onChangedListener,
        onRemoved: (){
          //if(multiController!.length==1)
            //setState(() {});
        },
      );
    else
      textField = TextField(
        style: widget.style,
        controller: controller,
        onChanged: (text){
          if(controller.text.length<=1)
            setState(() {});

          onChangedListener(0, text);
          onAnyChangedListener([text]);
        },
        decoration: InputDecoration(
          counterStyle: widget.counterStyle??TextStyle(color: hintEnab_(context)),
          hintText: hint,
          hintStyle: hintStyle,
          border: widget.showUnderline?null:InputBorder.none,
        ),
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        obscureText: widget.obscureText,
        enabled: widget.enabled,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
      );

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[

        Row(
          children: <Widget>[
            if(widget.leading!=null) widget.leading!,
            Expanded(child: textField),
          ],
        ),

        AnimatedOpacity(
          child: Text(
            multiController!.length==1?hintTop:multiHintTop,
            style: AppTextStyle(fontSize: Dimen.TEXT_SIZE_SMALL, fontWeight: weight.halfBold, color: hintEnab_(context)),
          ),
          duration: Duration(milliseconds: 300),
          opacity:
          (multi && (multiController!.isEmpty || multiController![0].text.isEmpty))
              || (!multi && controller.text.isEmpty)?0:1,
        ),

      ],
    );
  }

}