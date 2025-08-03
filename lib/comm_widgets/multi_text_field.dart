import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:implicitly_animated_reorderable_list_2/implicitly_animated_reorderable_list_2.dart';
import 'package:implicitly_animated_reorderable_list_2/transitions.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MultiTextFieldController{

  TextEditingController operator [](int index) => _controllers[index];

  operator []=(int index, String value){
    _controllers[index].text = value;
    for(void Function(int, String) listener in _listeners)
      listener(index, value);
  }

  List<TextEditingController> get controllers => _controllers;

  int get length => _controllers.length;
  String get last => _controllers[length-1].text;
  bool get isEmpty => _controllers.isEmpty || (_controllers.length == 1 && _controllers.first.text.isEmpty);
  bool get isNotEmpty => !isEmpty;
  bool get isLastEmpty => _controllers.isEmpty || _controllers.last.text.isEmpty;

  int minCount;

  late List<TextEditingController> _controllers;

  List<String> get texts => _controllers.map((ctrl) => ctrl.text).toList();
  set texts(List<String> values){
    int i;
    for(i=0; i<values.length; i++)
      if(i < _controllers.length)
        _controllers[i].text = values[i];
      else
        _controllers.add(TextEditingController(text: values[i]));

    while(i<_controllers.length)
      _controllers.removeAt(i);

    while(_controllers.length < minCount)
      _controllers.add(TextEditingController(text: ''));
  }

  late List<void Function(int, String)> _listeners;
  late List<void Function(List<String>)> _anyListeners;

  MultiTextFieldController({List<String>? texts, this.minCount = 1}){
    if(texts == null || texts.length == 0) texts = [''];
    this._controllers = texts.map((text) => TextEditingController(text: text)).toList();
    _listeners = [];
    _anyListeners = [];
  }

  void removeAt(int index){
    _controllers.removeAt(index);
    _callOnChanged(index);
    _callOnAnyChanged();
  }

  void addText(String text){
    _controllers.add(TextEditingController(text: text));
    _callOnChanged(_controllers.length-1);
    _callOnAnyChanged();
  }

  void setText(int index, String text){
    _controllers[index].text = text;
    _callOnChanged(index);
    _callOnAnyChanged();
  }

  void addOnChangedListener(void Function(int, String) listener) => _listeners.add(listener);
  void removeOnChangedListener(void Function(int, String) listener) => _listeners.remove(listener);

  void addOnAnyChangedListener(void Function(List<String>) listener) => _anyListeners.add(listener);
  void removeOnAnyChangedListener(void Function(List<String>) listener) => _anyListeners.remove(listener);

  void _callOnChanged(int index){
    for(void Function(int, String) listener in _listeners)
      listener(index, _controllers[index].text);
  }

  void _callOnAnyChanged(){
    for(void Function(List<String>) listener in _anyListeners)
      listener(texts);
  }

  void dispose(){
    _listeners.clear();
    _anyListeners.clear();
  }

}

enum LayoutMode{
  wrap, column, row
}

class MultiTextField extends StatefulWidget{

  static IconData defAddIcon = MdiIcons.plusCircleOutline;

  final MultiTextFieldController? controller;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final bool expanded;
  final String? hint;
  final LayoutMode layout;
  final Color? accentColor;
  final IconData? addIcon;
  final TextCapitalization textCapitalization;
  final TextAlignVertical? textAlignVertical;

  final void Function(List<String>)? onAnyChanged;
  final void Function(int, String)? onChanged;
  final void Function(int)? onRemoved;
  final bool enabled;

  const MultiTextField({
    this.controller, 
    this.style, 
    this.hintStyle, 
    this.expanded = false, 
    this.hint, 
    this.layout = LayoutMode.row,
    this.accentColor,
    this.addIcon, 
    this.textCapitalization = TextCapitalization.none, 
    this.textAlignVertical, 
    this.onAnyChanged,
    this.onChanged,
    this.onRemoved, 
    this.enabled = true
  });

