import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MultiTextFieldController{

  TextEditingController operator [](int index) => _ctrls[index];
  operator []=(int index, String value){
    _ctrls[index].text = value;
    for(void Function(int, String) listener in _listeners)
      listener(index, value);
  }
  int get length => _ctrls.length;
  String get last => _ctrls[length-1].text;
  bool get isEmpty => _ctrls.isEmpty;
  bool get isNotEmpty => _ctrls.isNotEmpty;

  int minCount;

  late List<TextEditingController> _ctrls;

  List<String> get texts => _ctrls.map((ctrl) => ctrl.text).toList();
  set texts(List<String> values){
    int i;
    for(i=0; i<values.length; i++)
      if(i < _ctrls.length)
        _ctrls[i].text = values[i];
      else
        _ctrls.add(TextEditingController(text: values[i]));

    while(i<_ctrls.length)
      _ctrls.removeAt(i);

    while(_ctrls.length < minCount)
      _ctrls.add(TextEditingController(text: ''));

  }


  late List<void Function(int, String)> _listeners;
  late List<void Function(List<String>)> _anyListeners;

  MultiTextFieldController({List<String>? texts, this.minCount = 1}){
    if(texts == null || texts.length == 0)
      texts = [''];
    this._ctrls = texts.map((text) => TextEditingController(text: text)).toList();
    _listeners = [];
    _anyListeners = [];
  }

  removeAt(int index){
    _ctrls.removeAt(index);
    _callOnChanged(index);
    _callOnAnyChanged();
  }

  addText(String text){
    _ctrls.add(TextEditingController(text: text));
    _callOnChanged(_ctrls.length-1);
    _callOnAnyChanged();
  }

  setText(int index, String text){
    _ctrls[index].text = text;
    _callOnChanged(index);
    _callOnAnyChanged();
  }

  void addOnChangedListener(void Function(int, String) listener) => _listeners.add(listener);
  void removeOnChangedListener(void Function(int, String) listener) => _listeners.remove(listener);

  void addOnAnyChangedListener(void Function(List<String>) listener) => _anyListeners.add(listener);
  void removeOnAnyChangedListener(void Function(List<String>) listener) => _anyListeners.remove(listener);

  void _callOnChanged(int index){
    for(void Function(int, String) listener in _listeners)
      listener(index, _ctrls[index].text);
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

class MultiTextField extends StatefulWidget{

  static const IconData defAddIcon = MdiIcons.plusCircleOutline;

  final MultiTextFieldController? controller;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final bool expanded;
  final String? hint;
  final bool linear;
  final Color? accentColor;
  final IconData? addIcon;
  final TextCapitalization textCapitalization;
  final TextAlignVertical? textAlignVertical;

  final void Function(List<String>)? onAnyChanged;
  final void Function(int, String)? onChanged;
  final void Function(int)? onRemoved;

  const MultiTextField({this.controller, this.style, this.hintStyle, this.expanded = false, this.hint, this.linear = true, this.accentColor, this.addIcon, this.textCapitalization = TextCapitalization.none, this.textAlignVertical, this.onAnyChanged, this.onChanged, this.onRemoved});

  @override
  State<StatefulWidget> createState() => MultiTextFieldState();

}

class MultiTextFieldState extends State<MultiTextField>{

  MultiTextFieldController? _controller;
  MultiTextFieldController? get controller => widget.controller??_controller;
  TextStyle? get style => widget.style;
  TextStyle? get hintStyle => widget.hintStyle;

  int get minCount => controller!.minCount;
  bool get expanded => widget.expanded;
  String? get hint => widget.hint;
  bool get linear => widget.linear;
  Color? get accentColor => widget.accentColor;
  IconData? get addIcon => widget.addIcon;
  TextCapitalization get textCapitalization => widget.textCapitalization;
  TextAlignVertical? get textAlignVertical => widget.textAlignVertical;

  void Function(List<String>)? get onAnyChanged => widget.onAnyChanged;
  void Function(int, String)? get onChanged => widget.onChanged;
  void Function(int)? get onRemoved => widget.onRemoved;

  void _callOnChanged(int index) => onChanged!(index, controller![index].text);

  void _callOnAnyChanged() => onAnyChanged!(controller!.texts);

  @override
  void initState() {
    if(widget.controller == null)
      _controller = MultiTextFieldController();

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    
    List<Widget> children = [];
    for(int i=0; i<controller!.length; i++) {
      children.add(Item(
        controller: controller![i],
        style: style,
        hintStyle: hintStyle,
        hint: hint,
        textCapitalization: textCapitalization,
        textAlignVertical: textAlignVertical,
        removable: controller!.length>minCount,
        onChanged: (text){
          if(i == controller!.length-1)
            setState(() {});

          _callOnChanged(i);
          controller!._callOnChanged(i);
          _callOnAnyChanged();
          controller!._callOnAnyChanged();
        },
        onRemoveTap: () => setState((){
          controller!.removeAt(i);
          onRemoved?.call(i);

          _callOnAnyChanged();
          controller!._callOnAnyChanged();
        }),
      ));

      if(linear && i < controller!.length-1)
        children.add(SizedBox(width: Dimen.defMarg));
    }

    Widget addButton = IconButton(
      icon: Icon(
        addIcon??MultiTextField.defAddIcon,
        color:
        controller!.isNotEmpty && controller!.last.isEmpty?
        iconDisab_(context):
        accentColor,
      ),
      onPressed:
      controller!.isNotEmpty && controller!.last.isEmpty?
      null:
          () => setState((){
        String text = '';
        controller!.addText(text);
        _callOnChanged(controller!.length-1);
        controller!._callOnChanged(controller!.length-1);
        _callOnAnyChanged();
        controller!._callOnAnyChanged();
      }),
    );

    if(linear)
      return Builder(builder: (context){
        if(!expanded)
          children.add(addButton);

        Widget scrollView = SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(children: children),
          clipBehavior: Clip.hardEdge,
        );

        if(expanded)
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
      });
    else
      return Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        children: children,
        runSpacing: Dimen.defMarg,
        spacing: Dimen.defMarg,
      );
  }
}



