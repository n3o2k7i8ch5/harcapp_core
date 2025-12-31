import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';

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
  OverlayEntry? _overlayEntry;

  void _showMenu() {
    final button = _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final pos = button.localToGlobal(Offset.zero);
    final radius = widget.borderRadius ?? BorderRadius.circular(AppCard.bigRadius);
    final top = widget.menuUnderButton ? pos.dy + button.size.height + 4 : pos.dy;

    _overlayEntry = OverlayEntry(
      builder: (ctx) => GestureDetector(
        onTap: _hideMenu,
        behavior: HitTestBehavior.opaque,
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned(
                left: pos.dx,
                top: top,
                child: Material(
                  color: widget.color ?? background_(ctx),
                  borderRadius: radius,
                  elevation: 8,
                  clipBehavior: Clip.antiAlias,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: button.size.width),
                    child: IntrinsicWidth(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (final item in widget.items)
                            SimpleButton.from(
                              context: ctx,
                              onTap: () {
                                _hideMenu();
                                widget.onSelected(item);
                              },
                              textColor: iconEnab_(ctx),
                              fontWeight: weightNormal,
                              center: false,
                              margin: EdgeInsets.zero,
                              text: item.text,
                              icon: item.icon,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _hideMenu();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    key: _buttonKey,
    onTap: _showMenu,
    child: widget.child,
  );

}