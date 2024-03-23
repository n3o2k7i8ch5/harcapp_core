import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:provider/provider.dart';

import 'comm_classes/color_pack_provider.dart';

class ColorPackApp extends StatelessWidget{

  final ColorPack initColorPack;
  final bool Function() isDark;

  const ColorPackApp(this.initColorPack, this.isDark);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (BuildContext context) => ColorPackProvider(
      initColorPack: initColorPack,
      isDark: isDark,
    ),
  );

}

void setColorPack(BuildContext context, ColorPack colorPack) => ColorPackProvider.of(context).colorPack = colorPack;

bool isDark(BuildContext context) => ColorPackProvider.of(context).isDark;