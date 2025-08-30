import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';

import '../comm_classes/color_pack.dart';
import '../values/dimen.dart';
import 'multi_text_field.dart';

class AppTextFieldHint extends StatefulWidget{

  static const double topHintFontSize = Dimen.textSizeSmall;
  static const FontWeight topHintFontWeight = weightHalfBold;
  static topHintColor(BuildContext context) => hintEnab_(context);

  final String hint;
  final String? hintTop;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? counterStyle;
  final int? maxLength;
  final int? maxLines;
  final bool showUnderline;
  final Function(List<String>)? onAnyChanged;
  final Function(int, String)? onChanged;
  final bool obscureText;
  final bool enabled;
  final Widget? leading;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsets? contentPadding;

  final bool multi;
  final bool multiAllowZeroFields;
  final LayoutMode multiLayout;
  final Widget Function(int index, Key key, Widget item)? multiItemBuilder;
  final Widget Function(bool tappable, void Function() onTap)? multiAddButtonBuilder;
  final String? multiHintTop;
  final bool multiExpanded;
  final bool multiIsCollapsed;
  final MultiTextFieldController? multiController;
  final TextCapitalization textCapitalization;
  final TextAlignVertical? textAlignVertical;
  final bool autofocus;

  const AppTextFieldHint({
    required this.hint,
    this.hintTop,
    this.controller,
    this.focusNode,
    this.style,
    this.hintStyle,
    this.counterStyle,
    this.maxLength,
    this.maxLines = 1,
    this.showUnderline =false,
    this.onAnyChanged,
    this.onChanged,
    this.obscureText = false,
    this.enabled = true,
    this.leading,
    this.keyboardType,
    this.inputFormatters,
    this.contentPadding,
    this.multi = false,
    this.multiAllowZeroFields = false,
    this.multiLayout = LayoutMode.row,
    this.multiItemBuilder,
    this.multiAddButtonBuilder,
    this.multiHintTop,
    this.multiExpanded = false,
    this.multiIsCollapsed = false,
    this.multiController,
    this.textCapitalization = TextCapitalization.none,
    this.textAlignVertical,
    this.autofocus = false,
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

  String get hint => widget.hint;
  String get hintTop => widget.hintTop??(hint.endsWith(':')?hint.substring(0, hint.length-1):hint);
  bool get multi => widget.multi;
  String get multiHintTop => widget.multiHintTop??hintTop;
  bool get multiExpanded => widget.multiExpanded;

  TextStyle get style => widget.style??AppTextStyle(color: textEnab_(context));
  TextStyle get hintStyle => widget.hintStyle??widget.style?.copyWith(color: hintEnab_(context))??AppTextStyle(color: hintEnab_(context));

  void onChangedListener(int index, String text) {
    widget.onChanged?.call(index, text);
  }

  void onAnyChangedListener(List<String> texts) {
    setState(() {});
    widget.onAnyChanged?.call(texts);
  }

  @override
  void initState() {
    super.initState();

    if(widget.multiController == null)
      _multiController = MultiTextFieldController(texts: ['']);

    if(widget.controller == null)
      _controller = TextEditingController(text: '');

  }

  @override
  Widget build(BuildContext context) {

    Widget textField;

    if(multi)
      textField = MultiTextField(
        allowZeroFields: widget.multiAllowZeroFields,
        controller: multiController,
        expanded: multiExpanded,
        hint: hint,
        style: style,
        hintStyle: hintStyle,
        layout: widget.multiLayout,
        textCapitalization: widget.textCapitalization,
        textAlignVertical: widget.textAlignVertical,

        itemBuilder: widget.multiItemBuilder,
        addButtonBuilder: widget.multiAddButtonBuilder,
        onAnyChanged: onAnyChangedListener,
        onChanged: onChangedListener,
        enabled: widget.enabled,
        isCollapsed: widget.multiIsCollapsed,
      );
    else
      textField = TextField(
        scrollPhysics: BouncingScrollPhysics(),
        style: style,
        controller: controller,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        onChanged: (text){
          setState(() {});

          onChangedListener(0, text);
          onAnyChangedListener([text]);
        },
        decoration: InputDecoration(
          counterStyle: widget.counterStyle??AppTextStyle(color: hintEnab_(context)),
          hintText: hint,
          hintStyle: hintStyle,
          border: widget.showUnderline?null:InputBorder.none,
          contentPadding: widget.contentPadding,
          isCollapsed: true
        ),
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        obscureText: widget.obscureText,
        readOnly: !widget.enabled,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        textCapitalization: widget.textCapitalization,
        textAlignVertical: widget.textAlignVertical,

      );

    return Row(
      children: <Widget>[
        if(widget.leading!=null) widget.leading!,
        Expanded(child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[

            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: textField,
            ),

            AnimatedOpacity(
              child: Text(
                multiController!.length==1?hintTop:multiHintTop,
                style: AppTextStyle(
                  fontSize: AppTextFieldHint.topHintFontSize,
                  fontWeight: AppTextFieldHint.topHintFontWeight,
                  color: AppTextFieldHint.topHintColor(context)
                ),
              ),
              duration: Duration(milliseconds: 300),
              opacity:
              (multi && multiController!.isEmpty) || (!multi && controller.text.isEmpty)?0:1,
            ),

          ],
        )),
      ],
    );

  }

}