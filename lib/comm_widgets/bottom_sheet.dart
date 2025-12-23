import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/hide_keyboard.dart';
import 'package:harcapp_core/comm_classes/no_glow_behavior.dart';
import 'package:harcapp_core/comm_widgets/app_button.dart';
import 'package:harcapp_core/comm_widgets/gradient_widget.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/common.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'blur.dart';


Future<void> showScrollBottomSheet({required BuildContext context, required WidgetBuilder builder, bool scrollable = true}) async {

  await hideKeyboard(context);

  await showModalBottomSheet(
    context: context,
    isScrollControlled: scrollable,
    useSafeArea: false,
    enableDrag: scrollable,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    // Safe Area looks stupid here, since `useSafeArea: true` is used above, but it's needed to avoid the system
    // navigation bar overlapping the `BottomSheetTemplate`.
    builder: (context) => SafeArea(
      child: LayoutBuilder(
          builder: (context, constraints) => _BottomSheetContent(
            content: builder(context),
            maxHeight: constraints.maxHeight,
          )
      )
    ),
  );
}

class _BottomSheetContent extends StatefulWidget {
  final Widget content;
  final double maxHeight;

  const _BottomSheetContent({
    required this.content,
    required this.maxHeight,
  });

  @override
  State<_BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<_BottomSheetContent> {
  final GlobalKey _contentKey = GlobalKey();
  double? _contentHeight;

  void notify() => setState((){});

  bool get _exceedsHeight => _contentHeight != null && _contentHeight! > widget.maxHeight;

  @override
  void initState() {
    super.initState();
    post(_measureContent);
  }

  @override
  void didUpdateWidget(_BottomSheetContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.maxHeight != widget.maxHeight) {
      post(_measureContent);
    }
  }

  void _measureContent() {
    final renderBox = _contentKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null && renderBox.hasSize) {
      final height = renderBox.size.height;
      if (_contentHeight != height) {
        setState(() => _contentHeight = height);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = KeyedSubtree(
      key: _contentKey,
      child: widget.content,
    );

    if (_exceedsHeight) {
      return DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) => ScrollConfiguration(
          behavior: NoGlowBehavior(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: scrollController,
            child: content,
          ),
        ),
      );
    } else {
      // Wrap in SingleChildScrollView to allow measuring unconstrained height
      return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: content,
      );
    }
  }
}

class _BottomSheetRawWidget extends StatelessWidget{

  static const double radius = 12.0;
  static const BorderRadius borderRadius = BorderRadius.only(
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius)
  );

  final String? title;
  final String? subTitle;
  final Widget? Function(BuildContext context) builder;
  final Color? textColor;
  final Color? color;
  final Color? colorEnd;
  final EdgeInsets childMargin;

  const _BottomSheetRawWidget({
    this.title,
    this.subTitle,
    required this.builder,
    this.textColor,
    this.color,
    this.colorEnd,
    this.childMargin = const EdgeInsets.all(Dimen.BOTTOM_SHEET_MARG),
    super.key
  });

  @override
  Widget build(BuildContext context){

    Widget _widget = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if(title!=null)
          Padding(
              padding: const EdgeInsets.all(Dimen.BOTTOM_SHEET_TITLE_MARG - Dimen.iconMarg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(title!, style: AppTextStyle(fontWeight: weightHalfBold, color: textColor, fontSize: Dimen.textSizeBig), textAlign: TextAlign.end,),
                      if(subTitle!=null) Text(subTitle!, style: AppTextStyle(color: hintEnab_(context), fontSize: Dimen.textSizeNormal), textAlign: TextAlign.end,),
                    ],
                  ),

                  AppButton(
                    icon: Icon(MdiIcons.close, color: textColor),
                    onTap: () => Navigator.pop(context),
                  )

                ],
              )
          ),
        Padding(
          padding: childMargin,
          child: builder(context),
        ),
      ],
    );

    if(colorEnd == null){
      return Material(
        borderRadius: borderRadius,
        color: color??background_(context),
        child: _widget,
      );
    }

    return GradientWidget(
      borderRadius: borderRadius,
      colorStart: color??background_(context),
      colorEnd: colorEnd??color??background_(context),
      child: _widget,
    );
  }

}

class BottomSheetDef extends StatelessWidget{

  static const double radius = _BottomSheetRawWidget.radius;

  final String? title;
  final String? subTitle;
  final Widget? Function(BuildContext context) builder;
  final Color? textColor;
  final Color? color;
  final Color? colorEnd;
  final EdgeInsets childMargin;

  const BottomSheetDef({
    this.title,
    this.subTitle,
    required this.builder,
    this.textColor,
    this.color,
    this.colorEnd,
    this.childMargin = const EdgeInsets.all(Dimen.BOTTOM_SHEET_MARG),
    super.key
  });

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: _BottomSheetRawWidget(
        title: title,
        subTitle: subTitle,
        builder: builder,
        textColor: textColor,
        color: color,
        colorEnd: colorEnd,
        childMargin: childMargin,
      )
  );

}

class BottomSheetBlur extends StatelessWidget{

  static const double radius = _BottomSheetRawWidget.radius;

  final String? title;
  final String? subTitle;
  final Widget? Function(BuildContext context) builder;
  final Color? textColor;
  final Color? color;
  final Color? colorEnd;
  final EdgeInsets childMargin;
  final double blur;

  const BottomSheetBlur({
    this.title,
    this.subTitle,
    required this.builder,
    this.textColor,
    this.color,
    this.colorEnd,
    this.childMargin = const EdgeInsets.all(Dimen.BOTTOM_SHEET_MARG),
    this.blur = 10.0,
    super.key
  });

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Blur(
        sigma: blur,
        borderRadius: _BottomSheetRawWidget.borderRadius,
        child: _BottomSheetRawWidget(
          title: title,
          subTitle: subTitle,
          builder: builder,
          textColor: textColor,
          color: color,
          colorEnd: colorEnd,
          childMargin: childMargin,
        )
      )
  );

}