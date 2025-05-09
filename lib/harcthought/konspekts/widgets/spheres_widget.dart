import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../konspekt.dart';

class KonspektSphereDetailFactorWidget extends StatelessWidget{

  final String detail;
  final Set<KonspektSphereFactor>? factors;

  const KonspektSphereDetailFactorWidget(this.detail, this.factors);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(detail, style: AppTextStyle(fontWeight: weight.bold)),
      if(factors != null && factors!.length > 0)
        Padding(
          padding: EdgeInsets.only(top: 2.0),
          child: Wrap(
              spacing: Dimen.defMarg,
              runSpacing: Dimen.defMarg,
              children: <Widget>[
                Text(
                    factors!.length == 1?
                    'Metoda:':
                    'Metody:',
                    style: AppTextStyle()
                )
              ] + factors!.map((f) => f.textWidget).toList()
          ),
        )
    ],
  );

}

class KonspektSphereDetailLevelWidget extends StatelessWidget{

  final KonspektSphereLevel level;
  final Map<String, Set<KonspektSphereFactor>?> data;

  const KonspektSphereDetailLevelWidget(this.level, this.data);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      if(level != KonspektSphereLevel.other)
        level.textWidget,

      if(level != KonspektSphereLevel.other)
        SizedBox(height: .5*Dimen.defMarg),

      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: Dimen.defMarg,
        children: data.keys.map((detail) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              child: Icon(MdiIcons.circleMedium, size: AppTextStyle.defFontSize),
            ),

            Expanded(
              child: KonspektSphereDetailFactorWidget(detail, data[detail]),
            ),
          ],
        )).toList(),
      )
    ],
  );

}

class KonspektSphereDetailsWidget extends StatelessWidget{

  final KonspektSphereDetails details;
  final void Function()? onLevelTap;

  const KonspektSphereDetailsWidget(this.details, {super.key, this.onLevelTap});

  @override
  Widget build(BuildContext context){

    if(details.levels == null || details.levels!.isEmpty)
      return Container();

    return SimpleButton(
      radius: 0,
      padding: const EdgeInsets.all(2*Dimen.defMarg),
      onTap: onLevelTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 2*Dimen.defMarg,
        children: details.levels!.keys.map((level) =>
            KonspektSphereDetailLevelWidget(
              level,
              details.levels![level]!,
            )
        ).toList(),
      ),
    );

  }

}

class KonspektSphereWidget extends StatelessWidget{

  final KonspektSphere sphere;
  final KonspektSphereDetails? details;
  final void Function()? onDuchLevelInfoTap;


  const KonspektSphereWidget(
      this.sphere,
      this.details,
      { super.key,
        this.onDuchLevelInfoTap,
      });

  @override
  Widget build(BuildContext context) => Material(
    borderRadius: BorderRadius.circular(AppCard.defRadius),
    color: cardEnab_(context),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
            padding: const EdgeInsets.only(
                top: 2*Dimen.defMarg,
                left: 2*Dimen.defMarg
            ),
            child: Row(
              children: [

                Icon(sphere.displayIcon),

                const SizedBox(width: Dimen.iconMarg),

                Expanded(
                    child: Text(
                        sphere.displayName,
                        style: const AppTextStyle(fontSize: Dimen.textSizeAppBar)
                    )
                )

              ],
            )
        ),

        const SizedBox(height: 2*Dimen.defMarg),

        if(details != null && sphere == KonspektSphere.duch)
          KonspektSphereDetailsWidget(
              details!,
              onLevelTap: onDuchLevelInfoTap,
          )
        else if(details != null)
          KonspektSphereDetailsWidget(details!)

      ],
    ),
  );

}

class KonspektSpheresWidget extends StatelessWidget{

  final Map<KonspektSphere, KonspektSphereDetails?> spheres;
  final void Function()? onDuchLevelInfoTap;

  const KonspektSpheresWidget(
      this.spheres,
      { super.key,
        this.onDuchLevelInfoTap,
      });

  @override
  Widget build(BuildContext context) => ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    separatorBuilder: (context, index) => const SizedBox(height: Dimen.defMarg),
    itemBuilder: (context, index){
      KonspektSphere sphere = spheres.keys.toList()[index];
      return KonspektSphereWidget(
          sphere,
          spheres[sphere],
          onDuchLevelInfoTap: onDuchLevelInfoTap,
      );
    },
    itemCount: spheres.length,
  );

}