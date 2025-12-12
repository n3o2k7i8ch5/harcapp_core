import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/date_to_str.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/meto_row.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:harcapp_core/harcthought/konspekts/widgets/cover_widget.dart';
import 'package:harcapp_core/tag/tags_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'konspekt.dart';

class KonspektTileWidget extends StatelessWidget{

  static const double defHeight = 140;
  static const double defRadius = AppCard.bigRadius;

  final Konspekt konspekt;
  final double elevation;
  final Color? background;
  final bool colorizeLeftSide;
  final double radius;
  final bool showSummary;
  final bool showPartOf;
  final bool showSpheres;
  final bool showTime;
  final void Function()? onTap;

  const KonspektTileWidget(
      this.konspekt,
      { this.elevation = 0, 
        this.background,
        this.colorizeLeftSide = true,
        this.radius = defRadius,
        this.showSummary = true,
        this.showPartOf = true,
        this.showSpheres = true,
        this.showTime = true,
        this.onTap, 
        super.key
      });

  double _measureTextWidth(BuildContext context, String text, TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: Directionality.of(context),
      maxLines: 1,
    )..layout();
    return painter.size.width;
  }

  double _estimateSphereListSingleLineWidth(BuildContext context) {
    if (konspekt.spheres.isEmpty) return 0;

    final textStyle = AppTextStyle(fontWeight: weightHalfBold, color: iconDisab_(context));
    double width = 0;

    for (int i = 0; i < konspekt.spheres.keys.length; i++) {
      final sphere = konspekt.spheres.keys.elementAt(i);

      final labelWidth = _measureTextWidth(context, sphere.displayName, textStyle);
      final itemWidth = Dimen.iconSmallSize + Dimen.defMarg + labelWidth;

      width += itemWidth;
      if (i < konspekt.spheres.keys.length - 1) width += Dimen.iconMarg;
    }

    return width;
  }

  double _estimateTimePillWidth(BuildContext context) {
    if (konspekt.duration == null) return 0;

    final textStyle = AppTextStyle(
      fontSize: Dimen.textSizeNormal,
      fontWeight: weightHalfBold,
      color: background ?? konspekt.type.color(context),
    );
    final textWidth = _measureTextWidth(context, durationToString(konspekt.duration), textStyle);

    return 2 * Dimen.defMarg + Dimen.iconSmallSize + Dimen.defMarg + textWidth;
  }

  @override
  Widget build(BuildContext context) => Hero(
      tag: konspekt,
      child: SimpleButton(
        elevation: elevation,
        onTap: onTap,
        color: background??konspekt.type.color(context),
        borderRadius: BorderRadius.circular(this.radius),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            SizedBox(
              width: 24*4 + 3*MetoRow.separatorWidth + 2*Dimen.iconMarg,
              child: Stack(
                clipBehavior: Clip.none,
                fit: StackFit.expand,
                children: [

                  SpinKitFoldingCube(
                    size: 2*Dimen.iconSize,
                    color: backgroundIcon_(context),
                  ),

                  KonspektCoverWidget(konspekt),

                  Positioned(
                    bottom: Dimen.iconMarg,
                    right: Dimen.iconMarg,
                    left: Dimen.iconMarg,
                    child: MetoRow(konspekt.metos),
                  ),

                ],
              ),
            ),

            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(Dimen.harcthoughtTileMarg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        Row(
                          children: [

                            Expanded(
                              child: AutoSizeText(
                                konspekt.title,
                                style: AppTextStyle(
                                  fontSize: Dimen.textSizeBig,
                                  fontWeight: weightHalfBold,
                                  color: konspekt.upToDate?textEnab_(context):textDisab_(context),
                                ),
                                maxLines: konspekt.title.split(' ').length,
                              ),
                            ),

                            if(showPartOf && konspekt.partOf != null)
                              SizedBox(
                                width: 1.5*2*Dimen.textSizeBig,
                                height: 2*Dimen.textSizeBig,
                                child: Material(
                                    elevation: AppCard.bigElevation,
                                    clipBehavior: Clip.hardEdge,
                                    borderRadius: BorderRadius.circular(radius),
                                    child: KonspektCoverWidget(konspekt.partOf!)
                                ),
                              )

                          ],
                        ),

                        if(showSummary)
                          Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(top: 6.0),
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    final textStyle = AppTextStyle(
                                      fontSize: Dimen.textSizeNormal,
                                      color: textDisab_(context),
                                    );
                                    final lineHeight = textStyle.fontSize! * (textStyle.height ?? 1.2);
                                    final maxLines = (constraints.maxHeight / lineHeight).floor().clamp(1, 4);
                                    return Text(
                                      konspekt.summary,
                                      style: textStyle,
                                      maxLines: maxLines,
                                      overflow: TextOverflow.ellipsis,
                                    );
                                  },
                                ),
                              )
                          ),

                        if (showSpheres || (showTime && konspekt.duration != null))
                          Padding(
                            padding: EdgeInsets.only(top: 6.0),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final spheresWidget = showSpheres ? KonspektSphereList(konspekt) : null;
                                final timeWidget = (showTime && konspekt.duration != null)
                                    ? _TimePill(konspekt, background: background)
                                    : null;

                                if (spheresWidget == null) {
                                  return Align(
                                    alignment: Alignment.centerRight,
                                    child: timeWidget!,
                                  );
                                }

                                if (timeWidget == null) return spheresWidget;

                                final spheresWidth = _estimateSphereListSingleLineWidth(context);
                                final pillWidth = _estimateTimePillWidth(context);
                                final gap = Dimen.defMarg;

                                final canFitSideBySide = spheresWidth + gap + pillWidth <= constraints.maxWidth;

                                if (canFitSideBySide)
                                  return Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: spheresWidget),
                                      const SizedBox(width: Dimen.defMarg),
                                      timeWidget,
                                    ],
                                  );

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    spheresWidget,
                                    const SizedBox(height: 6.0),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: timeWidget,
                                    ),
                                  ],
                                );
                              },
                            ),
                          )

                      ],
                    )
                )
            ),

            if(colorizeLeftSide && background != null)
              Container(
                height: double.infinity,
                width: 6.0,
                color: konspekt.type.color(context),
              )
            
          ],
        ),
      )
  );

}

