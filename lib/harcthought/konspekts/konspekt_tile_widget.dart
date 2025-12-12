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

  static const double defHeight = 180;
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
                            child: !showSpheres && (showTime && konspekt.duration != null)
                                ? Align(
                                    alignment: Alignment.centerRight,
                                    child: _TimePill(konspekt, background: background),
                                  )
                                : OverflowBar(
                                    alignment: MainAxisAlignment.spaceBetween,
                                    spacing: Dimen.defMarg,
                                    overflowAlignment: OverflowBarAlignment.start,
                                    overflowSpacing: 6.0,
                                    children: [
                                      if (showSpheres) KonspektSphereList(konspekt),
                                      if (showTime && konspekt.duration != null)
                                        _TimePill(konspekt, background: background),
                                    ],
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

  static const double height = Dimen.iconSmallSize + 2*Dimen.defMarg;

  final Konspekt konspekt;
  final Color? background;

  const _TimePill(this.konspekt, {this.background});

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
            durationToString(konspekt.duration, short: true),
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
          SizedBox(height: _TimePill.height),
          Icon(sphere.displayIcon, size: Dimen.iconSmallSize, color: iconDisab_(context)),
          const SizedBox(width: Dimen.defMarg),
          Text(sphere.displayName, style: AppTextStyle(fontWeight: weightHalfBold, color: iconDisab_(context)))
        ],
      ),
      wrapAlignment: WrapAlignment.end
  );


}