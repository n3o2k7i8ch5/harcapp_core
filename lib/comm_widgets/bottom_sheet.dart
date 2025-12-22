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
      child: BottomSheetTemplate(
          builder: builder,
          scrollable: scrollable
      ),
    ),
  );
}

class BottomSheetTemplate extends StatelessWidget {

  final WidgetBuilder builder;
  final bool? scrollable;

  const BottomSheetTemplate({
    required this.builder,
    this.scrollable,
    super.key
  });

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final content = builder(context);

      return _BottomSheetContent(
        content: content,
        maxHeight: constraints.maxHeight,
      );
    },
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

class BottomSheetDef extends StatefulWidget{

  static const double radius = 12.0;

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
    super.key});

  @override
  State<StatefulWidget> createState() => BottomSheetDefState();

}

class BottomSheetDefState extends State<BottomSheetDef>{

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    child: GradientWidget(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0)
        ),
        colorStart: widget.color??background_(context),
        colorEnd: widget.colorEnd??widget.color??background_(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if(widget.title!=null)
              Padding(
                  padding: const EdgeInsets.all(Dimen.BOTTOM_SHEET_TITLE_MARG - Dimen.iconMarg),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(widget.title!, style: AppTextStyle(fontWeight: weightHalfBold, color: widget.textColor, fontSize: Dimen.textSizeBig), textAlign: TextAlign.end,),
                          if(widget.subTitle!=null) Text(widget.subTitle!, style: AppTextStyle(color: hintEnab_(context), fontSize: Dimen.textSizeNormal), textAlign: TextAlign.end,),
                        ],
                      ),

                      AppButton(
                        icon: Icon(MdiIcons.close, color: widget.textColor),
                        onTap: () => Navigator.pop(context),
                      )

                    ],
                  )
              ),
            Padding(
              padding: widget.childMargin,
              child: widget.builder(context),
            ),
          ],
        ),

    ),
  );

  void notify() => setState((){});

}