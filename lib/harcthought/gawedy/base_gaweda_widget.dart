import 'package:flutter/material.dart';
import 'package:harcapp_core/harcthought/common/base_short_read_widget.dart';

import 'gaweda.dart';

class BaseGawedaWidget extends StatelessWidget{

  final Gaweda gaweda;
  final bool withAppBar;

  const BaseGawedaWidget(this.gaweda, {this.withAppBar = true, super.key});

  @override
  Widget build(BuildContext context) => BaseShortReadWidget<Gaweda>(
      gaweda,
      'package/harcapp_core/assets/gawedy',
      withAppBar: withAppBar
  );

}