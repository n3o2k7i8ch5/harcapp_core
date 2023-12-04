import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/fade_scroll_view.dart';
import 'package:harcapp_core/dimen.dart';

import 'tag.dart';


enum Layout{LINEAR, WRAP}
class TagsWidget extends StatelessWidget{

  final List<String> allTags;
  final List<String> checkedTags;
  final Clip clipBehavior;
  final EdgeInsets padding;
  final Function(String, bool)? onTagTap;
  final double separator;
  final Layout layout;
  final Widget Function(BuildContext, String, bool) tagBuilder;

  static double get height => Dimen.TEXT_SIZE_BIG + 2*Dimen.ICON_MARG;

  const TagsWidget({
    required this.allTags,
    this.checkedTags = const [],
    this.clipBehavior = Clip.none,
    this.padding = EdgeInsets.zero,
    this.onTagTap,
    this.separator = Dimen.defMarg,
    required this.layout,
    required this.tagBuilder
  });

  static TagsWidget customWrap({
    required List<String> allTags,
    List<String> checkedTags = const [],
    Clip clipBehavior = Clip.none,
    EdgeInsets padding = EdgeInsets.zero,
    Function(String, bool)? onTagTap,
    double separator=0,
    required Widget Function(BuildContext, String, bool) tagBuilder
  }) => TagsWidget(
    allTags: allTags,
    clipBehavior: clipBehavior,
    padding: padding,
    checkedTags: checkedTags,
    onTagTap: onTagTap,
    separator: separator,
    layout: Layout.WRAP,
    tagBuilder: tagBuilder,
  );

  static TagsWidget customLinear({
    required List<String> allTags,
    List<String> checkedTags = const [],
    Clip clipBehavior = Clip.none,
    EdgeInsets padding = EdgeInsets.zero,
    Function(String, bool)? onTagTap,
    double separator = 0,
    required Widget Function(BuildContext, String, bool) tagBuilder
  }) => TagsWidget(
    allTags: allTags,
    checkedTags: checkedTags,
    clipBehavior: clipBehavior,
    padding: padding,
    onTagTap: onTagTap,
    separator: separator,
    layout: Layout.LINEAR,
    tagBuilder: tagBuilder,
  );

  static TagsWidget linear({
    required List<String> allTags,
    required List<String> checkedTags,
    Clip clipBehavior = Clip.none,
    EdgeInsets padding = EdgeInsets.zero,
    Function(String, bool)? onTagTap,
    double separator=Dimen.defMarg,
    double uncheckedElevation=0,
    double fontSize = Dimen.TEXT_SIZE_NORMAL,
  }) => TagsWidget(
    allTags: allTags,
    checkedTags: checkedTags,
    clipBehavior: clipBehavior,
    padding: padding,
    onTagTap: onTagTap,
    separator: separator,
    layout: Layout.LINEAR,
    tagBuilder: (context, tag, chekced) =>
    checkedTags.contains(tag)?
    Tag.checked(
      tag,
      onTap: onTagTap==null?null:() => onTagTap(tag, checkedTags.contains(tag)),
      fontSize: fontSize,
    ):
    Tag(
      tag,
      onTap: onTagTap==null?null:() => onTagTap(tag, checkedTags.contains(tag)),
      fontSize: fontSize,
      elevation: uncheckedElevation,
      textColor: hintEnab_(context),
    ),
  );

  static TagsWidget wrap({
    required List<String> allTags,
    List<String> checkedTags = const [],
    Clip clipBehavior = Clip.none,
    EdgeInsets padding = EdgeInsets.zero,
    Function(String, bool)? onTagTap,
    double separator=Dimen.defMarg,
    double uncheckedElevation=0,
    double fontSize = Dimen.TEXT_SIZE_NORMAL,
  }) => TagsWidget(
    allTags: allTags,
    checkedTags: checkedTags,
    clipBehavior: clipBehavior,
    padding: padding,
    onTagTap: onTagTap,
    layout: Layout.WRAP,
    separator: separator,
    tagBuilder: (context, tag, chekced) =>
    checkedTags.contains(tag)?
    Tag.checked(
      tag,
      onTap: onTagTap==null?null:() => onTagTap(tag, checkedTags.contains(tag)),
      fontSize: fontSize,
    ):
    Tag(
      tag,
      onTap: onTagTap==null?null:() => onTagTap(tag, checkedTags.contains(tag)),
      fontSize: fontSize,
      elevation: uncheckedElevation,
      textColor: hintEnab_(context),
    ),
  );

  @override
  Widget build(BuildContext context) {

    List<Widget> tags = [];
    for(int i=0; i<allTags.length; i++) {
      String tagStr = allTags[i];
      tags.add(tagBuilder(context, tagStr, checkedTags.contains(tagStr)));
      if(i<allTags.length-1 && layout == Layout.LINEAR) tags.add(SizedBox(width: separator));
    }

    return layout == Layout.WRAP?
    Wrap(
      alignment: WrapAlignment.center,
      children: tags,
      spacing: separator,
      runSpacing: separator,
      clipBehavior: clipBehavior,
    ):
    FadeScrollView(
        padding: padding,
        clipBehavior: clipBehavior,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(children: tags)
    );
  }
}
