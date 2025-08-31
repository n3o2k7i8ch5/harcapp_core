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
  final EdgeInsets? multiPadding;
  final void Function()? multiOnAdded;
  final void Function(int index)? multiOnRemoved;

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
    this.multiPadding,
    this.multiOnAdded,
    this.multiOnRemoved,
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
  // bool get multi => widget.multi;
  String get multiHintTop => widget.multiHintTop??hintTop;
  // bool get multiExpanded => widget.multiExpanded;

  TextStyle get style => widget.style??AppTextStyle(color: textEnab_(context));
  TextStyle get hintStyle => widget.hintStyle??widget.style?.copyWith(color: hintEnab_(context))??AppTextStyle(color: hintEnab_(context));

  void onChangedListener(int index, String text) {
    widget.onChanged?.call(index, text);
  }

  void onAnyChangedListener(List<String> texts) {
    showTopHintNotifier.value = topHintVisible;
    widget.onAnyChanged?.call(texts);
  }

  late ValueNotifier<bool> showTopHintNotifier;

  bool get topHintVisible{
    if(widget.multi)
      return multiController!.isNotEmpty;
    else
      return controller.text.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();

    if(widget.multiController == null)
      _multiController = MultiTextFieldController(texts: ['']);

    if(widget.controller == null)
      _controller = TextEditingController(text: '');

    showTopHintNotifier = ValueNotifier(topHintVisible);

  }

  @override
  void dispose() {
    showTopHintNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Widget textField;

    if(widget.multi)
      textField = MultiTextField(
        allowZeroFields: widget.multiAllowZeroFields,
        controller: multiController,
        expanded: widget.multiExpanded,
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
        onAdded: (){
          setState((){});
          widget.multiOnAdded?.call();
        },
        onRemoved: (int index){
          setState((){});
          widget.multiOnRemoved?.call(index);
        },
        enabled: widget.enabled,
        contentPadding: widget.contentPadding,
        isCollapsed: true, // widget.multiIsCollapsed,
        padding: widget.multiPadding,
      );
    else
      textField = BaseTextFieldHint(
        style: style,
        controller: controller,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        onChanged: (text){
          showTopHintNotifier.value = topHintVisible;

          onChangedListener(0, text);
          onAnyChangedListener([text]);
        },
        counterStyle: widget.counterStyle,
        hint: hint,
        hintStyle: hintStyle,
        contentPadding: widget.contentPadding,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        textCapitalization: widget.textCapitalization,
        textAlignVertical: widget.textAlignVertical,
      );

    return Row(
      children: <Widget>[
        if(widget.leading!=null) widget.leading!,
        Expanded(
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[

              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: textField,
              ),

              Padding(
                padding: EdgeInsets.only(
                  left: widget.multi?
                  (widget.multiPadding?.left??0):
                  (widget.contentPadding?.left??0),
                  right: widget.multi?
                  (widget.multiPadding?.right??0):
                  (widget.contentPadding?.right??0),
                ),
                child: ValueListenableBuilder<bool>(
                  valueListenable: showTopHintNotifier,
                  builder: (_, visible, _) => AnimatedOpacity(
                    child: Text(
                      multiController!.length==1?hintTop:multiHintTop,
                      style: AppTextStyle(
                          fontSize: AppTextFieldHint.topHintFontSize,
                          fontWeight: AppTextFieldHint.topHintFontWeight,
                          color: AppTextFieldHint.topHintColor(context)
                      ),
                    ),
                    duration: Duration(milliseconds: 300),
                    opacity:visible?1:0,
                  )
                ),
              ),

            ],
          )
        ),
      ],
    );

  }

}

class BaseTextFieldHint extends StatelessWidget {

  final String? hint;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? counterStyle;
  final int? maxLength;
  final int? maxLines;
  final bool showUnderline;
  final Function(String)? onChanged;
  final bool obscureText;
  final bool enabled;
  final Widget? leading;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final TextCapitalization textCapitalization;
  final TextAlignVertical? textAlignVertical;
  final bool autofocus;

  const BaseTextFieldHint({
    required this.hint,
    required this.controller,
    this.focusNode,
    this.style,
    this.hintStyle,
    this.counterStyle,
    this.maxLength,
    this.maxLines = 1,
    this.showUnderline = false,
    this.onChanged,
    this.obscureText = false,
    this.enabled = true,
    this.leading,
    this.keyboardType,
    this.inputFormatters,
    this.contentPadding,
    this.textCapitalization = TextCapitalization.none,
    this.textAlignVertical,
    this.autofocus = false,
    Key? key
  }) :super(key: key);

  @override
  Widget build(BuildContext context) => TextField(
    scrollPhysics: BouncingScrollPhysics(),
    style: style,
    controller: controller,
    focusNode: focusNode,
    autofocus: autofocus,
    onChanged: onChanged,
    decoration: InputDecoration(
        counterStyle: counterStyle ?? AppTextStyle(color: hintEnab_(context)),
        hintText: hint,
        hintStyle: hintStyle,
        border: showUnderline ? null : InputBorder.none,
        contentPadding: contentPadding,
        isCollapsed: true
    ),
    maxLength: maxLength,
    maxLines: maxLines,
    obscureText: obscureText,
    readOnly: !enabled,
    keyboardType: keyboardType,
    inputFormatters: inputFormatters,
    textCapitalization: textCapitalization,
    textAlignVertical: textAlignVertical,

  );
}