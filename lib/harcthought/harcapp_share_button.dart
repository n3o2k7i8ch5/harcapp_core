import 'package:flutter/material.dart';
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
  final String? tooltip;
  final EdgeInsetsGeometry? padding;

  const HarcappShareButton({
    required this.url,
    this.subject,
    this.icon,
    this.tooltip = 'Udostępnij',
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (!HarcappShare.isRegistered) return const SizedBox.shrink();
    return IconButton(
      icon: Icon(icon ?? MdiIcons.shareVariant),
      tooltip: tooltip,
      padding: padding ?? const EdgeInsets.all(8),
      onPressed: () => HarcappShare.share(url, subject: subject),
    );
  }
}
