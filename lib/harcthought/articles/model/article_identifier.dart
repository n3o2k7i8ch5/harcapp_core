import 'article_source.dart';

abstract class ArticleIdentifier{

  static const String uniqNameSep = '@';

  final String localId;
  final ArticleSource source;

  String get uniqName => source.name + ArticleIdentifier.uniqNameSep + localId;

  const ArticleIdentifier(this.localId, this.source);
}