class Item extends StatefulWidget{
  
  final TextEditingController controller;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final String? hint;
  final bool removable;
  final TextCapitalization textCapitalization;
  final TextAlignVertical? textAlignVertical;
  final void Function()? onRemoveTap;
  final void Function(String)? onChanged;

  const Item({required this.controller, this.style, this.hintStyle, required this.hint, this.removable = true, this.textCapitalization = TextCapitalization.none,this.textAlignVertical, this.onRemoveTap, this.onChanged, Key? key}):super(key: key);

  @override
  State<StatefulWidget> createState() => ItemState();

}

class ItemState extends State<Item>{

  static const double iconSize = 20.0;

  FocusNode? focusNode;

  TextEditingController get controller => widget.controller;
  TextStyle? get style => widget.style;
  TextStyle? get hintStyle => widget.hintStyle;
  String? get hint => widget.hint;
  bool get removable => widget.removable;
  TextCapitalization get textCapitalization => widget.textCapitalization;
  TextAlignVertical? get textAlignVertical => widget.textAlignVertical;
  void Function()? get onRemoveTap => widget.onRemoveTap;
  void Function(String)? get onChanged => widget.onChanged;

  late bool selected;

  @override
  void initState() {
    focusNode = FocusNode();
    focusNode!.addListener(() =>
        setState(() => selected = focusNode!.hasFocus));

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
                  style: style??AppTextStyle(fontSize: Dimen.TEXT_SIZE_BIG, fontWeight: weight.halfBold),
                  minLines: 1,
                  maxLines: 1,
                  textCapitalization: textCapitalization,
                  textAlignVertical: textAlignVertical,
                  decoration: InputDecoration(
                    //isDense: true,
                    //isCollapsed: true,
                    //contentPadding: EdgeInsets.all(0),
                      hintText: hint,
                      hintStyle: hintStyle??AppTextStyle(
                        color: hintEnab_(context),
                        fontSize: Dimen.TEXT_SIZE_BIG,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                  ),
                  onChanged: onChanged,
                ),
              ):

              GestureDetector(
                onTap: (){
                  setState(() => selected = true);
                  focusNode!.requestFocus();
                },
                child: Text(
                  controller.text.isEmpty?hint!:controller.text,
                  style: AppTextStyle(
                      fontSize: controller.text.isEmpty?Dimen.TEXT_SIZE_BIG:Dimen.TEXT_SIZE_BIG,
                      fontWeight: controller.text.isEmpty?weight.normal:weight.halfBold,
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

          if(focusNode!.hasFocus)
            SizedBox(
              child: IconButton(
                padding: EdgeInsets.only(left: Dimen.ICON_MARG, right: Dimen.ICON_MARG),
                icon: Icon(MdiIcons.check, size: iconSize),
                onPressed: (){
                  setState(() => selected = false);
                  focusNode!.unfocus();
                },
              ),
              height: iconSize,
            )
          else if(removable)
            SizedBox(
              child: IconButton(
                padding: EdgeInsets.only(left: Dimen.ICON_MARG, right: Dimen.ICON_MARG),
                icon: Icon(MdiIcons.close, size: iconSize),
                onPressed: onRemoveTap,
              ),
              height: iconSize,
            )
          else
            SizedBox(width: 2*Dimen.ICON_MARG + iconSize)

        ],
      ),
    ),
  );


  void setEditing(editing) => setState(() => this.selected = editing);

}