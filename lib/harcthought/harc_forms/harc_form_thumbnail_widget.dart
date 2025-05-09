import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/gradient_icon.dart';
import 'package:harcapp_core/comm_widgets/meto_row.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/gradient_widget.dart';
import 'package:harcapp_core/values/dimen.dart';

import 'harc_form.dart';

class FormThumbnailTagsWidget extends StatelessWidget{

  final HarcForm form;
  const FormThumbnailTagsWidget(this.form, {super.key});

  @override
  Widget build(BuildContext context) {

    List<Widget> children = [];

    for(HarcFormTag tag in form.tags){
      children.add(Row(
        children: [

          Icon(tag.icon, size: Dimen.iconSmallSize, color: hintEnab_(context)),

          const SizedBox(width: Dimen.iconMarg),

          Text(
            tag.text,
            style: AppTextStyle(
              fontSize: Dimen.textSizeNormal,
              color: hintEnab_(context),
              fontWeight: weight.halfBold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

        ],
      ));
    }

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
                padding: const EdgeInsets.all(16.0),
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
                              fontWeight: weight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: Dimen.iconMarg),

                          FormThumbnailTagsWidget(form),

                          Expanded(child: Container()),

                          MetoRow(form.metos, elevated: true, mainAxisAlignment: MainAxisAlignment.end),

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