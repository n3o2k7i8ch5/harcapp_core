import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/gradient_icon.dart';
import 'package:harcapp_core/comm_widgets/meto_row.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/gradient_widget.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'harc_form.dart';

class FormThumbnailTagsWidget extends StatelessWidget{

  final HarcForm form;
  final int? maxItems;

  const FormThumbnailTagsWidget(this.form, {this.maxItems, super.key});

  @override
  Widget build(BuildContext context) {

    List<Widget> children = [];

    List<HarcFormTag> tags;

    if (maxItems == null) tags = form.tags;
    else tags = form.tags.take(maxItems!).toList();

    bool hasMoreThanMax = maxItems != null && form.tags.length > maxItems!;

    for(HarcFormTag tag in tags)
      children.add(
          Row(
            children: [

              Icon(tag.icon, size: Dimen.iconSmallSize, color: hintEnab_(context)),

              const SizedBox(width: Dimen.iconMarg),

              Text(
                tag.text,
                style: AppTextStyle(
                  fontSize: Dimen.textSizeNormal,
                  color: hintEnab_(context),
                  fontWeight: weightHalfBold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

            ],
          )
      );

    if(hasMoreThanMax)
      children.add(
        Align(
          alignment: Alignment.centerLeft,
          child: Icon(MdiIcons.dotsHorizontal, size: Dimen.iconSmallSize, color: hintEnab_(context)),
        )
      );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );

  }

}

class FormThumbnailWidget extends StatelessWidget{

  final HarcForm form;
  final double elevation;
  final void Function()? onTap;

  const FormThumbnailWidget(this.form, {this.elevation = 0, this.onTap, super.key});

  @override
  Widget build(BuildContext context) => AspectRatio(
    aspectRatio: 2,
    child: Hero(
        tag: form,
        child: GradientWidget(
            elevation: elevation,
            colorStart: form.colorStart.withValues(alpha: .25),
            colorEnd: form.colorEnd.withValues(alpha: .25),
            radius: AppCard.bigRadius,
            child: InkWell(
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.all(Dimen.harcthoughtTileMarg),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      GradientIcon(
                        form.icon,
                        colorStart: form.colorStart,
                        colorEnd: form.colorEnd,
                        size: 64.0,
                      ),

                      const SizedBox(width: Dimen.iconMarg),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              form.title,
                              style: AppTextStyle(
                                fontSize: Dimen.textSizeBig,
                                color: iconEnab_(context),
                                fontWeight: weightBold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            const SizedBox(height: Dimen.iconMarg),

                            Expanded(child: FormThumbnailTagsWidget(form, maxItems: 2)),

                            MetoRow(form.metos, mainAxisAlignment: MainAxisAlignment.end),

                          ],
                        ),
                      ),

                    ],
                  ),
                )
            )
        )

    ),
  );

}