  @override
  State<StatefulWidget> createState() => MultiTextFieldState();

}

class MultiTextFieldState extends State<MultiTextField>{

  MultiTextFieldController? _controller;
  MultiTextFieldController get controller => widget.controller??_controller!;
  TextStyle? get style => widget.style;
  TextStyle? get hintStyle => widget.hintStyle;

  int get minCount => controller.minCount;
  bool get expanded => widget.expanded;
  String? get hint => widget.hint;
  LayoutMode get linear => widget.layout;
  Color? get accentColor => widget.accentColor;
  IconData? get addIcon => widget.addIcon;
  TextCapitalization get textCapitalization => widget.textCapitalization;
  TextAlignVertical? get textAlignVertical => widget.textAlignVertical;

  void Function(List<String>)? get onAnyChanged => widget.onAnyChanged;
  void Function(int, String)? get onChanged => widget.onChanged;
  void Function(int)? get onRemoved => widget.onRemoved;
  bool get enabled => widget.enabled;

  void _callOnChanged(int index) => onChanged?.call(index, controller[index].text);

  void _callOnAnyChanged() => onAnyChanged?.call(controller.texts);

  @override
  void initState() {
    if(widget.controller == null)
      _controller = MultiTextFieldController();

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    
    List<Widget> children = [];
    for(int i=0; i<controller.length; i++) {
      children.add(_ItemWidget(
        controller: controller[i],
        style: style,
        hintStyle: hintStyle,
        hint: hint,
        textCapitalization: textCapitalization,
        textAlignVertical: textAlignVertical,
        removable: controller.length>minCount,
        onChanged: (text){
          if(i == controller.length-1)
            setState(() {});

          _callOnChanged(i);
          controller._callOnChanged(i);
          _callOnAnyChanged();
          controller._callOnAnyChanged();
        },
        onRemoveTap: () => setState((){
          controller.removeAt(i);
          onRemoved?.call(i);

          _callOnAnyChanged();
          controller._callOnAnyChanged();
        }),
        enabled: enabled,
      ));

      if(i < controller.length-1) {
        if (linear == LayoutMode.row)
          children.add(SizedBox(width: Dimen.defMarg));
        else if (linear == LayoutMode.column)
          children.add(SizedBox(height: Dimen.defMarg));
      }
    }

    Widget addButton = enabled?
    AddButton(
      controller: controller,
      onPressed: () => setState((){
        String text = '';
        controller.addText(text);
        _callOnChanged(controller.length-1);
        controller._callOnChanged(controller.length-1);
        _callOnAnyChanged();
        controller._callOnAnyChanged();
      })
    ):Container();

    switch(linear) {
      case LayoutMode.row:
        return Builder(
          builder: (context) {
            if (!expanded) children.add(addButton);

            Widget scrollView = SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(children: children),
              clipBehavior: Clip.hardEdge,
            );

            if (expanded)
              return Row(
                children: [
                  if(children.length == 1)
                    Expanded(child: children[0])
                  else
                    Expanded(child: scrollView),
                  addButton
                ],
              );
            else
              return scrollView;
          }
        );
      case LayoutMode.wrap:
        return Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          children: children,
          runSpacing: Dimen.defMarg,
          spacing: Dimen.defMarg,
        );
      case LayoutMode.column:
        return ImplicitlyAnimatedList<Widget>(
          physics: BouncingScrollPhysics(),
          items: children,
          areItemsTheSame: (a, b) => a.hashCode == b.hashCode,

          itemBuilder: (context, animation, item, index) => SizeFadeTransition(
            sizeFraction: 0.7,
            curve: Curves.easeInOut,
            animation: animation,
            child: item
          ),

          removeItemBuilder: (context, animation, oldItem) => SizeFadeTransition(
            sizeFraction: 0.7,
            curve: Curves.easeInOut,
            animation: animation,
            child: oldItem,
          ),

          shrinkWrap: true,
        );


        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ...children,
            if(children.isNotEmpty && !expanded) addButton
          ],
        );
    }
  }
}



