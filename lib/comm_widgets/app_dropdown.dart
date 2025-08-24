import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';

import 'app_card.dart';

abstract interface class IconTextEnum {
  IconData get icon;
  String get text;
}

class AppDropdownButton<T extends IconTextEnum> extends PopupMenuItem<T>{

  AppDropdownButton(BuildContext context, T item, {bool enabled = true}):
        super(
          value: item,
          enabled: enabled,
          padding: EdgeInsets.zero,
          child: SimpleButton.from(
              context: context,
              onTap: null,
              textColor: enabled?iconEnab_(context): iconDisab_(context),
              fontWeight: weightNormal,
              margin: EdgeInsets.zero,
              text: item.text,
              icon: item.icon
          )
      );

}

class AppDropdown<T extends IconTextEnum> extends StatelessWidget{

  final Widget? child;
  final Widget? icon;
  final Color? color;
  final void Function(T item) onSelected;
  final List<AppDropdownButton<T>> Function(BuildContext context) itemBuilder;

  const AppDropdown({
    super.key,
    this.child,
    this.icon,
    this.color,
    required this.onSelected,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) => PopupMenuButton<T>(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppCard.bigRadius),
    ),
    menuPadding: EdgeInsets.zero,
    padding: EdgeInsets.zero,
    clipBehavior: Clip.hardEdge,
    color: color??background_(context),
    icon: icon,
    child: child,
    onSelected: onSelected,
    itemBuilder: (BuildContext context) => itemBuilder.call(context)
  );

}