import 'article.dart';
import 'article_identifier.dart';
import 'article_source.dart';
import 'common.dart';

class ArticleData extends ArticleIdentifier{

  String get link => _link??"https://harcapp.web.app/article/${source.name}/$localId";

  final String title;
  final List<String> tags;
  final DateTime date;
  final String author;
  final String? _link;
  final List<ArticleElement> articleElements;

  const ArticleData(
      super.localId,
      super.source,
      { required this.title,
        required this.tags,
        required this.date,
        required this.author,
        required String? link,
        required this.articleElements
      }): _link = link;

  static ArticleData fromJson(String localId, ArticleSource source, Map jsonMap) {

    final String title = jsonMap[CoreArticle.paramTitle] as String;
    final List<String> tags = ((jsonMap[CoreArticle.paramTags]??[]) as List).cast<String>();
    final String author = jsonMap[CoreArticle.paramAuthor] as String;
    final DateTime date = DateTime.parse(jsonMap[CoreArticle.paramDate] as String);
    final String? link = jsonMap[CoreArticle.paramLink] as String;
    final List<dynamic> items = jsonMap[CoreArticle.paramArtclItems] as List<dynamic>;

    List<ArticleElement> articleElements = [];
    for(dynamic item in items){
      ArticleElement? element = ArticleElement.decode(item);
      if(element != null) articleElements.add(element);
    }

    if(articleElements.isNotEmpty)
      articleElements.removeAt(articleElements.length-1);

    return ArticleData(
      localId,
      source,
      title: title,
      tags: tags,
      date: date,
      link: link,
      author: author,
      articleElements: articleElements,
    );

  }

  Map toJson() => {
    CoreArticle.paramTitle: title,
    CoreArticle.paramTags: tags,
    CoreArticle.paramAuthor: author,
    CoreArticle.paramDate: date.toIso8601String(),
    CoreArticle.paramLink: link,
    CoreArticle.paramArtclItems: articleElements.map((item) => item.toJsonObject()).toList()
  };

}