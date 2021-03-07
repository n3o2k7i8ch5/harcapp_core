import 'package:flutter/foundation.dart';

import 'color_pack.dart';

abstract class ColorPackProvider extends ChangeNotifier{

  bool get isDark;
  ColorPack get colorPackDark;

  ColorPack _colorPack;

  ColorPack get colorPack => isDark?colorPackDark:_colorPack;
  set colorPack(ColorPack value){
    _colorPack = value;
    notifyListeners();
  }

  ColorPackProvider(ColorPack colorPack){
    _colorPack = colorPack;
  }

  void notify() => notifyListeners();

}