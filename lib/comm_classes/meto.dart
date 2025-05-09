import 'package:flutter/material.dart';
import 'package:harcapp_core/values/colors.dart';

enum Meto{
  zuch,
  harc,
  hs,
  wedro,
  kadra;

  String get displayName{
    switch(this){
      case Meto.zuch: return 'Zuchy';
      case Meto.harc: return 'Harcerze';
      case Meto.hs: return 'Harcerze starsi';
      case Meto.wedro: return 'Wędrownicy';
      case Meto.kadra: return 'Kadra';
    }
  }

  String get shortDisplayName{
    switch(this){
      case Meto.zuch: return 'Zuch';
      case Meto.harc: return 'Harc';
      case Meto.hs: return 'HS';
      case Meto.wedro: return 'Wędro';
      case Meto.kadra: return 'Kadra';
    }
  }

  String get letter{
    switch(this){
      case Meto.zuch: return 'Z';
      case Meto.harc: return 'H';
      case Meto.hs: return 'HS';
      case Meto.wedro: return 'W';
      case Meto.kadra: return 'K';
    }
  }

  String get age{
    switch(this){
      case Meto.zuch: return '7-9 lat';
      case Meto.harc: return '10-12 lat';
      case Meto.hs: return '13-15 lat';
      case Meto.wedro: return '16-21 lat';
      case Meto.kadra: return 'instruktorzy';
    }
  }

  Color get color{
    switch(this){
      case Meto.zuch: return AppColors.metoZhpZ;
      case Meto.harc: return AppColors.metoZhpH;
      case Meto.hs: return AppColors.metoZhpHS;
      case Meto.wedro: return AppColors.metoZhpW;
      case Meto.kadra: return AppColors.metoZhpK;
    }
  }

  String get iconSvgPath{
    switch(this){
      case Meto.zuch: return 'packages/harcapp_core/assets/images/meto/z.svg';
      case Meto.harc: return 'packages/harcapp_core/assets/images/meto/h.svg';
      case Meto.hs: return 'packages/harcapp_core/assets/images/meto/hs.svg';
      case Meto.wedro: return 'packages/harcapp_core/assets/images/meto/w.svg';
      case Meto.kadra: return 'packages/harcapp_core/assets/images/meto/kadra.svg';
    }
  }



}
