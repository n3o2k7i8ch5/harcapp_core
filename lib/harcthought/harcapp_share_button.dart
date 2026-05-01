import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/app_button.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/blur.dart';
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

enum _ShareButtonKind { appButton, simpleButton }

/// Button that shares a harcapp.web.app URL. Hidden if no share impl registered.
///
/// Two variants:
/// - [HarcappShareButton.appButton] — icon-only [AppButton], for app bar actions
///   and inline sidebars (next to a header).
/// - [HarcappShareButton.simpleButton] — pill (icon + optional label) with
///   optional [Blur] backdrop. Defaults are tuned for "glass pill on a cover":
///   transparent fill, black icon, white α=0.7 blur sigma=2, [AppCard.defRadius].
///   Set `blurSigma: null` (or 0) to drop the [Blur] entirely.
class HarcappShareButton extends StatelessWidget {
  final String url;
  final String? subject;
  final _ShareButtonKind _kind;

  // simpleButton-only fields
  final bool _collapsed;
  final Color? _color;
  final Color? _iconColor;
  final Color? _textColor;
  final double? _radius;
  final EdgeInsets? _padding;
  final EdgeInsets? _margin;
  final double? _blurSigma;
  final Color? _blurColor;

  const HarcappShareButton.appButton({
    required this.url,
    this.subject,
    super.key,
  })  : _kind = _ShareButtonKind.appButton,
        _collapsed = false,
        _color = null,
        _iconColor = null,
        _textColor = null,
        _radius = null,
        _padding = null,
        _margin = null,
        _blurSigma = null,
        _blurColor = null;

  const HarcappShareButton.simpleButton({
    required this.url,
    this.subject,
    bool collapsed = false,
    Color? color = Colors.transparent,
    Color? iconColor = Colors.black,
    Color? textColor,
    double? radius,
    EdgeInsets? padding,
    EdgeInsets? margin,
    double? blurSigma = 2.0,
    Color? blurColor,
    super.key,
  })  : assert(
          blurColor == null || (blurSigma != null && blurSigma > 0),
          'blurColor only takes effect when blurSigma > 0',
        ),
        _kind = _ShareButtonKind.simpleButton,
        _collapsed = collapsed,
        _color = color,
        _iconColor = iconColor,
        _textColor = textColor,
        _radius = radius,
        _padding = padding,
        _margin = margin,
        _blurSigma = blurSigma,
        _blurColor = blurColor;

  @override
  Widget build(BuildContext context) {
    if (!HarcappShare.isRegistered) return const SizedBox.shrink();
    return _kind == _ShareButtonKind.appButton
        ? _buildAppButton()
        : _buildSimpleButton(context);
  }

  Widget _buildAppButton() => AppButton(
    icon: Icon(MdiIcons.shareVariant),
    tooltip: 'Udostępnij',
    onTap: () => HarcappShare.share(url, subject: subject),
  );

  Widget _buildSimpleButton(BuildContext context) {
    final radius = _radius ?? AppCard.defRadius;
    final pill = Tooltip(
      message: 'Udostępnij',
      child: SimpleButton.from(
        context: context,
        color: _color,
        iconColor: _iconColor,
        textColor: _textColor,
        radius: radius,
        margin: _margin ?? EdgeInsets.zero,
        padding: _padding ?? const EdgeInsets.all(Dimen.defMarg),
        icon: MdiIcons.shareVariant,
        text: _collapsed ? null : 'Udostępnij',
        onTap: () => HarcappShare.share(url, subject: subject),
      ),
    );

    final hasBlur = _blurSigma != null && _blurSigma > 0;
    if (!hasBlur) return pill;
    return Blur(
      sigma: _blurSigma,
      color: _blurColor ?? Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(radius),
      child: pill,
    );
  }
}
