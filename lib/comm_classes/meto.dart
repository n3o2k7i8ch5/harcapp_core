import 'package:flutter/cupertino.dart';
import 'package:harcapp_core/colors.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/dimen.dart';

enum Meto{
  zuch,
  harc,
  hs,
  wedro;

  String get displayName{
    switch(this){
      case Meto.zuch: return 'Zuchy';
      case Meto.harc: return 'Harcerze';
      case Meto.hs: return 'Harcerze starsi';
      case Meto.wedro: return 'Wędrownicy';
    }
  }

  String get shortDisplayName{
    switch(this){
      case Meto.zuch: return 'Zuch';
      case Meto.harc: return 'Harc';
      case Meto.hs: return 'HS';
      case Meto.wedro: return 'Wędro';
    }
  }

  String get letter{
    switch(this){
      case Meto.zuch: return 'Z';
      case Meto.harc: return 'H';
      case Meto.hs: return 'HS';
      case Meto.wedro: return 'W';
    }
  }

  String get age{
    switch(this){
      case Meto.zuch: return '7-9 lat';
      case Meto.harc: return '10-12 lat';
      case Meto.hs: return '13-15 lat';
      case Meto.wedro: return '16-21 lat';
    }
  }

  Color get color{
    switch(this){
      case Meto.zuch: return AppColors.metoZhpZ;
      case Meto.harc: return AppColors.metoZhpH;
      case Meto.hs: return AppColors.metoZhpHS;
      case Meto.wedro: return AppColors.metoZhpW;
    }
  }

  String get iconPath{
    switch(this){
      case Meto.zuch: return 'assets/images/meto/meto_z.webp';
      case Meto.harc: return 'assets/images/meto/meto_h.webp';
      case Meto.hs: return 'assets/images/meto/meto_hs.webp';
      case Meto.wedro: return 'assets/images/meto/meto_w.webp';
    }
  }

}

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