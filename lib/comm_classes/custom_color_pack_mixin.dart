import 'package:flutter/cupertino.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/color_pack_provider.dart';
import 'package:harcapp_core/comm_classes/common.dart';

mixin CustomColorPackMixin<T extends StatefulWidget> on State<T>{

  /// This mixin handles changing ColorPacks for specific StatefulWidget and
  /// switching back to the previous ColorPack when StatefulWidget is disposed.
  /// The `_colorPacksStack` mechanism is a map, and not a stack of list in
  /// order to handle the situation of `replacePushPage`, when there is a race
  /// condition between pushing the new page and removing the old page.

  static int _currMaxUniqueKey = 0;
  static final Map<int, ColorPack> _colorPacksStack = {};
  late ColorPackProvider _colorPackProv;

  ColorPack get customColorPack;

  final int _uniqueKey = _currMaxUniqueKey++;

  @override
  void initState() {
    _colorPackProv = ColorPackProvider.of(context);
    _colorPacksStack[_uniqueKey] = customColorPack;
    post(() => _colorPackProv.colorPack = customColorPack);
    super.initState();
  }

  @override
  void dispose() {
    post((){
      _colorPacksStack.remove(_uniqueKey);
      ColorPack oldColorPack;
      try {
        oldColorPack = _colorPacksStack.values.last;
      } on StateError{
        oldColorPack = const ColorPackSimple();
      }
      _colorPackProv.colorPack = oldColorPack;
    });
    super.dispose();
  }

  void swapCustomColorPack(ColorPack newColorPack){
    _colorPacksStack[_uniqueKey] = newColorPack;
  }

}