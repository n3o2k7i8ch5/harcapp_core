import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';

import '../comm_classes/color_pack.dart';
import '../dimen.dart';
import 'multi_text_field.dart';

class AppTextFieldHint extends StatefulWidget{

  final String hint;
  final String hintTop;
  final TextEditingController controller;
  final TextStyle style;
  final TextStyle hintStyle;
  final TextStyle counterStyle;
  final int maxLength;
  final int maxLines;
  final bool showUnderline;
  final Function(List<String>) onChanged;
  final bool obscureText;
  final bool enabled;
  final Widget leading;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final Color accentColor;

  final bool multi;
  final String multiHintTop;
  final List<String> initVals;

  const AppTextFieldHint({
    @required this.hint,
    this.hintTop,
    this.controller,
    this.style,
    this.hintStyle,
    this.counterStyle,
    this.maxLength,
    this.maxLines: 1,
    this.showUnderline:false,
    this.onChanged,
    this.obscureText: false,
    this.enabled,
    this.leading,
    this.keyboardType,
    this.inputFormatters,
    this.accentColor,
    this.multi: false,
    this.multiHintTop,
    this.initVals,
    Key key
  }):super(key: key);

  @override
  State<StatefulWidget> createState() => AppTextFieldHintState();

}

class AppTextFieldHintState extends State<AppTextFieldHint>{

  TextEditingController controller;

  List<String> texts;

  TextStyle hintStyle;

  String get hint => widget.hint;
  String get hintTop => widget.hintTop??hint;
  String get multiHintTop => widget.multiHintTop??hintTop;

  List<String> get initVals => widget.initVals;

  @override
  void initState() {
    super.initState();

    texts = initVals == null || initVals.length == 0?['']:initVals;

    controller = widget.controller??TextEditingController(text: initVals==null || initVals.isEmpty?'':initVals[0]);
    hintStyle = widget.hintStyle??widget.style;
  }

  @override
  Widget build(BuildContext context) {

    Widget textField;

    if(texts.length == 1)
      textField = TextField(
        style: widget.style,
        controller: controller,
        onChanged: (text){
          //if((text.length==0) != (oldText.length==0))
          texts[0] = text;
          setState(() {});
          widget.onChanged?.call([text]);
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
    else
      textField = MultiTextField(
        initVals: texts,
        hint: hint,
        onChanged: (texts){
          this.texts = texts;
          widget.onChanged?.call(texts);
          if(texts.length == 1) {
            controller.text = texts[0];
            setState(() {});
          }
        },
      );

    return Material( // to jest po to, żeby hero tag nie rzucał błędów.
      color: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[

          Row(
            children: <Widget>[
              if(widget.leading!=null) widget.leading,
              Expanded(child: textField),

              if(widget.multi && texts.length==1)
                IconButton(
                    icon: Icon(
                      MultiTextField.addIcon,
                      color: texts[0].isEmpty?iconDisab_(context):iconEnab_(context),
                    ),
                    onPressed: texts[0].isEmpty?null:() => setState((){
                      texts.add('');
                      widget.onChanged?.call(texts);
                    })
                )
            ],
          ),

          AnimatedOpacity(
            child: Text(
              texts.length > 0?multiHintTop:hintTop,
              style: AppTextStyle(fontSize: Dimen.TEXT_SIZE_SMALL, fontWeight: weight.halfBold, color: hintEnab_(context)),
            ),
            duration: Duration(milliseconds: 300),
            opacity: controller.text.length==0?0:1,
          ),

        ],
      ),
    );
  }

}