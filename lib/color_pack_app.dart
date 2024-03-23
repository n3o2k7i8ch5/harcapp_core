import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:provider/provider.dart';

import 'comm_classes/color_pack_provider.dart';

class ColorPackApp extends StatelessWidget{

  final ColorPack initColorPack;
  final bool Function() isDark;
  final Widget child;

  const ColorPackApp({
    required this.initColorPack,
    required this.isDark,
    required this.child
  });

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (BuildContext context) => ColorPackProvider(
      initColorPack: initColorPack,
      isDark: isDark,
    ),
    builder: (context, _) => child,
  );

}

void setColorPack(BuildContext context, ColorPack colorPack) => ColorPackProvider.of(context).colorPack = colorPack;

bool isDark(BuildContext context) => ColorPackProvider.of(context).isDark;