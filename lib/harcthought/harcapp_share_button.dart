import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

/// Pluggable share entry point. Apps register an implementation at startup
/// (mobile uses share_plus; web can use Web Share API or share_plus). Core
/// itself stays free of platform/share dependencies.
class HarcappShare {
  HarcappShare._();

  static Future<void> Function(String url, {String? subject})? _impl;

  static void register(Future<void> Function(String url, {String? subject}) impl) {
    _impl = impl;
  }

  static bool get isRegistered => _impl != null;

  static Future<void> share(String url, {String? subject}) async {
    final impl = _impl;
    if (impl == null) return;
    await impl(url, subject: subject);
  }
}

/// Button that shares a harcapp.web.app URL. Hidden if no share impl registered.
class HarcappShareButton extends StatelessWidget {
  final String url;
  final String? subject;
  final IconData? icon;
  final Color? color;
  final Color? iconColor;
  final Color? textColor;
  final double? radius;
  final String? tooltip;
  final bool collapsed;
  final EdgeInsets? padding;

  const HarcappShareButton({
    required this.url,
    this.subject,
    this.icon,
    this.color,
    this.iconColor,
    this.textColor,
    this.radius,
    this.tooltip = 'Udostępnij',
    this.collapsed = false,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (!HarcappShare.isRegistered) return const SizedBox.shrink();
    return Tooltip(
      message: tooltip,
      child: SimpleButton.from(
        context: context,
        color: color,
        iconColor: iconColor,
        textColor: textColor,
        radius: radius,
        margin: EdgeInsets.zero,
        padding: padding ?? const EdgeInsets.all(Dimen.iconMarg),
        icon: icon ?? MdiIcons.shareVariant,
        text: collapsed ? null : 'Udostępnij',
        onTap: () => HarcappShare.share(url, subject: subject),
      ),
    );
  }
}
