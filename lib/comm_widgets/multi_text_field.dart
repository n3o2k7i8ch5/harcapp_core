import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MultiTextField extends StatefulWidget{

  static const IconData addIcon = MdiIcons.plusCircleOutline;

  final List<String> initVals;
  final String hint;
  final bool linear;
  final Color accentColor;
  final void Function(List<String>) onChanged;

  const MultiTextField({this.initVals, this.hint, this.linear: true, this.accentColor, this.onChanged});

  @override
  State<StatefulWidget> createState() => MultiTextFieldState();


}

class MultiTextFieldState extends State<MultiTextField>{

  List<String> get initVals => widget.initVals;
  String get hint => widget.hint;
  bool get linear => widget.linear;
  Color get accentColor => widget.accentColor;
  void Function(List<String>) get onChanged => widget.onChanged;

  List<String> texts;
  List<GlobalKey<ItemState>> keys;

  @override
  void initState() {
    texts = [];
    if(initVals != null)
      texts.addAll(initVals);

    keys = [];
    for(int i=0; i<texts.length; i++)
      keys.add(GlobalKey<ItemState>());

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    
    List<Widget> children = [];
    for(int i=0; i<texts.length; i++) {
      String text = texts[i];
      children.add(Item(
        initText: text,
        hint: hint,
        onChanged: (text){
          texts[i] = text;
          if(i == texts.length-1)
            setState(() {});
          onChanged?.call(texts);
        },
        onRemoveTap: () => setState((){
          texts.removeAt(i);
          keys.removeAt(i);
          onChanged?.call(texts);
        }),
        key: keys[i],
      ));

      if(linear && i < texts.length-1)
        children.add(SizedBox(width: Dimen.DEF_MARG));
    }

    children.add(
      IconButton(
        icon: Icon(
          MultiTextField.addIcon,
          color:
          texts.isNotEmpty && texts.last.isEmpty?
          iconDisab_(context):
          accentColor,
        ),
        onPressed:
        texts.isNotEmpty && texts.last.isEmpty?
        null:
        () => setState((){
          texts.add('');
          keys.add(GlobalKey<ItemState>());
          onChanged?.call(texts);
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