import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/values/dimen.dart';

import 'blur.dart';

class MetoIcon extends StatelessWidget{

  final double size;
  final Meto meto;

  const MetoIcon({required this.meto, this.size = 24.0, super.key});

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
        color: meto.color,
        borderRadius: BorderRadius.circular(size)
    ),
    child: SvgPicture.asset(
      meto.iconSvgPath,
      width: size,
      height: size,
    ),
  );

}

class MetoThumbnail extends StatelessWidget{

  final Meto meto;

  const MetoThumbnail({required this.meto, super.key});

  @override
  Widget build(BuildContext context) => Blur(
    borderRadius: BorderRadius.circular(100),
    color: background_(context).withValues(alpha: .6),
    child: SizedBox(
      width: 24,
      height: 24,
      child: Center(
        child: Text(
          meto.letter,
          style: AppTextStyle(
              fontWeight: weightBold,
              color: meto.color,
          ),
        )
      ),
    ),
  );

}

class MetoTile extends StatelessWidget{

  final double iconSize;
  final Meto meto;
  final Widget? trailing;
  final bool intrinsicWidth;

  const MetoTile({
    required this.meto,
    this.iconSize = 24.0,
    this.trailing,
    this.intrinsicWidth = true,
    super.key
  });

  @override
  Widget build(BuildContext context) {

    Widget child = Container(
        decoration: BoxDecoration(
            color: meto.color,
            borderRadius: BorderRadius.circular(AppCard.defRadius)
        ),
        child: Row(
          children: [

            const SizedBox(width: Dimen.defMarg),

            SvgPicture.asset(
              meto.iconSvgPath,
              width: iconSize,
              height: iconSize,
            ),

            const SizedBox(width: Dimen.defMarg),

            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(
                      meto.shortDisplayName,
                      style: AppTextStyle(
                          fontSize: Dimen.textSizeBig,
                          fontWeight: weightBold,
                          color: background_(context)
                      ),
                    ),

                    const SizedBox(height: 3.0),

                    Text(
                      meto.age,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle(
                          fontSize: Dimen.textSizeNormal,
                          fontWeight: weightHalfBold,
                          color: background_(context)
                      ),
                    )

                  ],
                )
            ),

            const SizedBox(width: Dimen.iconMarg),

            if(trailing != null)
              trailing!,
          ],
        )
    );

    if(intrinsicWidth)
      return IntrinsicWidth(child: child);

    return child;

  }

}