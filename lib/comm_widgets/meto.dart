import 'package:flutter/cupertino.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/dimen.dart';

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
    child: Image.asset(
      meto.iconPath,
      width: size,
      height: size,
    ),
  );

}

class MetoTile extends StatelessWidget{

  final double iconSize;
  final Meto meto;
  final Widget? trailing;

  const MetoTile({required this.meto, this.iconSize = 24.0, this.trailing, super.key});

  @override
  Widget build(BuildContext context) => IntrinsicWidth(
    child: Container(
        decoration: BoxDecoration(
            color: meto.color,
            borderRadius: BorderRadius.circular(AppCard.defRadius)
        ),
        child: Row(
          children: [

            const SizedBox(width: Dimen.defMarg),

            Image.asset(
              meto.iconPath,
              width: iconSize,
              height: iconSize,
            ),

            const SizedBox(width: Dimen.defMarg),

            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      meto.shortDisplayName,
                      style: AppTextStyle(
                          fontSize: Dimen.textSizeBig,
                          fontWeight: weight.bold,
                          color: background_(context)
                      ),
                    ),

                    const SizedBox(height: 3.0),

                    Text(
                      meto.age,
                      style: AppTextStyle(
                          fontSize: Dimen.textSizeNormal,
                          fontWeight: weight.halfBold,
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
    ),
  );

}