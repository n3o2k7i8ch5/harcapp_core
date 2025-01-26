import 'package:flutter/widgets.dart';
import 'package:harcapp_core/comm_classes/date_to_str.dart';
import 'package:tuple/tuple.dart';
import 'package:image/image.dart' as img;

import 'article_data.dart';
import 'article_source.dart';
import 'common.dart';


abstract class CoreArticle extends ArticleData{

  static Map<String, Tuple2<String, int>>? altCoverUrls;

  // static List<Article>? all;
  // static SplayTreeMap<String, Article>? allMap;
  // static bool add(Article article){
  //   all ??= [];
  //   allMap ??= SplayTreeMap.of({});
  //
  //   if(allMap![article.uniqName] != null) return false;
  //   all!.add(article);
  //   allMap![article.uniqName] = article;
  //   ArticleSyncData.add(article);
  //   return true;
  // }

  // static Future<void> init() async {
  //   all = [];
  //   allMap = SplayTreeMap.of({});
  //
  //   for(ArticleSource source in ArticleSource.values) {
  //     await ArticleSyncData.init(source);
  //     addAll(readStoredArticles(source));
  //   }
  //
  //   sortByDate(all!);
  //
  // }

  // static void clearAll(){
  //   ArticleSyncData.clear();
  //   all!.clear();
  //   allMap!.clear();
  // }

  // static addAll(List<Article> articles){
  //   all ??= [];
  //   allMap ??= SplayTreeMap.of({});
  //
  //   for(Article article in articles) {
  //     ArticleSyncData.add(article);
  //     all!.add(article);
  //     allMap![article.uniqName] = article;
  //   }
  // }

  static const String uniqNameSep = '@';

  static const String paramTitle = 'title';
  static const String paramTags = 'tags';
  static const String paramAuthor = 'author';
  static const String paramDate = 'date';
  static const String paramLink = 'link';

  static const String paramImage = 'image';
  static const String paramImageSource = 'image_source';
  static const String paramAuthCode = 'auth_code';

  static const String paramArtclItems = 'items';
  static const String paramOtherArtCores = 'other_art_cores';

  static const String paramLiked = 'liked';
  static const String paramBookmarked = 'bookmarked';
  static const String paramSeen = 'seen';

  String get uniqName => source.name + uniqNameSep + localId;

  // final String _localId;
  //
  // final String title;
  // final List<String> tags;
  // final DateTime date;
  // final String author;
  String get dateString => dateToString(date, shortMonth: true, yearAbbr: 'A.D.');
  // final String link;
  // final List<ArticleElement> articleElements;

  ArticleSource get source;

  // int? seenCount;
  // int? likeCount;

  // String countToString(int? count){
  //
  //   if(count == null) return '-';
  //   if(count < 1000) return count.toString();
  //   if(count < 10000) return '${(count/1000).round()},${((count%1000)/100).round()} tys.';
  //   if(count < 1000000) return '${(count/1000).round()} tys.';
  //   if(count < 10000000) return '${(count/1000000).round()},${((count%1000000)/100000).round()} mln.';
  //   return '${(count/1000000).round()} mln.';
  //
  // }

  // String get seenCountStr => countToString(seenCount);
  // String get likeCountStr => countToString(likeCount);

  // Future<void> downloadStats() => ApiArticle.getStats(
  //     articleUniqName: uniqName,
  //     onSuccess: (seenCount, likeCount){
  //       this.seenCount = seenCount;
  //       this.likeCount = likeCount;
  //       logger.i('Loaded stats for article $uniqName');
  //     },
  //     onError: (e){
  //       logger.w('Failed to download stats for article $uniqName');
  //     }
  // );

  // static Future<img.Image> _coverFromUrl(String url) async{
  //
  //   var response = await get(Uri.parse(url));
  //
  //   img.Image image = img.decodeImage(response.bodyBytes.buffer.asUint8List())!;
  //
  //   image = img.copyResize(image, width: 1000);
  //   return image;
  // }

  // static Future<File> downloadSaveCover({
  //   required ArticleSource source,
  //   required String id,
  //   required String url,
  //   required int version
  // }) async {
  //   img.Image image = await compute(_coverFromUrl, url);
  //
  //   File file = File(getArticleCoverPath(source, id));
  //   await file.create(recursive: true);
  //   await file.writeAsBytes(Uint8List.fromList(img.encodeJpg(image, quality: 70)));
  //   ShaPref.setInt(ShaPref.SHA_PREF_HARCTHOUGHT_ARTICLES_COVER_VERSION_(id), version);
  //   return file;
  // }

  CoreArticle(
      super.localId,
      { required super.title,
        required super.tags,
        required super.author,
        required super.date,
        required super.link,
        required super.articleElements,
      }): assert(!localId.contains(uniqNameSep));
        // _localId = localId;

