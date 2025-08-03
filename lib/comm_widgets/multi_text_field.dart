import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/values/dimen.dart';
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

  final bool allowZeroFields;
  final MultiTextFieldController? controller;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final bool expanded;
  final String? hint;
  final LayoutMode layout;
  final TextCapitalization textCapitalization;
  final TextAlignVertical? textAlignVertical;

  final Widget Function(int)? verticalSeparatorBuilder;
  final Widget Function(int)? horizontalSeparatorBuilder;
  final Widget Function(int, Key, Widget)? itemBuilder;
  final Widget Function(bool tappable, void Function() onTap)? addButtonBuilder;
  final Key Function(int)? valueKeyBuilder;

  final void Function(List<String>)? onAnyChanged;
  final void Function(int, String)? onChanged;
  final void Function(int)? onRemoved;
  final bool enabled;
  final bool isCollapsed;

  const MultiTextField({
    this.allowZeroFields = false,
    this.controller, 
    this.style, 
    this.hintStyle, 
    this.expanded = false, 
    this.hint, 
    this.layout = LayoutMode.row,
    this.textCapitalization = TextCapitalization.none, 
    this.textAlignVertical,
    
    this.verticalSeparatorBuilder,
    this.horizontalSeparatorBuilder,
    this.itemBuilder,
    this.addButtonBuilder,
    this.valueKeyBuilder,
    
    this.onAnyChanged,
    this.onChanged,
    this.onRemoved, 
    this.enabled = true,
    this.isCollapsed = false,
    super.key
  });

  @override
  State<StatefulWidget> createState() => MultiTextFieldState();

}

class MultiTextFieldState extends State<MultiTextField>{

  bool get allowZeroFields => widget.allowZeroFields;
  MultiTextFieldController? _controller;
  MultiTextFieldController get controller => widget.controller??_controller!;
  TextStyle? get style => widget.style;
  TextStyle? get hintStyle => widget.hintStyle;

  int get minCount => controller.minCount;
  bool get expanded => widget.expanded;
  String? get hint => widget.hint;
  LayoutMode get linear => widget.layout;
  TextCapitalization get textCapitalization => widget.textCapitalization;
  TextAlignVertical? get textAlignVertical => widget.textAlignVertical;

  Widget Function(int)? get verticalSeparatorBuilder => widget.verticalSeparatorBuilder;
  Widget Function(int)? get horizontalSeparatorBuilder => widget.horizontalSeparatorBuilder;
  Widget Function(int, Key, Widget)? get itemBuilder => widget.itemBuilder;
  Widget Function(bool tappable, void Function() onTap)? get addButtonBuilder => widget.addButtonBuilder;
  Key Function(int)? get valueKeyBuilder => widget.valueKeyBuilder;

  void Function(List<String>)? get onAnyChanged => widget.onAnyChanged;
  void Function(int, String)? get onChanged => widget.onChanged;
  void Function(int)? get onRemoved => widget.onRemoved;
  bool get enabled => widget.enabled;
  bool get isCollapsed => widget.isCollapsed;

  void _callOnChanged(int index) => onChanged?.call(index, controller[index].text);

  void _callOnAnyChanged() => onAnyChanged?.call(controller.texts);

  @override
  void initState() {
    if(widget.controller == null)
      _controller = MultiTextFieldController();

    super.initState();
  }

  Widget buildSeparator(int index){
    if(linear == LayoutMode.row)
      return horizontalSeparatorBuilder?.call(index)??SizedBox(width: Dimen.defMarg);
    else if(linear == LayoutMode.column)
      return verticalSeparatorBuilder?.call(index)??Container();
    else
      return Container();
  }

  Key buildValueKey(int index) => valueKeyBuilder?.call(index)??ValueKey('MultiTextField ${index}');

  Widget buildItemWidget(int index, Widget child){
    if(itemBuilder != null)
      return itemBuilder!.call(index, buildValueKey(index), child);
    else
      return child;
  }
  
