import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:harcapp_core/comm_classes/dio.dart';
import 'package:harcapp_core/harcthought/articles/model/article_source.dart';
import 'package:harcapp_core/harcthought/articles/model/zhr_utils.dart';
import 'package:harcapp_core/logger.dart';
import 'package:rss_dart/domain/atom_feed.dart';
import 'package:rss_dart/domain/atom_item.dart';
import 'package:html_unescape/html_unescape.dart';

import 'model/article_data.dart';

class ArticleDataOrList {
  final ArticleData? _articleData;
  final List<ArticleData>? _list;

  const ArticleDataOrList(this._articleData, this._list);

  static ArticleDataOrList asList(List<ArticleData> list) => ArticleDataOrList(null, list);
  static ArticleDataOrList asSingle(ArticleData articleData) => ArticleDataOrList(articleData, null);

  bool get isList => _list != null;
  bool get isSingle => _articleData != null;

  ArticleData get articleData => _articleData!;
  List<ArticleData> get list => _list!;

  List<ArticleData> toList() => isList?_list!:[_articleData!];
}

abstract class BaseSourceArticleLoader{

  ArticleSource get source;

  static void sortByDate(List<ArticleData> articles) =>
      articles.sort((art1, art2) => art1.date.isBefore(art2.date)?1:-1);

  Stream<(
    ArticleDataOrList,

    // First non-null localId if all subsequent articles until the current
    // newestLocalIdSeen are non-null. Else should return null.
    String? newestLocalIdSeen,

    // Last non-null localId after the current oldestLocalIdSeen. Else should
    // return null.
    String? oldestLocalIdSeen,

    // Should return true if all articles after the current oldestLocalIdSeen
    // are non-null and the last one is returned. Else should return false.
    bool? isAllHistoryLoaded
  )> download(
    String? newestLocalIdSeen,
    String? oldestLocalIdSeen,
    bool isAllHistoryLoaded
  );

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

    sortByDate(cachedArticles);

    return (cachedArticles, invalidCacheIds);
  }

  FutureOr<void> cache(ArticleData articleData);

  FutureOr<void> cacheAll(List<ArticleData> articleDataList) async {
    for (ArticleData articleData in articleDataList)
      await cache(articleData);
  }

  FutureOr<void> saveNewestLocalIdSeen(String localId);
  FutureOr<String?> getNewestLocalIdSeen();

  FutureOr<void> saveOldestLocalIdSeen(String localId);
  FutureOr<String?> getOldestLocalIdSeen();

  FutureOr<void> saveIsAllHistoryLoaded(bool value);
  FutureOr<bool> getIsAllHistoryLoaded();

  const BaseSourceArticleLoader();

}

abstract class BaseArticleHarcAppLoader extends BaseSourceArticleLoader{

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
      Response response = await defDio.get(webCorsProxy(_articleUrl(localId)));

      Map jsonMap = jsonDecode(response.data);
      return ArticleData.fromJsonMap(localId, source, jsonMap);
    } catch(_){
      return null;
    }
  }

  static (List<String>, List<String>) getUnloadedIds(
    List<String> allIds,
    String? newestLocalIdSeen,
    String? oldestLocalIdSeen,
    bool isAllHistoryLoaded
  ){
    if(newestLocalIdSeen == null || oldestLocalIdSeen == null) return (allIds, []);

    if(isAllHistoryLoaded){
      int newestLocalIdSeenIdx = allIds.indexOf(newestLocalIdSeen);
      if(newestLocalIdSeenIdx == -1) return (allIds, []);
      else return (allIds.sublist(newestLocalIdSeenIdx), []);
    }

    int oldestLocalIdSeenIdx = allIds.indexOf(oldestLocalIdSeen);
    int newestLocalIdSeenIdx = allIds.indexOf(newestLocalIdSeen);

    List<String> newUnseenIds = allIds.sublist(oldestLocalIdSeenIdx + 1);
    List<String> oldUnseenIds = allIds.sublist(0, newestLocalIdSeenIdx);

    return (newUnseenIds, oldUnseenIds);

  }

  @override
  Stream<(
    ArticleDataOrList,

    // First non-null localId if all subsequent articles until the current
    // newestLocalIdSeen are non-null. Else should return null.
    String? newestLocalIdSeen,

    // Last non-null localId after the current oldestLocalIdSeen. Else should
    // return null.
    String? oldestLocalIdSeen,

    // Should return true if all articles after the current oldestLocalIdSeen
    // are non-null and the last one is returned. Else should return false.
    bool? isAllHistoryLoaded
  )> download(
    String? newestLocalIdSeen,
    String? oldestLocalIdSeen,
    bool isAllHistoryLoaded
  ) async* {
    if(!isAllHistoryLoaded) newestLocalIdSeen = null;

    List<String>? allIds = await downloadAllLocalIds();
    if(allIds == null) return;

    var (unloadedNewerIds, unloadedOlderIds) = getUnloadedIds(
      allIds,
      newestLocalIdSeen,
      oldestLocalIdSeen,
      isAllHistoryLoaded
    );

    // Go through all newer unloaded articles
    String? newestUninterruptedLocalIdSeen = unloadedNewerIds.isEmpty?null:unloadedNewerIds.first;
    bool previousWasNull = false;
    for(String localId in unloadedNewerIds){
      ArticleData? articleData = await _downloadSingle(localId);

      if(articleData == null) {
        previousWasNull = true;
        continue;
      }

      if(previousWasNull)
        newestUninterruptedLocalIdSeen = localId;

      yield (
        ArticleDataOrList.asSingle(articleData),
        localId == unloadedNewerIds.last?newestUninterruptedLocalIdSeen:null,
        null,
        null
      );
    }

    // Go through all older unloaded articles
    String? previousNonNullLocalId = null;
    bool oldestLocalIdSeenReturned = false;
    for(String localId in unloadedOlderIds){
      ArticleData? articleData = await _downloadSingle(localId);

      if(articleData == null) {

        if(!oldestLocalIdSeenReturned)
          yield (
            ArticleDataOrList.asList([]),
            null,
            previousNonNullLocalId,
            null
          );

        oldestLocalIdSeenReturned = true;
        continue;
      }

      previousNonNullLocalId = localId;

      yield (
        ArticleDataOrList.asSingle(articleData),

        null,

        // If last and not returned yet
        localId == unloadedOlderIds.last && !oldestLocalIdSeenReturned?
        previousNonNullLocalId:
        null,

        // If last and not returned yet
        localId == unloadedOlderIds.last && !oldestLocalIdSeenReturned?
        true:
        null
      );
    }

  }

}


