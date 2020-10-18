import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';

import '../comm_classes/color_pack.dart';
import '../dimen.dart';
import '../comm_classes/simple_button.dart';
import 'app_card.dart';


class Tag extends StatefulWidget{

  static const String TAG_ANGIELSKI = '#Angielski';
  static const String TAG_BALLADY = '#Ballady';
  static const String TAG_HARCERSKIE = '#Harcerskie';
  static const String TAG_HISTORYCZNE = '#Historyczne';
  static const String TAG_KOLEDY = '#Kolędy';
  static const String TAG_O_MILOSCI = '#OMiłości';
  static const String TAG_PATRIOTYCZNE = '#Patriotyczne';
  static const String TAG_POWSTANCZE = '#Powstańcze';
  static const String TAG_POEZJA_SPIEWANA = '#PoezjaŚpiewana';
  static const String TAG_POPULARNE = '#Popularne';
  static const String TAG_REFLEKSYJNE = '#Refleksyjne';

  static const List<String> ALL_TAG_NAMES = [TAG_ANGIELSKI, TAG_BALLADY, TAG_HARCERSKIE,
    TAG_HISTORYCZNE, TAG_KOLEDY, TAG_O_MILOSCI, TAG_PATRIOTYCZNE,
    TAG_POWSTANCZE, TAG_POEZJA_SPIEWANA, TAG_POPULARNE, TAG_REFLEKSYJNE, "#Religijne", "#Spokojne", "#Szanty", "#Turystyczne", "#ZBajek", "#Żywe"];

  static const double height = 2*Dimen.DEF_MARG + Dimen.TEXT_SIZE_SMALL;
  static const EdgeInsets defMargin = EdgeInsets.only(left: Dimen.DEF_MARG/2, right: Dimen.DEF_MARG/2, top: Dimen.DEF_MARG, bottom: Dimen.DEF_MARG+2);

  final String tag;
  final Function(bool checked) onTap;
  final bool checked;
  final double fontSize;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final bool elevate;
  final bool inCard;

  const Tag(this.tag, {this.onTap, this.checked:true, this.fontSize, this.margin: defMargin, this.padding: const EdgeInsets.all(Dimen.MARG_ICON), this.elevate: true, this.inCard: true});

  @override
  State<StatefulWidget> createState() => TagState();
}

class TagState extends State<Tag>{

  @override
  Widget build(BuildContext context) {

    var wordWrapText = TextPainter(
      text: TextSpan(
          style: AppTextStyle(
            fontSize: widget.fontSize,
            fontWeight: weight.halfBold
          ), text: widget.tag),
      textDirection: TextDirection.ltr,
    );
    wordWrapText.layout();
    double width = wordWrapText.width;

    Widget tagStr = SizedBox(
        child: Text(
          widget.tag,
          style: AppTextStyle(
            fontSize: widget.fontSize,
            fontWeight: widget.checked?weight.halfBold:weight.normal,
            color: widget.checked?textEnabled(context):hintEnabled(context),
          ),
          textAlign: TextAlign.center,
        ),
        width: width
    );

    if(widget.inCard)
      return AppCard(
        elevation: (widget.checked && widget.elevate)?AppCard.bigElevation:0,
        color: widget.checked?defCardEnabled(context):defCardDisabled(context),
        padding: widget.padding,
        child: tagStr,
        margin: widget.margin,
        radius: 100.0,
        onTap: widget.onTap==null?null:() => widget.onTap(widget.checked)
      );
    else
      return SimpleButton(
        child: tagStr,
        margin: widget.margin,
        padding: widget.padding,
        onTap: widget.onTap==null?null:() => widget.onTap(widget.checked)
      );
  }
}

enum Layout{LINEAR, WRAP}
class TagLayout extends StatelessWidget{

  final List<Tag> tags;
  final Function onCancelTap;
  final Function(String, int, bool) onTagClick;
  final bool shadow;
  final List<bool> checked;
  final double fontSize;
  final Layout layout;

  static double get height => Dimen.TEXT_SIZE_BIG + 2*Dimen.MARG_ICON;

