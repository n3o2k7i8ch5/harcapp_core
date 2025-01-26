import 'dart:convert';

import 'article.dart';
import 'common.dart';

class ArticleData{

  final String localId;
  final String title;
  final List<String> tags;
  final DateTime date;
  final String author;
  final String link;
  final List<ArticleElement> articleElements;

  const ArticleData(
      this.localId,
      { required this.title,
        required this.tags,
        required this.date,
        required this.author,
        required this.link,
        required this.articleElements
      });

  static ArticleData fromJson(String id, String code) {

    Map<String, dynamic> map = jsonDecode(code);

    final String title = map[CoreArticle.paramTitle] as String;
    final List<String> tags = ((map[CoreArticle.paramTags]??[]) as List).cast<String>();
    final String author = map[CoreArticle.paramAuthor] as String;
    final DateTime date = DateTime.parse(map[CoreArticle.paramDate] as String);
    final String link = map[CoreArticle.paramLink] as String;
    final List<dynamic> items = map[CoreArticle.paramArtclItems] as List<dynamic>;


    List<ArticleElement> articleElements = [];
    for(dynamic item in items){
      ArticleElement? element = ArticleElement.decode(item);
      if(element != null) articleElements.add(element);
    }

    if(articleElements.isNotEmpty)
      articleElements.removeAt(articleElements.length-1);

    return ArticleData(
      id.split(CoreArticle.uniqNameSep)[1],
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