  // bool get downloaded => File(getArticleCorePath(source, uniqName)).existsSync();
  // String get imagePath => getArticleCoverPath(source, uniqName);

  // static String _lastSeenIdShaPrefKey(ArticleSource source) => ShaPref.SHA_PREF_HARCTHOUGHT_ARTICLES_LAST_SEEN_ID_(source);
  // static String? getLastSeenId(ArticleSource source) => ShaPref.getStringOrNull(_lastSeenIdShaPrefKey(source));
  // static void setLastSeenId(ArticleSource source, String? value){
  //   if(value == null)
  //     ShaPref.remove(_lastSeenIdShaPrefKey(source));
  //   else
  //     ShaPref.setString(_lastSeenIdShaPrefKey(source), value);
  // }

  // static Article? readFromPath(ArticleSource source, String path){
  //   String code = readFileAsString(path);
  //   String id = basename(path);
  //
  //   switch(source){
  //     case ArticleSource.harcApp:
  //       return ArticleHarcApp.fromJson(id, code);
  //     case ArticleSource.azymut:
  //       return ArticleAzymut.fromJson(id, code);
  //     case ArticleSource.pojutrze:
  //       return ArticlePojutrze.fromJson(id, code);
  //   }
  // }

  // static void sortByDate(List<Article> articles) =>
  //     articles.sort((art1, art2) => art1.date!.isBefore(art2.date!)?1:-1);

  // static List<Article> readStoredArticles(ArticleSource source){
  //
  //   Directory dir = Directory(getArticlesFolderPath(source));
  //   dir.createSync(recursive: true);
  //   List<FileSystemEntity> fileEntities = dir.listSync();
  //
  //   List<Article> articles = [];
  //   for(FileSystemEntity fileEntity in fileEntities)
  //     try {
  //       Article? article = Article.readFromPath(source, fileEntity.path);
  //       if(article != null) articles.add(article);
  //     } on FileNotFoundError{
  //       continue;
  //     }
  //
  //   sortByDate(articles);
  //
  //   return articles;
  //
  // }

  // void save(){
  //
  //   Map map = {};
  //
  //   map[Article.paramTitle] = title;
  //   map[Article.paramTags] = tags;
  //   map[Article.paramAuthor] = author;
  //   map[Article.paramDate] = date?.toIso8601String();
  //   map[Article.paramLink] = link;
  //   map[Article.paramArtclItems] = articleElements.map((item) => item.toJsonObject()).toList();
  //
  //   String saveFilePath = getArticleCorePath(source, uniqName);
  //   Directory(dirname(saveFilePath)).createSync(recursive: true);
  //
  //   logger.d('Saved article core to $saveFilePath');
  //
  //   saveStringAsFile(saveFilePath, jsonEncode(map));
  // }

  // static List<String> get bookmarkedIds => ShaPref.getStringList(ShaPref.SHA_PREF_HARCTHOUGHT_ARTICLES_BOOKMARKED, []);

  // static List<Article> get allBookmarked{
  //   List<Article> result = [];
  //   for(String id in bookmarkedIds) {
  //     Article? article = Article.allMap![id];
  //     if (article != null) result.add(article);
  //   }
  //   return result;
  // }

  // bool get isBookmarked => ShaPref.getStringList(ShaPref.SHA_PREF_HARCTHOUGHT_ARTICLES_BOOKMARKED, []).contains(uniqName);
  // void setBookmarked(bool value, {bool localOnly = false, bool synced = false}){
  //   List<String> ids = ShaPref.getStringList(ShaPref.SHA_PREF_HARCTHOUGHT_ARTICLES_BOOKMARKED, []);
  //   if(value) {
  //     if (ids.contains(uniqName)) return;
  //     ids.add(uniqName);
  //   }else
  //     ids.remove(uniqName);
  //
  //   ShaPref.setStringList(ShaPref.SHA_PREF_HARCTHOUGHT_ARTICLES_BOOKMARKED, ids);
  //   setSingleState(
  //       paramBookmarked,
  //       synced?
  //       SyncableParamSingleMixin.stateSynced:
  //       SyncableParamSingleMixin.stateNotSynced
  //   );
  //   if(!localOnly) synchronizer.post();
  // }

  // static List<String> get allSeenIds => ShaPref.getStringList(ShaPref.SHA_PREF_HARCTHOUGHT_ARTICLES_SEEN, []);

  // bool get isSeen => allSeenIds.contains(uniqName);
  // void setSeen(bool value, {bool localOnly = false, bool synced = false}){
  //   List<String> ids = allSeenIds;
  //   if(value) {
  //     if (ids.contains(uniqName)) return;
  //     ids.add(uniqName);
  //   }else
  //     ids.remove(uniqName);
  //
  //   ShaPref.setStringList(ShaPref.SHA_PREF_HARCTHOUGHT_ARTICLES_SEEN, ids);
  //   setSingleState(
  //       paramSeen,
  //       synced?
  //       SyncableParamSingleMixin.stateSynced:
  //       SyncableParamSingleMixin.stateNotSynced
  //   );
  //   if(!localOnly) synchronizer.post();
  // }

