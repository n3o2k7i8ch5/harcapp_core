import 'package:flutter/material.dart';
import 'package:harcapp_core/harcthought/articles/model/article.dart';

/// Lets a host app inject custom article-image rendering. Used by Flutter web
/// where the default `CachedNetworkImage`-based path CORS-fails against
/// servers that don't emit `Access-Control-Allow-Origin`. Wrap the part of
/// the widget tree that displays articles:
///
/// ```dart
/// runApp(
///   ArticleRenderers(
///     coverBuilder: webCoverBuilder,
///     imageBuilder: webImageBuilder,
///     child: MyApp(),
///   ),
/// );
/// ```
///
/// Native apps don't wrap and get the default rendering. The InheritedWidget
/// is read once when an article widget builds; subsequent rebuilds don't
/// retrigger because [updateShouldNotify] returns `false`.
class ArticleRenderers extends InheritedWidget {

  /// Returns a widget that renders the cover image of [article]. Receives
  /// the whole article so the implementation can decide how to obtain the
  /// image URL (e.g. read [CoreArticle.imageUrl] directly, or kick off a
  /// lazy URL resolution for sources that don't carry it).
  final Widget Function(CoreArticle article)? coverBuilder;

  /// Returns a widget that renders an inline article image given its URL
  /// (e.g. `PictureArticleElement.link`).
  final Widget Function(String url)? imageBuilder;

  const ArticleRenderers({
    super.key,
    this.coverBuilder,
    this.imageBuilder,
    required super.child,
  });

  static ArticleRenderers? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ArticleRenderers>();

  @override
  bool updateShouldNotify(ArticleRenderers oldWidget) =>
      coverBuilder != oldWidget.coverBuilder ||
      imageBuilder != oldWidget.imageBuilder;
}
