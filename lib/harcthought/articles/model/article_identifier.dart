import 'article_source.dart';

class ArticleIdentifier{

  static const String uniqNameSep = '@';

  final String localId;
  final ArticleSource source;

  String get uniqName => source.name + ArticleIdentifier.uniqNameSep + localId;

  const ArticleIdentifier(this.localId, this.source);

  static ArticleIdentifier fromUniqName(String uniqName){
    List<String> parts = uniqName.split(uniqNameSep);
    ArticleSource source = ArticleSource.fromName(parts[0])??(throw 'Invalid source name: ${parts[0]}');
    return ArticleIdentifier(parts[1], source);
  }
}