  // static List<String> get likedIds => ShaPref.getStringList(ShaPref.SHA_PREF_HARCTHOUGHT_ARTICLES_LIKED, []);

  // static List<Article> get allLiked{
  //   List<Article> result = [];
  //   for(String id in likedIds) {
  //     Article? article = Article.allMap![id];
  //     if (article != null) result.add(article);
  //   }
  //   return result;
  // }

  // bool get isLiked => likedIds.contains(uniqName);
  // void setLiked(bool value, {bool localOnly = false, bool synced = false}){
  //   List<String> ids = likedIds;
  //   if(value) {
  //     if (ids.contains(uniqName)) return;
  //     ids.add(uniqName);
  //   }else{
  //     ids.remove(uniqName);
  //   }
  //   ShaPref.setStringList(ShaPref.SHA_PREF_HARCTHOUGHT_ARTICLES_LIKED, ids);
  //   setSingleState(
  //       paramLiked,
  //       synced?
  //       SyncableParamSingleMixin.stateSynced:
  //       SyncableParamSingleMixin.stateNotSynced
  //   );
  //   if(!localOnly) synchronizer.post();
  // }


  // static LocalSemaphore semaphore = LocalSemaphore(3);

  // @protected
  // Future<ImageProvider?>? handleLoadCover();

  @protected
  Future<img.Image?> downloadCover();

  // Future<ImageProvider?> loadCover() async{
  //   await semaphore.acquire();
  //   ImageProvider? image = await handleLoadCover();
  //   semaphore.release();
  //   return image;
  // }

  // static const syncClassId = 'article';

  // @override
  // String get debugClassId => syncClassId;

  // @override
  // SyncableParam get parentParam => SyncGetRespNode.articleNode;

  // @override
  // String get paramId => uniqName;

  // @override
  // List<SyncableParam> get childParams => [
  //
  //   SyncableParamSingle(
  //     this,
  //     paramId: paramLiked,
  //     value: () => isLiked,
  //   ),
  //
  //   SyncableParamSingle(
  //     this,
  //     paramId: paramBookmarked,
  //     value: () => isBookmarked,
  //   ),
  //
  //   SyncableParamSingle(
  //     this,
  //     paramId: paramSeen,
  //     value: () => isSeen,
  //   ),
  //
  // ];

  // @override
  // void applySyncGetResp(ArticleGetResp resp) {
  //   setLiked(resp.liked, localOnly: true, synced: true);
  //   setBookmarked(resp.bookmarked, localOnly: true, synced: true);
  //   setSeen(resp.seen, localOnly: true, synced: true);
  // }

  @override
  int get hashCode => uniqName.hashCode;

  @override
  bool operator == (Object other) => other is CoreArticle && uniqName == other.uniqName;

}

// class ArticleSyncData extends Article{
//
//   static bool initialized = false;
//   static late List<String> allUniqNames;
//
//   static Future<void> init(ArticleSource source) async {
//     Directory dir = Directory(getArticlesFolderPath(source));
//     if(!await dir.exists()) await dir.create(recursive: true);
//     List files = await dir.list().toList();
//
//     List<String> uniqNames = [];
//     for(FileSystemEntity file in files)
//       uniqNames.add(basename(file.path));
//
//     initialized = true;
//     allUniqNames = uniqNames;
//   }
//
//   static void clear() => allUniqNames.clear();
//
//   static void add(Article article) =>
//       allUniqNames.add(article.uniqName);
//
//   static void addAll(List<Article> articles) {
//     for(Article article in articles)
//       allUniqNames.add(article.uniqName);
//   }
//   static List<ArticleSyncData> get all{
//     List<String> uniqNames = allUniqNames;
//     List<ArticleSyncData> result = [];
//     for(String uniqName in uniqNames)
//       result.add(ArticleSyncData.fromUniqName(uniqName));
//     return result;
//   }
//
//   final String sourceName;
//
//   @override
//   ArticleSource get source => ArticleSource.fromName(sourceName)??(throw Exception('Unknown source name: $sourceName'));
//
//   ArticleSyncData(this.sourceName, super.localId):super(
//     title: '',
//     tags: [],
//     author: '',
//     date: null,
//     articleElements: [],
//   );
//
//   static ArticleSyncData fromUniqName(String uniqName){
//     List<String> idParts = uniqName.split(Article.uniqNameSep);
//     return ArticleSyncData(idParts[0], idParts[1]);
//   }
//
//   @override
//   @protected
//   Future<ImageProvider<Object>?>? handleLoadCover() => throw UnimplementedError();
//
// }
