import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/meto_row.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:harcapp_core/harcthought/konspekts/widgets/cover_widget.dart';
import 'package:harcapp_core/tag/tags_widget.dart';

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
                    child: MetoRow(
                      konspekt.metos,
                      itemBuilder: (child) => Material(
                        borderRadius: BorderRadius.circular(100),
                        color: background_(context).withValues(alpha: .7),
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Center(child: child),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),

            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(Dimen.sideMarg),
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
                                  fontWeight: weight.halfBold,
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
                                child: Text(
                                  konspekt.summary,
                                  style: AppTextStyle(
                                    fontSize: Dimen.textSizeNormal,
                                    color: textDisab_(context),
                                  ),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                          ),

                        if(showSpheres)
                          Padding(
                            padding: EdgeInsets.only(top: 6.0),
                            child: KonspektSphereList(konspekt),
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
          Text(sphere.displayName, style: AppTextStyle(fontWeight: weight.halfBold, color: iconDisab_(context)))
        ],
      ),
      wrapAlignment: WrapAlignment.start
  );


}