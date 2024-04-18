import 'package:flutter/material.dart';
import 'package:harcapp_core/harcthought/common/base_short_read_widget.dart';
import 'package:harcapp_core/harcthought/wiersze/wiersz.dart';

class BaseWierszWidget extends StatelessWidget{

  final Wiersz wiersz;
  final bool withAppBar;

  const BaseWierszWidget(this.wiersz, {this.withAppBar = true, super.key});

  @override
  Widget build(BuildContext context) => BaseShortReadWidget<Wiersz>(
      wiersz,
      withAppBar: withAppBar
  );

}