  @override
  Widget build(BuildContext context) {
    
    List<Widget> children = [];
    for(int i=0; i<controller.length; i++) {
      children.add(
          buildItemWidget(
            i,
            _ItemWidget(
              key: buildValueKey(i),
              controller: controller[i],
              style: style,
              hintStyle: hintStyle,
              hint: hint,
              textCapitalization: textCapitalization,
              textAlignVertical: textAlignVertical,
              removable: controller.length>minCount,
              isCollapsed: isCollapsed,
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
            )
          )
      );

      if(i < controller.length-1) children.add(buildSeparator(i));
    }

    Widget addButton = enabled?
    AddButton(
      allowZeroFields: allowZeroFields,
      controller: controller,
      addButtonBuilder: addButtonBuilder,
      onPressed: onAddButtonTap
    )
    :Container();

    switch(linear) {
      case LayoutMode.row:
        return Builder(
          builder: (context) {
            if(!expanded) children.add(addButton);

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
          children: [...children, addButton],
          runSpacing: Dimen.defMarg,
          spacing: Dimen.defMarg,
        );
      case LayoutMode.column:
        List<Widget> items = [...children, addButton];
        return AnimatedListView<Widget>(
          physics: BouncingScrollPhysics(),
          items: items,
          isSameItem: (a, b) => a.hashCode == b.hashCode,

          itemBuilder: (context, index) => items[index],

          shrinkWrap: true,
          insertDuration: Duration(milliseconds: 300),
          removeDuration: Duration(milliseconds: 300),
        );

    }
  }

  void onAddButtonTap() => setState((){
    String text = '';
    controller.addText(text);
    _callOnChanged(controller.length-1);
    controller._callOnChanged(controller.length-1);
    _callOnAnyChanged();
    controller._callOnAnyChanged();
  });

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
  final bool isCollapsed;

  const _ItemWidget({
    required this.controller,
    this.style,
    this.hintStyle,
    required this.hint,
    this.removable = true,
    this.textCapitalization = TextCapitalization.none,
    this.textAlignVertical, this.onRemoveTap,
    this.onChanged,
    this.enabled = true,
    this.isCollapsed = false,
    super.key
  });

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
  bool get isCollapsed => widget.isCollapsed;

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
                    isCollapsed: isCollapsed,
                  ),
                  onChanged: onChanged,
                  readOnly: !enabled,
                ),
              )
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

  void setEditing(value) => setState(() => this.selected = value);

}

class AddButton extends StatefulWidget{

  final bool allowZeroFields;
  final MultiTextFieldController controller;
  final Widget Function(bool tappable, void Function() onTap)? addButtonBuilder;
  final void Function() onPressed;

  const AddButton({
    required this.allowZeroFields,
    required this.controller,
    this.addButtonBuilder,
    required this.onPressed,
    super.key
  });

  @override
  State<StatefulWidget> createState() => AddButtonState();

}

class AddButtonState extends State<AddButton>{

  bool get allowZeroFields => widget.allowZeroFields;
  MultiTextFieldController get controller => widget.controller;
  Widget Function(bool tappable, void Function() onTap)? get addButtonBuilder => widget.addButtonBuilder;
  void Function() get onPressed => widget.onPressed;

  bool get tappable => allowZeroFields?
  (controller.length==0 || controller.last.isNotEmpty):
  (controller.isEmpty || controller.last.isNotEmpty);

  @override
  Widget build(BuildContext context){
    if(addButtonBuilder == null) return default_(context);
    return addButtonBuilder!.call(tappable, onPressed);
  }

  void _listener(_) => setState(() {});

  void initState() {
    super.initState();
    controller.addOnAnyChangedListener(_listener);
  }

  @override
  void dispose() {
    controller.removeOnAnyChangedListener(_listener);
    super.dispose();
  }

  Widget default_(BuildContext context) => IconButton(
      icon: Icon(
        MdiIcons.plusCircleOutline,
        color:
        tappable?
        iconEnab_(context):
        iconDisab_(context),
      ),
      onPressed:
      tappable?
      onPressed:
      null
  );

}