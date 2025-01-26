import 'dart:convert';
import 'package:flutter/material.dart' hide Element;

import 'article.dart';
import 'article_source.dart';
import 'common.dart';


class CoreArticleHarcApp extends CoreArticle{

  @override
  ArticleSource get source => ArticleSource.harcApp;

  CoreArticleHarcApp(
      super.localId,
      { required super.title,
        super.tags,
        required super.date,
        required super.author,
        super.link,
        required super.articleElements
      });

  // static Future<(List<String>?, List<String>?)> downloadIDsAndBlackList() async {
  //
  //   try {
  //     Response response = await defDio.get('https://gitlab.com/n3o2k7i8ch5/harcapp_data/-/raw/master/articles/.index');
  //
  //     if(response.statusCode == 200){
  //       String data = response.data;
  //
  //       List<String> parts = data.split('!!blacklist');
  //
  //       List<String> artIDs = [];
  //       if(parts.isNotEmpty) {
  //         artIDs = parts[0].split('\n');
  //         artIDs.removeWhere((String item) => item.isEmpty);
  //       }
  //
  //       List<String> blacklist = [];
  //       if(parts.length>1) {
  //         blacklist = parts[1].split('\n');
  //         blacklist.removeWhere((String item) => item.isEmpty);
  //       }
  //
  //       return (artIDs, blacklist);
  //     }
  //   } catch (e) {}
  //
  //   return (null, null);
  //
  // }

  static CoreArticleHarcApp fromJson(String id, String code) {

    Map<String, Object> map = jsonDecode(code);

    final String title = map[CoreArticle.paramTitle] as String;
    final List<String> tags = map[CoreArticle.paramTags] as List<String>;
    final String author = map[CoreArticle.paramAuthor] as String;
    final DateTime date = DateTime.parse(map[CoreArticle.paramDate] as String);

    final List<dynamic> items = map[CoreArticle.paramArtclItems] as List<dynamic>;

    List<ArticleElement> articleElements = [];
    for(dynamic item in items){
      ArticleElement? element = ArticleElement.decode(item);
      if(element != null) articleElements.add(element);
    }

    return CoreArticleHarcApp(
      id.split(CoreArticle.uniqNameSep)[1],
      title: title,
      tags: tags,
      date: date,
      author: author,
      articleElements: articleElements
    );

  }

  // static Future<ArticleHarcApp?> downloadArticle(String id, {Function? onError}) async {
  //
  //   try {
  //     Response response = await defDio.get('https://gitlab.com/n3o2k7i8ch5/harcapp_data/-/raw/master/articles/$id.hrcpartcl');
  //
  //     if(response.statusCode == 200){
  //       String articleCode = response.data;
  //       saveStringAsFileToFolder(getArticlesFolderPath(ArticleSource.harcApp), articleCode);
  //       return fromJson(id, articleCode);
  //     }
  //   }catch(e){}
  //
  //   return null;
  // }

  // @override
  // @protected
  // Future<ImageProvider>? handleLoadCover() => null;

  @override
  @override
  Future<ImageProvider?> downloadCover() async {
    String downloadUrl = "https://gitlab.com/n3o2k7i8ch5/harcapp_data/raw/master/...";
    return null;
  }

}