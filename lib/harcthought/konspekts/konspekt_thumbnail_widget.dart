import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:harcapp_core/color_pack_app.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/meto_row.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:harcapp_core/tag/tags_widget.dart';

import 'konspekt.dart';

class KonspektThumbnailWidget extends StatelessWidget{

  final Konspekt konspekt;
  final double elevation;
  final double radius;
  final void Function()? onTap;

  const KonspektThumbnailWidget(this.konspekt, {this.elevation = 0, this.radius = AppCard.bigRadius, this.onTap, super.key});

  @override
  Widget build(BuildContext context) => Hero(
      tag: konspekt,
      child: SimpleButton(
        elevation: elevation,
        onTap: onTap,
        color: konspekt.type.color(context), // isDark(context)?Colors.brown[400]:Colors.amber[100],
        // colorEnd: isDark(context)?Colors.brown[500]:Colors.amber[200],
        borderRadius: BorderRadius.circular(this.radius),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            SizedBox(
              width: 24*4 + 3*MetoRow.separatorWidth + 2*Dimen.iconMarg,
              child: Stack(
                fit: StackFit.expand,
                children: [

                  SpinKitFoldingCube(
                    size: 2*Dimen.iconSize,
                    color: backgroundIcon_(context),
                  ),

                  Image.asset(
                    konspekt.coverPath,
                    fit: BoxFit.cover,
                  ),

                  Positioned(
                    bottom: Dimen.iconMarg,
                    right: Dimen.iconMarg,
                    left: Dimen.iconMarg,
                    child: MetoRow(
                      konspekt.metos,
                      itemBuilder: (child) => Material(
                        borderRadius: BorderRadius.circular(100),
                        color: (isDark(context)?Colors.brown[400]:Colors.amber[100])?.withOpacity(.7),
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

                        Expanded(
                          child: AutoSizeText(
                            konspekt.title,
                            style: const TextStyle(
                              fontFamily: 'PlayfairDisplay',
                              fontSize: Dimen.textSizeBig,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            maxLines: konspekt.title.split(' ').length,
                          ),
                        ),

                        KonspektSphereList(konspekt)

                      ],
                    )
                )
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