  const TagLayout({@required this.tags, this.onCancelTap, this.onTagClick, this.shadow:true, this.checked, this.fontSize: Dimen.TEXT_SIZE_NORMAL, @required this.layout});

  static List<Tag> getTags(Function(String, int, bool) onTagClick, List<bool> checked, double fontSize){

    List<Tag> tags = [];
    for(int i=0; i<Tag.ALL_TAG_NAMES.length; i++)
      tags.add(
          Tag(
            Tag.ALL_TAG_NAMES[i],
            onTap: onTagClick==null?null:(bool checked)=> onTagClick(Tag.ALL_TAG_NAMES[i], i, checked),
            checked: checked==null?true:checked[i],
            fontSize: fontSize,
          )
      );
    return tags;
  }

  static TagLayout wrap({
    Function onCancelTap,
    Function(String, int, bool) onTagClick,
    bool shadow,
    List<bool> checked,
    double fontSize,
  }) => TagLayout(
      tags: getTags(onTagClick, checked, fontSize),
      onCancelTap: onCancelTap,
      onTagClick: onTagClick,
      shadow: shadow,
      checked: checked,
      fontSize: fontSize,
      layout: Layout.WRAP,
    );

  static TagLayout linear({
    Function onCancelTap,
    Function(String, int, bool) onTagClick,
    List<bool> checked,
    double fontSize,
  }) => TagLayout(
      tags: getTags(onTagClick, checked, fontSize),
      onCancelTap: onCancelTap,
      onTagClick: onTagClick,
      checked: checked,
      fontSize: fontSize,
      layout: Layout.LINEAR,
    );

  @override
  Widget build(BuildContext context) {

    return InkWell(
        onTap: onCancelTap,
        child: Container(
            width: double.infinity,
            child:
            layout == Layout.WRAP?
            Wrap(
              alignment: WrapAlignment.center,
              children: tags,
            ):
            FadeScrollView(
              padding: EdgeInsets.only(bottom: AppCard.bigElevation + 1),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: tags,
              )
            ),
        )
    );
  }
}

class FadeScrollView extends StatefulWidget{

  final Axis scrollDirection;
  final bool reverse;
  final EdgeInsetsGeometry padding;
  final Widget child;
  final ScrollController controller;
  final ScrollPhysics physics;

  const FadeScrollView({this.scrollDirection: Axis.vertical, this.reverse: false, this.padding, this.child, this.controller, this.physics});

  @override
  State<StatefulWidget> createState() => FadeScrollViewState();

}

class FadeScrollViewState extends State<FadeScrollView>{

  ScrollController _controller;

  ScrollController get controller => widget.controller==null?_controller:widget.controller;

  bool showStartGlow;
  bool showEndGlow;

  @override
  void initState() {

    showStartGlow = false;
    showEndGlow = true;

    if(widget.controller == null) _controller = ScrollController();

    controller.addListener(() {
      if (_controller.offset >= _controller.position.maxScrollExtent && !_controller.position.outOfRange)
        setState(() {showStartGlow = true; showEndGlow = false;});
      else if (_controller.offset <= _controller.position.minScrollExtent && !_controller.position.outOfRange)
        setState((){showStartGlow = false; showEndGlow = true;});
      else
        setState(() {showStartGlow = true; showEndGlow = true;});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        SingleChildScrollView(
          scrollDirection: widget.scrollDirection,
          reverse: widget.reverse,
          padding: widget.padding,
          child: widget.child,
          controller: controller,
          physics: widget.physics,
        ),

        Positioned(
          top: 0, bottom: 0,
          left: 0,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: showStartGlow?1:0,
            child: Container(
              width: 36,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [background(context), background(context).withAlpha(0)]
                  )
              ),
            ),
          ),
        ),

        Positioned(
          top: 0, bottom: 0,
          right: 0,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: showEndGlow?1:0,
            child: Container(
              width: 36,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [background(context).withAlpha(0), background(context)]
                  )
              ),
            ),
          ),
        )

      ],
    );
  }

}