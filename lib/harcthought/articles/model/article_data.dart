import 'article_identifier.dart';
import 'article_source.dart';
import 'common.dart';

class ArticleData extends ArticleIdentifier{

  static const String paramTitle = 'title';
  static const String paramTags = 'tags';
  static const String paramAuthor = 'author';
  static const String paramDate = 'date';
  static const String paramLink = 'link';

  static const String paramImageUrl = 'imageUrl';
  static const String paramImageSource = 'imageSource';
  static const String paramAuthCode = 'authorCode';

  static const String paramItems = 'items';
  static const String paramOtherArtCores = 'other_art_cores';

  static const String paramLiked = 'liked';
  static const String paramBookmarked = 'bookmarked';
  static const String paramSeen = 'seen';

  String get link => _link??"https://harcapp.web.app/article/${source.name}/$localId";

  final String title;
  final List<String> tags;
  final DateTime date;
  final String author;
  final String? _link;
  final String? imageUrl;
  final List<ArticleElement> articleElements;

  const ArticleData(
      super.localId,
      super.source,
      { required this.title,
        required this.tags,
        required this.date,
        required this.author,
        required String? link,
        required this.imageUrl,
        required this.articleElements
      }): _link = link;

  static ArticleData fromJsonMap(String localId, ArticleSource source, Map jsonMap) {

    final String title = jsonMap[ArticleData.paramTitle] as String;
    final List<String> tags = ((jsonMap[ArticleData.paramTags]??[]) as List).cast<String>();
    final String author = jsonMap[ArticleData.paramAuthor] as String;
    final DateTime date = DateTime.parse(jsonMap[ArticleData.paramDate] as String);
    final String? link = jsonMap[ArticleData.paramLink] as String?;
    final String? imageUrl = jsonMap[ArticleData.paramImageUrl] as String?;
    final List<dynamic> items = jsonMap[ArticleData.paramItems] as List<dynamic>;

    List<ArticleElement> articleElements = [];
    for(dynamic item in items){
      ArticleElement? element = ArticleElement.decode(item);
      if(element != null) articleElements.add(element);
    }

    if(articleElements.isNotEmpty)
      articleElements.removeAt(articleElements.length-1);

    return ArticleData(
      source,
      localId,
      title: title,
      tags: tags,
      date: date,
      link: link,
      imageUrl: imageUrl,
      author: author,
      articleElements: articleElements,
    );

  }

  Map toJsonMap() => {
    ArticleData.paramTitle: title,
    ArticleData.paramTags: tags,
    ArticleData.paramAuthor: author,
    ArticleData.paramDate: date.toIso8601String(),
    ArticleData.paramLink: link,
    ArticleData.paramImageUrl: imageUrl,
    ArticleData.paramItems: articleElements.map((item) => item.toJsonObject()).toList()
  };

}