abstract class _ArticleZhrLoader extends BaseSourceArticleLoader{

  static const fullPageSize = 40;

  String pageUrl(int page);

  final bool downloadCoverLinks;

  const _ArticleZhrLoader({this.downloadCoverLinks = false});

  Future<List<ArticleData>?> _responseToArticleData(Response response, String pageUrl) async {
    AtomFeed atomFeed;
    try {
      atomFeed = AtomFeed.parse(HtmlUnescape().convert(response.data));
    } catch (_){
      return null;
    }

    List<ArticleData> articles = [];
    for(AtomItem item in atomFeed.items) {
      String? imageUrl;
      if(downloadCoverLinks)
        try{
          String? articleLink = ZHRUtils.linkFromAtom(item);
          if(articleLink != null)
            imageUrl = await ZHRUtils.coverLinkFromHtmlLink(articleLink);
        } catch (_) {}

      try {
        articles.add(ZHRUtils.fromAtomItem(source, item, imageUrl: imageUrl));
      } catch (_) {}
    }
    return articles;
  }

  Future<List<ArticleData>?> _downloadPage(int page) async {
    String _pageUrl = pageUrl(page);
    try {
      Response response = await defDio.get(webCorsProxy(_pageUrl));
      logger.d('Downloaded page $page for ${source.name}');
      return await _responseToArticleData(response, _pageUrl);
    } on DioException catch(e){
      if(e.response == null) return null;
      return _responseToArticleData(e.response!, _pageUrl);
    } catch(_){
      return null;
    }
  }

  @override
  Stream<(
    ArticleDataOrList,
    String? newestLocalIdSeen,
    String? oldestLocalIdSeen,
    bool? isAllHistoryLoaded
  )> download(
    String? newestLocalIdSeen,
    String? oldestLocalIdSeen, // Not used
    bool isAllHistoryLoaded
  ) async* {
    if(!isAllHistoryLoaded) newestLocalIdSeen = null;

    Set<String> downloadedIds = {};

    int page = 0;
    String? updatedNewestLocalIdSeen = null;
    bool updatedNewestLocalIdSeenReturned = false;
    while(true) {
      List<ArticleData>? articles = await _downloadPage(page);

      if (articles == null || articles.isEmpty) return;

      if (updatedNewestLocalIdSeen == null && articles.isNotEmpty)
        updatedNewestLocalIdSeen = articles.first.localId;

      bool isLastPage = articles.length < fullPageSize;

      articles = articles.where((article) => !downloadedIds.contains(article.uniqName)).toList();
      downloadedIds.addAll(articles.map((article) => article.uniqName));

      if(newestLocalIdSeen != null)
        for (ArticleData article in articles)
          if (newestLocalIdSeen == article.localId) {
            articles = articles!.sublist(0, articles.indexOf(article));
            yield (
              ArticleDataOrList.asList(articles),
              updatedNewestLocalIdSeenReturned ? null : updatedNewestLocalIdSeen,
              null,
              isLastPage && !isAllHistoryLoaded?true:null,
            );
            return;
          }

      yield (
        ArticleDataOrList.asList(articles!),
        updatedNewestLocalIdSeenReturned?null:updatedNewestLocalIdSeen,
        null,
        isLastPage && !isAllHistoryLoaded?true:null,
      );

      updatedNewestLocalIdSeenReturned = true;
      page++;
    }

  }

}


abstract class BaseArticleAzymutLoader extends _ArticleZhrLoader{

  @override
  ArticleSource get source => ArticleSource.azymut;

  @override
  String pageUrl(int page) => 'https://azymut.zhr.pl/feed/atom/?paged=$page';

  const BaseArticleAzymutLoader({super.downloadCoverLinks = false});

}

abstract class BaseArticlePojutrzeLoader extends _ArticleZhrLoader{

  @override
  ArticleSource get source => ArticleSource.pojutrze;

  @override
  String pageUrl(int page) => 'https://pojutrze.zhr.pl/feed/atom/?paged=$page';

  const BaseArticlePojutrzeLoader({super.downloadCoverLinks = false});

}