class _ItemWidget extends StatefulWidget{
  
  final TextEditingController controller;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final String? hint;
  final bool removable;
  final TextCapitalization textCapitalization;
  final TextAlignVertical? textAlignVertical;
  final void Function()? onRemoveTap;
  final void Function(String)? onChanged;
  final bool enabled;

  const _ItemWidget({required this.controller, this.style, this.hintStyle, required this.hint, this.removable = true, this.textCapitalization = TextCapitalization.none,this.textAlignVertical, this.onRemoveTap, this.onChanged, this.enabled = true, Key? key}):super(key: key);

  @override
  State<StatefulWidget> createState() => _ItemWidgetState();

}

class _ItemWidgetState extends State<_ItemWidget>{

  static const double iconSize = 20.0;

  late FocusNode focusNode;

  TextEditingController get controller => widget.controller;
  TextStyle? get style => widget.style;
  TextStyle? get hintStyle => widget.hintStyle;
  String? get hint => widget.hint;
  bool get removable => widget.removable;
  TextCapitalization get textCapitalization => widget.textCapitalization;
  TextAlignVertical? get textAlignVertical => widget.textAlignVertical;
  void Function()? get onRemoveTap => widget.onRemoveTap;
  void Function(String)? get onChanged => widget.onChanged;
  bool get enabled => widget.enabled;

  late bool selected;

  @override
  void initState() {
    focusNode = FocusNode();
    focusNode.addListener(() => setState(() => selected = focusNode.hasFocus));

    selected = false;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) => IntrinsicWidth(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [

          Expanded(child: AnimatedSize(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 10,//40.0,
              ),
              child:
              selected || true?

              IntrinsicWidth(
                child: TextField(
                  focusNode: focusNode,
                  controller: controller,
                  style: style??AppTextStyle(fontSize: Dimen.textSizeBig, fontWeight: weightHalfBold),
                  minLines: 1,
                  maxLines: 1,
                  textCapitalization: textCapitalization,
                  textAlignVertical: textAlignVertical,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: hintStyle??AppTextStyle(
                      color: hintEnab_(context),
                      fontSize: Dimen.textSizeBig,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onChanged: onChanged,
                  readOnly: !enabled,
                ),
              ):

              GestureDetector(
                onTap: (){
                  setState(() => selected = true);
                  focusNode.requestFocus();
                },
                child: Text(
                  controller.text.isEmpty?hint!:controller.text,
                  style: AppTextStyle(
                      fontSize: controller.text.isEmpty?Dimen.textSizeBig:Dimen.textSizeBig,
                      fontWeight: controller.text.isEmpty?weightNormal:weightHalfBold,
                      color: controller.text.isEmpty?hintEnab_(context):textEnab_(context)
                  ),
                ),
              ),
            ),
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOutQuint,
            alignment: Alignment.centerLeft,
            clipBehavior: Clip.none,
          )),

          if(removable && enabled)
            IconButton(
              icon: Icon(MdiIcons.close, size: iconSize),
              onPressed: onRemoveTap,
            )
          else
            SizedBox(width: Dimen.iconFootprint)

        ],
      ),
    ),
  );


  void setEditing(editing) => setState(() => this.selected = editing);

}

class AddButton extends StatelessWidget{

  final MultiTextFieldController controller;
  final IconData? addIcon;
  final void Function()? onPressed;

  const AddButton({
    required this.controller,
    this.addIcon,
    this.onPressed,
    super.key
  });


  @override
  Widget build(BuildContext context){
    return IconButton(
      icon: Icon(
        addIcon??MultiTextField.defAddIcon,
        color:
        controller.isNotEmpty && controller.last.isEmpty?
        iconDisab_(context):
        iconEnab_(context),
      ),
      onPressed:
      controller.isNotEmpty && controller.last.isEmpty?
      null:
      onPressed
    );
  }

}