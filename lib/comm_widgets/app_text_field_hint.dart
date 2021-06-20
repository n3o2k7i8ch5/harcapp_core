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
  //final List<String> initVals;
  final MultiAppTextFieldHintController multiController;

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
    this.multiController,
    //this.initVals,
    Key key
  }):super(key: key);

  @override
  State<StatefulWidget> createState() => AppTextFieldHintState();

}

class AppTextFieldHintState extends State<AppTextFieldHint>{

  TextEditingController controller;

  MultiAppTextFieldHintController _multiController;

  MultiAppTextFieldHintController get multiController => widget.multiController??_multiController;

  TextStyle hintStyle;

  String get hint => widget.hint;
  String get hintTop => widget.hintTop??hint;
  String get multiHintTop => widget.multiHintTop??hintTop;

  //List<String> get initVals => widget.initVals;

  List<String> get texts => multiController.texts;
  set texts(List<String> values) => multiController.texts = values;

  @override
  void initState() {
    super.initState();

    if(multiController == null)
      _multiController = MultiAppTextFieldHintController();
    //texts = initVals == null || initVals.length == 0?['']:initVals;

    controller = widget.controller??TextEditingController(text: texts==null || texts.isEmpty?'':texts[0]);
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

    return Stack(
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
            texts.length==1?hintTop:multiHintTop,
            style: AppTextStyle(fontSize: Dimen.TEXT_SIZE_SMALL, fontWeight: weight.halfBold, color: hintEnab_(context)),
          ),
          duration: Duration(milliseconds: 300),
          opacity: controller.text.length==0?0:1,
        ),

      ],
    );
  }

}

class MultiAppTextFieldHintController{

  //AppTextFieldHintState _state;

  //void init(AppTextFieldHintState state) => _state = state;

  List<String> texts;

  MultiAppTextFieldHintController({List<String> texts}){
      this.texts = texts??[''];
  }

}