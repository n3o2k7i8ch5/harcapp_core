import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:harcapp_core/comm_classes/dio.dart';
import 'package:harcapp_core/harcthought/articles/model/article_source.dart';
import 'package:harcapp_core/harcthought/articles/model/zhr_utils.dart';
import 'package:webfeed_plus/domain/atom_feed.dart';
import 'package:webfeed_plus/domain/atom_item.dart';
import 'package:html_unescape/html_unescape.dart';

import 'model/article_data.dart';

abstract class BaseArticleLoader{

  ArticleSource get source;

  FutureOr<(List<ArticleData>, String?)> download(String? newestLocalIdSeen);

  FutureOr<ArticleData?> getCached(String localId);

  FutureOr<List<String>> getAllCachedIds();

  FutureOr<(List<ArticleData>, List<String>)> getAllCached() async {
    List<String> cachedIds = await getAllCachedIds();
    List<ArticleData> cachedArticles = [];
    List<String> invalidCacheIds = [];
    for(String localId in cachedIds){
      ArticleData? articleData = await getCached(localId);
      if(articleData != null) cachedArticles.add(articleData);
      else invalidCacheIds.add(localId);
    }

    return (cachedArticles, invalidCacheIds);
  }

}

abstract class BaseArticleHarcAppLoader extends BaseArticleLoader{

  static const fileExtension = "hrcpartcl";

  static const String _indexUrl = 'https://gitlab.com/api/v4/projects/n3o2k7i8ch5%2Fharcapp_data/repository/tree?path=articles';
  static String _articleUrl(String localId) => 'https://gitlab.com/n3o2k7i8ch5/harcapp_data/-/raw/master/articles/$localId.$fileExtension';

  Future<List<String>?> downloadAllLocalIds() async {
    try {
      Response response = await defDio.get(_indexUrl);

      List<String> allFileNames = List.from(response.data).map((dynamic entry) =>
      Map.from(entry)['name']).toList().cast<String>();

      allFileNames.removeWhere((String fileName) => !fileName.endsWith(".$fileExtension"));
      List<String> localIds = allFileNames.map((name) => name.substring(0, name.length - fileExtension.length - 1)).toList();
      return localIds;
    } catch (_) {
      return null;
    }
  }

  @override
  ArticleSource get source => ArticleSource.harcApp;

  Future<ArticleData?> _downloadSingle(String localId) async {
    try {
      Response response = await defDio.get(_articleUrl(localId));

      Map jsonMap = jsonDecode(response.data);
      return ArticleData.fromJson(localId, source, jsonMap);
    } catch(_){
      return null;
    }
  }

  @override
  Future<(List<ArticleData>, String?)> download(String? newestLocalIdSeen) async {
    List<String>? allIds = await downloadAllLocalIds();
    if(allIds == null) return (<ArticleData>[], null);

    List<String> unloadedIds;
    if(newestLocalIdSeen == null)
      unloadedIds = allIds;
    else {
      int newestLocalIdSeenIdx = allIds.indexOf(newestLocalIdSeen);
      if(newestLocalIdSeenIdx == -1) unloadedIds = allIds;
      else unloadedIds = allIds.sublist(newestLocalIdSeenIdx);
    }

    List<ArticleData> articles = [];
    String? previousLocalId = newestLocalIdSeen;
    String? updatedNewestLocalIdSeen;
    for(String localId in unloadedIds){
      ArticleData? articleData = (await getCached(localId))??await _downloadSingle(localId);
      if(articleData != null) {
        articles.add(articleData);
        previousLocalId = localId;
      } else if(articleData == null && updatedNewestLocalIdSeen == null)
        updatedNewestLocalIdSeen = previousLocalId;

    }

    return (articles, updatedNewestLocalIdSeen);
  }

}


abstract class _ArticleZhrLoader extends BaseArticleLoader{

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
      return _responseToArticleData(response, _pageUrl);
    } on DioException catch(e){
      if(e.response == null) return null;
      return _responseToArticleData(e.response!, _pageUrl);
    } catch(_){
      return null;
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

    return (result, result.isEmpty?null:result.last.localId);
  }

}


abstract class ArticleAzymutLoader extends _ArticleZhrLoader{

  @override
  ArticleSource get source => ArticleSource.azymut;

  @override
  String pageUrl(int page) => 'https://azymut.zhr.pl/feed/atom/?paged=$page';

}

abstract class ArticlePojutrzeLoader extends _ArticleZhrLoader{

  @override
  ArticleSource get source => ArticleSource.pojutrze;

  @override
  String pageUrl(int page) => 'https://pojutrze.zhr.pl/feed/atom/?paged=$page';

}
