import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/fade_scroll_view.dart';
import 'package:harcapp_core/dimen.dart';

import 'tag.dart';


enum Layout{LINEAR, WRAP}
class TagsWidget<T> extends StatelessWidget{

  final List<T> allTags;
  final Iterable<T> checkedTags;
  final Clip clipBehavior;
  final Color? background;
  final EdgeInsets padding;
  final Function(T, bool)? onTagTap;
  final double separator;
  final Layout layout;
  final Widget Function(BuildContext, T, bool) tagBuilder;
  final WrapAlignment wrapAlignment;

  static double get height => Dimen.textSizeBig + 2*Dimen.iconMarg;

  const TagsWidget({
    required this.allTags,
    this.checkedTags = const [],
    this.clipBehavior = Clip.none,
    this.background,
    this.padding = EdgeInsets.zero,
    this.onTagTap,
    this.separator = Dimen.defMarg,
    required this.layout,
    required this.tagBuilder,
    this.wrapAlignment = WrapAlignment.center
  });

  static TagsWidget customWrap<T>({
    required List<T> allTags,
    List<T> checkedTags = const [],
    Clip clipBehavior = Clip.none,
    Color? background,
    EdgeInsets padding = EdgeInsets.zero,
    void Function(T, bool)? onTagTap,
    double separator=0,
    required Widget Function(BuildContext, T, bool) tagBuilder,
    WrapAlignment wrapAlignment = WrapAlignment.center,
  }) => TagsWidget<T>(
    allTags: allTags,
    clipBehavior: clipBehavior,
    background: background,
    padding: padding,
    checkedTags: checkedTags,
    onTagTap: onTagTap,
    separator: separator,
    layout: Layout.WRAP,
    wrapAlignment: wrapAlignment,
    tagBuilder: tagBuilder,
  );

  static TagsWidget customLinear<T>({
    required List<T> allTags,
    List<T> checkedTags = const [],
    Clip clipBehavior = Clip.none,
    Color? background,
    EdgeInsets padding = EdgeInsets.zero,
    void Function(T, bool)? onTagTap,
    double separator = 0,
    required Widget Function(BuildContext, T, bool) tagBuilder
  }) => TagsWidget<T>(
    allTags: allTags,
    checkedTags: checkedTags,
    clipBehavior: clipBehavior,
    background: background,
    padding: padding,
    onTagTap: onTagTap,
    separator: separator,
    layout: Layout.LINEAR,
    tagBuilder: tagBuilder,
  );

  static TagsWidget linear<T>({
    required List<T> allTags,
    List<T> checkedTags = const [],
    Clip clipBehavior = Clip.none,
    Color? background,
    EdgeInsets padding = EdgeInsets.zero,
    void Function(T, bool)? onTagTap,
    double separator=Dimen.defMarg,
    double uncheckedElevation=0,
    double fontSize = Dimen.textSizeNormal,
    String Function(T)? tagToName,
  }) => TagsWidget<T>(
    allTags: allTags,
    checkedTags: checkedTags,
    clipBehavior: clipBehavior,
    background: background,
    padding: padding,
    onTagTap: onTagTap,
    separator: separator,
    layout: Layout.LINEAR,
    tagBuilder: (context, tag, checked) =>
    checkedTags.contains(tag)?
    Tag.checked(
      tagToName?.call(tag)??tag.toString(),
      onTap: onTagTap==null?null:() => onTagTap(tag, checkedTags.contains(tag)),
      fontSize: fontSize,
    ):
    Tag(
      tagToName?.call(tag)??tag.toString(),
      onTap: onTagTap==null?null:() => onTagTap(tag, checkedTags.contains(tag)),
      fontSize: fontSize,
      elevation: uncheckedElevation,
      textColor: hintEnab_(context),
    ),
  );

  static TagsWidget wrap<T>({
    required List<T> allTags,
    List<T> checkedTags = const [],
    Clip clipBehavior = Clip.none,
    Color? background,
    EdgeInsets padding = EdgeInsets.zero,
    void Function(T, bool)? onTagTap,
    double separator = Dimen.defMarg,
    double uncheckedElevation=0,
    double fontSize = Dimen.textSizeNormal,
    String Function(T)? tagToName,
    WrapAlignment wrapAlignment = WrapAlignment.center,
  }) => TagsWidget<T>(
    allTags: allTags,
    checkedTags: checkedTags,
    clipBehavior: clipBehavior,
    background: background,
    padding: padding,
    onTagTap: onTagTap,
    layout: Layout.WRAP,
    wrapAlignment: wrapAlignment,
    separator: separator,
    tagBuilder: (context, tag, chekced) =>
    checkedTags.contains(tag)?
    Tag.checked(
      tagToName?.call(tag)??tag.toString(),
      onTap: onTagTap==null?null:() => onTagTap(tag, checkedTags.contains(tag)),
      fontSize: fontSize,
    ):
    Tag(
      tagToName?.call(tag)??tag.toString(),
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
      T tagStr = allTags[i];
      tags.add(tagBuilder(context, tagStr, checkedTags.contains(tagStr)));
      if(i<allTags.length-1 && layout == Layout.LINEAR) tags.add(SizedBox(width: separator));
    }

    return layout == Layout.WRAP?
    Wrap(
      alignment: wrapAlignment,
      children: tags,
      spacing: separator,
      runSpacing: separator,
      clipBehavior: clipBehavior,
    ):
    FadeScrollView(
        padding: padding,
        clipBehavior: clipBehavior,
        background: background,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(children: tags)
    );
  }
}
