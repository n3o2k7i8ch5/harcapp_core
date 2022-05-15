import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'color_pack.dart';

class ColorPackProvider extends ChangeNotifier{

  static ColorPackProvider of(BuildContext context) => Provider.of<ColorPackProvider>(context, listen: false);

  late bool Function() isDark;
  ColorPack? _colorPackDark;

  ColorPack? _colorPack;

  ColorPack? get colorPack => isDark()?_colorPackDark:_colorPack;
  set colorPack(ColorPack? value){
    _colorPack = value;
    notifyListeners();
  }

  ColorPackProvider({
    required ColorPack initColorPack,
    required bool Function() isDark,
    required ColorPack colorPackDark,
  }){
    _colorPack = initColorPack;
    this.isDark = isDark;
    this._colorPackDark = colorPackDark;
  }

  void notify() => notifyListeners();

}