class _TimePill extends StatelessWidget{

  final Konspekt konspekt;
  final Color? background;

  const _TimePill(this.konspekt, {this.background, super.key});

  @override
  Widget build(BuildContext context) => Material(
    color: textEnab_(context),
    borderRadius: BorderRadius.circular(100),
    child: Padding(
      padding: EdgeInsets.all(Dimen.defMarg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [

          Icon(
              MdiIcons.timerOutline,
              size: Dimen.iconSmallSize,
              color: background??konspekt.type.color(context)
          ),

          const SizedBox(width: Dimen.defMarg),

          Text(
            durationToString(konspekt.duration),
            style: AppTextStyle(
              fontSize: Dimen.textSizeNormal,
              fontWeight: weightHalfBold,
              color: background??konspekt.type.color(context),
            ),
          ),

        ],
      ),
    ),
  );


}

class KonspektSphereList extends StatelessWidget{

  final Konspekt konspekt;

  const KonspektSphereList(this.konspekt, {super.key});

  @override
  Widget build(BuildContext context) => TagsWidget.customWrap<KonspektSphere>(
      allTags: konspekt.spheres.keys.toList(),
      separator: Dimen.iconMarg,
      tagBuilder: (context, sphere, checked) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(sphere.displayIcon, size: Dimen.iconSmallSize, color: iconDisab_(context)),
          const SizedBox(width: Dimen.defMarg),
          Text(sphere.displayName, style: AppTextStyle(fontWeight: weightHalfBold, color: iconDisab_(context)))
        ],
      ),
      wrapAlignment: WrapAlignment.start
  );


}