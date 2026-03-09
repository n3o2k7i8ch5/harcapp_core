import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';

import 'app_card.dart';

abstract interface class IconTextEnum {
  IconData get icon;
  String get text;
}

class AppDropdown<T extends IconTextEnum> extends StatefulWidget{

  final Widget child;
  final Color? color;
  final void Function(T item) onSelected;
  final List<T> items;
  final BorderRadius? borderRadius;
  final bool menuUnderButton;

  const AppDropdown({
    super.key,
    required this.child,
    this.color,
    required this.onSelected,
    required this.items,
    this.borderRadius,
    this.menuUnderButton = false,
  });

  @override
  State<AppDropdown<T>> createState() => _AppDropdownState<T>();
}

class _AppDropdownState<T extends IconTextEnum> extends State<AppDropdown<T>> {
  final GlobalKey _buttonKey = GlobalKey();

  void _showMenu() async {
    final button = _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final overlay = Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;
    final buttonPos = button.localToGlobal(Offset.zero, ancestor: overlay);
    final radius = widget.borderRadius ?? BorderRadius.circular(AppCard.bigRadius);

    final double top = widget.menuUnderButton
        ? buttonPos.dy + button.size.height + 4
        : buttonPos.dy;

    final position = RelativeRect.fromRect(
      Rect.fromLTWH(buttonPos.dx, top, button.size.width, button.size.height),
      Offset.zero & overlay.size,
    );

    final result = await showMenu<T>(
      context: context,
      position: position,
      shape: RoundedRectangleBorder(borderRadius: radius),
      color: widget.color ?? background_(context),
      elevation: 8,
      constraints: BoxConstraints(minWidth: button.size.width),
      items: [
        for (final item in widget.items)
          PopupMenuItem<T>(
            value: item,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(item.icon, color: iconEnab_(context)),
                SizedBox(width: 10),
                Text(
                  item.text,
                  style: TextStyle(
                    color: iconEnab_(context),
                    fontWeight: weightNormal,
                  ),
                ),
              ],
            ),
          ),
      ],
    );

    if (result != null && mounted) widget.onSelected(result);
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    key: _buttonKey,
    onTap: _showMenu,
    child: widget.child,
  );

}
