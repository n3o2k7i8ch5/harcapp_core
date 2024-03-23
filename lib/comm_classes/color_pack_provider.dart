import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'color_pack.dart';

class ColorPackProvider extends ChangeNotifier{

  static ColorPackProvider of(BuildContext context) => Provider.of<ColorPackProvider>(context, listen: false);

  late bool Function() _isDark;
  bool get isDark => _isDark();

  late ColorPack _colorPack;

  ColorPack get colorPack => _isDark() ? _colorPack.darkEquivalent??_colorPack: _colorPack;
  set colorPack(ColorPack value){
    _colorPack = value;
    notifyListeners();
  }

  ColorPackProvider({
    required ColorPack initColorPack,
    required bool Function() isDark,
  }){
    _colorPack = initColorPack;
    this._isDark = isDark;
  }

  void notify() => notifyListeners();

}