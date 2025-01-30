import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:harcapp_core/comm_classes/dio.dart';
import 'package:harcapp_core/harcthought/articles/model/article_source.dart';
import 'package:harcapp_core/harcthought/articles/model/zhr_utils.dart';
import 'package:webfeed_plus/domain/atom_feed.dart';
import 'package:webfeed_plus/domain/atom_item.dart';
import 'package:html_unescape/html_unescape.dart';

import 'model/article_data.dart';

abstract class ArticleLoader{

  ArticleSource get source;

  FutureOr<(List<ArticleData>, String?)> download(String? newestLocalIdSeen);

  FutureOr<ArticleData?> getCached(String localId);

}

abstract class BaseArticleHarcAppLoader extends ArticleLoader{

  static const String _indexUrl = 'https://gitlab.com/api/v4/projects/n3o2k7i8ch5%2Fharcapp_data/repository/tree?path=articles';
  static String _articleUrl(String localId) => 'https://gitlab.com/n3o2k7i8ch5/harcapp_data/-/raw/master/articles/$localId.hrcpartcl';

  Future<List<String>> allLocalIds() async {
    Response response = await defDio.get(_indexUrl);

    if (response.statusCode != 200)
      return [];

    String data = response.data;
    List<Map> articleEntries = jsonDecode(data);
    List<String> localIds = articleEntries.map((Map entry) => entry['name']).toList().cast();

    return localIds;
  }

  @override
  ArticleSource get source => ArticleSource.harcApp;

  Future<ArticleData?> _downloadSingle(String localId) async {
    Response response = await defDio.get(_articleUrl(localId));

    if(response.statusCode != 200)
      return null;

    String articleCode = response.data;
    return ArticleData.fromJson(localId, source, articleCode);
  }

  @override
  Future<(List<ArticleData>, String?)> download(String? newestLocalIdSeen) async {
    List<String> allIds = await allLocalIds();

    List<String> unloadedIds;
    if(newestLocalIdSeen == null)
      unloadedIds = allIds;
    else {
      int newestLocalIdSeenIdx = allIds.indexOf(newestLocalIdSeen);
      unloadedIds = allIds.sublist(newestLocalIdSeenIdx);
    }

    List<ArticleData> articles = [];
    String? previousLocalId = newestLocalIdSeen;
    String? updatedNewestLocalIdSeen;
    for(String localId in unloadedIds){
      ArticleData? articleData = (await getCached(localId))??await _downloadSingle(localId);
      if(articleData != null)
        articles.add(articleData);
      else if(articleData == null && updatedNewestLocalIdSeen == null)
        updatedNewestLocalIdSeen = previousLocalId;

      previousLocalId = localId;
    }

    return (articles, updatedNewestLocalIdSeen);
  }

}


abstract class ArticleZhrLoader extends ArticleLoader{

  String pageUrl(int page);

  List<ArticleData> _responseToArticleData(Response response, String pageUrl){
    AtomFeed atomFeed;
    try {
      atomFeed = AtomFeed.parse(HtmlUnescape().convert(response.data));
    } catch (_){
      return [];
    }

    List<ArticleData> articles = [];
    for(AtomItem item in atomFeed.items??[])
      try {
        articles.add(ZHRUtils.fromAtomItem(source, item));
      } catch (_) {}

    return articles;
  }

  Future<List<ArticleData>?> _downloadPage(int page) async {
    String _pageUrl = pageUrl(page);
    try {
      Response response = await defDio.get(_pageUrl);
      if(response.statusCode != HttpStatus.ok)
        return null;

      return _responseToArticleData(response, _pageUrl);
    } on DioException catch(e){
      if(e.response == null) return null;
      return _responseToArticleData(e.response!, _pageUrl);
    }

  }

  @override
  Future<(List<ArticleData>, String?)> download(String? newestLocalIdSeen) async {

    Set<String> downloadedIds = {};
    List<ArticleData> result = [];

    int page = 0;
    while(true) {
      List<ArticleData> articles = await _downloadPage(page) ?? [];

      if (articles.isEmpty) break;

      bool doBreak = false;
      for (ArticleData article in articles) {
        if(newestLocalIdSeen != null && newestLocalIdSeen == article.uniqName){
          doBreak = true;
          break;
        }

        if(downloadedIds.contains(article.uniqName))
          continue;

        downloadedIds.add(article.uniqName);
        result.add(article);
      }

      if(doBreak || page == -1) break;

      page++;
    }

    return (result, result.isEmpty?null:result.last.uniqName);
  }

  @override
  FutureOr<ArticleData?> getCached(String localId) => null;

}


class ArticleAzymutLoader extends ArticleZhrLoader{

  @override
  ArticleSource get source => ArticleSource.azymut;

  @override
  String pageUrl(int page) => 'https://azymut.zhr.pl/feed/atom/?paged=$page';

}

class ArticlePojutrzeLoader extends ArticleZhrLoader{

  @override
  ArticleSource get source => ArticleSource.pojutrze;

  @override
  String pageUrl(int page) => 'https://pojutrze.zhr.pl/feed/atom/?paged=$page';

}
