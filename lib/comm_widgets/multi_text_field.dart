import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MultiTextFieldController{

  operator [](int index) => _texts[index];
  operator []=(int index, String value){
    _texts[index] = value;
    for(void Function(int, String) listener in _listeners)
      listener(index, value);
  }
  int get length => _texts.length;
  String get last => _texts[length-1];
  bool get isEmpty => _texts.isEmpty;
  bool get isNotEmpty => _texts.isNotEmpty;

  List<String> _texts;
  List<String> get texts => _texts;

  List<void Function(int, String)> _listeners;
  List<void Function(List<String>)> _anyListeners;

  MultiTextFieldController({List<String> texts}){
    if(texts == null || texts.length == 0)
      texts = [''];
    this._texts = texts;
    _listeners = [];
    _anyListeners = [];
  }

  removeAt(int index){
    _texts.removeAt(index);
    _callOnChanged(index);
    _callOnAnyChanged();
  }

  addText(String text){
    _texts.add(text);
    _callOnChanged(_texts.length-1);
    _callOnAnyChanged();
  }

  setText(int index, String text){
    _texts[index] = text;
    _callOnChanged(index);
    _callOnAnyChanged();
  }

  void addOnChangedListener(void Function(int, String) listener) => _listeners.add(listener);
  void removeOnChangedListener(void Function(int, String) listener) => _listeners.remove(listener);

  void addOnAnyChangedListener(void Function(List<String>) listener) => _anyListeners.add(listener);
  void removeOnAnyChangedListener(void Function(List<String>) listener) => _anyListeners.remove(listener);

  void _callOnChanged(int index){
    for(void Function(int, String) listener in _listeners)
      listener(index, texts[index]);
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

  static const IconData addIcon = MdiIcons.plusCircleOutline;

  final MultiTextFieldController controller;
  final String hint;
  final bool linear;
  final Color accentColor;
  final void Function(List<String>) onAnyChanged;
  final void Function(int, String) onChanged;
  final void Function() onRemoved;

  const MultiTextField({this.controller, this.hint, this.linear: true, this.accentColor, this.onAnyChanged, this.onChanged, this.onRemoved});

  @override
  State<StatefulWidget> createState() => MultiTextFieldState();


}

class MultiTextFieldState extends State<MultiTextField>{

  MultiTextFieldController _controller;
  MultiTextFieldController get controller => widget.controller??_controller;
  String get hint => widget.hint;
  bool get linear => widget.linear;
  Color get accentColor => widget.accentColor;
  //void Function(List<String>) get onAnyChanged => widget.onAnyChanged;
  //void Function(int, String) get onChanged => widget.onChanged;
  void Function() get onRemoved => widget.onRemoved;

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
      String text = controller[i];
      children.add(Item(
        initText: text,
        hint: hint,
        onChanged: (text){
          controller[i] = text;
          if(i == controller.length-1)
            setState(() {});
          controller._callOnChanged(i);
          controller._callOnAnyChanged();
        },
        onRemoveTap: () => setState((){
          controller.removeAt(i);
          onRemoved?.call();
          controller._callOnChanged(i);
          controller._callOnAnyChanged();
        }),
      ));

      if(linear && i < controller.length-1)
        children.add(SizedBox(width: Dimen.DEF_MARG));
    }

    children.add(
      IconButton(
        icon: Icon(
          MultiTextField.addIcon,
          color:
          controller.isNotEmpty && controller.last.isEmpty?
          iconDisab_(context):
          accentColor,
        ),
        onPressed:
        controller.isNotEmpty && controller.last.isEmpty?
        null:
        () => setState((){
          String text = '';
          controller.addText(text);
          controller._callOnChanged(controller.length-1);
          controller._callOnAnyChanged();
        }),
      )
    );

    if(linear)
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(children: children),
        clipBehavior: Clip.none,
      );
    else
      return Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        children: children,
        runSpacing: Dimen.DEF_MARG,
        spacing: Dimen.DEF_MARG,
      );
  }
}



class Item extends StatefulWidget{
  
  final String initText;
  final String hint;
  final void Function() onRemoveTap;
  final void Function(String) onChanged;

  const Item({@required this.initText, @required this.hint, this.onRemoveTap, this.onChanged, Key key}):super(key: key);

  @override
  State<StatefulWidget> createState() => ItemState();

}

class ItemState extends State<Item>{

  FocusNode focusNode;

  String get initText => widget.initText;
  String get hint => widget.hint;
  void Function() get onRemoveTap => widget.onRemoveTap;
  void Function(String) get onChanged => widget.onChanged;

  TextEditingController controller;
  bool selected;

  @override
  void initState() {
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() => selected = focusNode.hasFocus);
    });

    controller = TextEditingController(text: initText);
    selected = false;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {

    Widget child = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [

        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 40.0, maxHeight: Dimen.TEXT_SIZE_BIG),
          child:
          selected?

          IntrinsicWidth(
            child: TextField(
              focusNode: focusNode,
              controller: controller,
              style: AppTextStyle(fontSize: Dimen.TEXT_SIZE_BIG, fontWeight: weight.halfBold),
              textAlignVertical: TextAlignVertical.center,
              scrollPadding: EdgeInsets.zero,
              decoration: InputDecoration(
                  isCollapsed: true,
                  //contentPadding: EdgeInsets.zero,
                  hintText: hint,
                  hintStyle: AppTextStyle(
                    color: hintEnab_(context),
                    fontSize: Dimen.TEXT_SIZE_BIG,
                  ),
                  border: InputBorder.none
              ),
              onChanged: onChanged,
            ),
          ):

          Text(
            controller.text.length==0?hint:controller.text,
            style: AppTextStyle(
                fontSize: controller.text.length==0?Dimen.TEXT_SIZE_BIG:Dimen.TEXT_SIZE_BIG,
                fontWeight: controller.text.length==0?weight.normal:weight.halfBold,
                color: controller.text.length==0?hintEnab_(context):textEnab_(context)
            ),
          ),
        ),

        if(focusNode.hasFocus)
          SimpleButton.from(
            context: context,
            icon: MdiIcons.check,
            iconSize: 20,
            margin: EdgeInsets.zero,
            onTap: (){
              setState(() => selected = false);
              focusNode.unfocus();
            },
          )
        else
          SimpleButton.from(
            context: context,
            icon: MdiIcons.close,
            iconSize: 20,
            margin: EdgeInsets.zero,
            onTap: onRemoveTap,
          )

      ],
    );

    return Stack(
      children: [

        GestureDetector(
          onTap: (){
            setState(() => selected = true);
            focusNode.requestFocus();
          },
          child: child,
        ),

        if(focusNode.hasFocus && false)
          Positioned(
            left: 0,
            right: Dimen.ICON_MARG,
            bottom: 10,
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                color: hintEnab_(context), //accent_(context),
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
            ),
          )

      ],
    );

  }

  void setEditing(editing) => setState(() => this.selected = editing);

}