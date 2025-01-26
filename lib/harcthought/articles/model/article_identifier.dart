import 'article_source.dart';

abstract class ArticleIdentifier{

  static const String uniqNameSep = '@';

  final String localId;
  final ArticleSource source;

  const ArticleIdentifier(this.localId, this.source);
}