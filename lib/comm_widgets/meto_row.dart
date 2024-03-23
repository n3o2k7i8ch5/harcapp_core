import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';

class MetoRow extends StatelessWidget{

  static const double separatorWidth = 8.0;

  final List<Meto> metos;
  final bool elevated;
  final MainAxisAlignment mainAxisAlignment;
  final Widget Function(Widget widget)? itemBuilder;

  const MetoRow(this.metos, {super.key, this.elevated=false, this.mainAxisAlignment = MainAxisAlignment.start, this.itemBuilder});

  @override
  Widget build(BuildContext context) {

    List<Widget> children = [];
    for(int i=0; i<metos.length; i++) {
      Meto meto = metos[i];
      Widget child = Text(
        meto.letter,
        style: AppTextStyle(
            fontWeight: weight.bold,
            color: meto.color,
            shadow: elevated
        ),
      );

      if(itemBuilder != null)
        child = itemBuilder!.call(child);

      children.add(child);
      if(i<metos.length-1)
        children.add(const SizedBox(width: separatorWidth));
    }

    return Row(mainAxisAlignment: mainAxisAlignment, children: children);

  }

}