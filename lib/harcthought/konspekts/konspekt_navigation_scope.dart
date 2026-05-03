import 'package:flutter/widgets.dart';

/// Inversion-of-control for in-app navigation triggered by konspekt content
/// (e.g. [KonspektInternalLinkAttachment]). The host app provides
/// [openInternalLink] once near the top of the widget tree; widgets in this
/// package read it from context when the user taps an internal link.
///
/// Kept here because `harcapp_core` cannot depend on host-app pages
/// (`ApelEwansPage`, `KonspektSwipePage`, ...). The scope replaces what would
/// otherwise be a global mutable singleton.
class KonspektNavigationScope extends InheritedWidget {

  /// Opens [linkPath] (a `harcapp.web.app` path like `/rozwazania_ewangeliczne`)
  /// inside the host app — typically by parsing it via `HarcappLinks.parsePath`
  /// and pushing the resulting page on top of the current route. Returns true
  /// if the link was resolved and pushed.
  final Future<bool> Function(BuildContext context, String linkPath) openInternalLink;

  const KonspektNavigationScope({
    required this.openInternalLink,
    required super.child,
    super.key,
  });

  static KonspektNavigationScope? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<KonspektNavigationScope>();

  @override
  bool updateShouldNotify(KonspektNavigationScope oldWidget) =>
      openInternalLink != oldWidget.openInternalLink;

}
