import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:harcapp_core/comm_classes/single_computer/single_computer.dart';
import 'package:harcapp_core/comm_classes/single_computer/single_computer_listener.dart';
import 'package:harcapp_core/harcthought/articles/model/article_source.dart';
import 'package:harcapp_core/harcthought/articles/source_article_loader.dart';

import 'model/article_data.dart';

class ArticleLoaderListener extends SingleComputerListener<String>{

  final FutureOr<void> Function(ArticleDataOrList articleData)? onArticleData;

  ArticleLoaderListener({
    super.onStart,
    super.onError,
    super.onEnd,
    this.onArticleData
  });

}

class ArticleLoader extends SingleComputer<String, ArticleLoaderListener>{

  final Map<ArticleSource, BaseSourceArticleLoader> sourceArticleLoaders;
  final Function(ArticleSource source, List<ArticleData> articleDataList) onNewArticles;

  ArticleLoader({
    required this.sourceArticleLoaders,
    required this.onNewArticles,
  });
  
  static _initNewLoaded(){
    Map<ArticleSource, bool> newLoaded = {};
    for(ArticleSource source in ArticleSource.values)
      newLoaded[source] = false;

    return newLoaded;
  }

  static Map<ArticleSource, bool> newLoaded = _initNewLoaded();

  static bool get allLoaded => newLoaded.values.every((element) => element);

  static List<ArticleSource> get unloadedArticleSources => ArticleSource.values.where((source) => !newLoaded[source]!).toList();

  bool isSourceRunning(ArticleSource source) => running && restrictToSources.contains(source);

  String restrictToSourcesToString() => restrictToSources.map((s) => s.displayName).join(', ');

  @override
  String get computerName => 'ArticleLoader($restrictToSourcesToString)';

  FutureOr<String?> newestLocalIdsSeen(ArticleSource source) =>
      sourceArticleLoaders[source]!.getNewestLocalIdSeen();

  FutureOr<String?> oldestLocalIdsSeen(ArticleSource source) => sourceArticleLoaders[source]!.getOldestLocalIdSeen();

  FutureOr<bool> isAllHistoryLoaded(ArticleSource source) => sourceArticleLoaders[source]!.getIsAllHistoryLoaded();

  static Future<void> _downloadFromStream(
      ( dynamic port,
        BaseSourceArticleLoader loader,
        String? newestLocalIdsSeen,
        String? oldestLocalIdSeen,
        bool isAllHistoryLoaded
      ) args
  ) async {
    dynamic sendPort = args.$1;
    BaseSourceArticleLoader loader = args.$2;
    String? newestLocalIdsSeen = args.$3;
    String? oldestLocalIdSeen = args.$4;
    bool isAllHistoryLoaded = args.$5;

    await loader.download(
        newestLocalIdsSeen,
        oldestLocalIdSeen,
        isAllHistoryLoaded
    ).forEach(kIsWeb ? sendPort.add : sendPort.send);
  }

  Future<(String?, String?, bool?)> _downloadSource(
      ArticleSource source,
      { bool fullReload = false,
        FutureOr Function(ArticleDataOrList articleData)? onArticleData
      }
  ) async {

    String? updatedNewestLocalIdsSeen = null;
    String? updatedOldestLocalIdsSeen = null;
    bool? updatedIsAllHistoryLoaded = null;
    void onDataReceived(dynamic data) async {

      if(!(data is (ArticleDataOrList, String?, String?, bool?)))
        return;

      await onArticleData?.call(data.$1);
      if(data.$2 != null)
        updatedNewestLocalIdsSeen = data.$2!;

      if(data.$3 != null)
        updatedOldestLocalIdsSeen = data.$3!;

      if(data.$4 != null)
        updatedIsAllHistoryLoaded = data.$4!;
    }

    late StreamController<dynamic> webMockPort;
    late ReceivePort receivePort;

    if(kIsWeb){
      webMockPort = StreamController<dynamic>();
      webMockPort.stream.listen(onDataReceived);
    } else{
      receivePort = ReceivePort();
      receivePort.listen(onDataReceived);
    }

    var args = (
      kIsWeb ? webMockPort : receivePort.sendPort,
      sourceArticleLoaders[source]!,
      fullReload? null : await newestLocalIdsSeen(source),
      fullReload? null : await oldestLocalIdsSeen(source),
      fullReload? false : await isAllHistoryLoaded(source)
    );

    await compute(_downloadFromStream, args);

    return (updatedNewestLocalIdsSeen, updatedOldestLocalIdsSeen, updatedIsAllHistoryLoaded);

  }

  FutureOr<void> _callOnArticleListeners(ArticleDataOrList articleData) async {
    for(ArticleLoaderListener listener in listeners)
        await listener.onArticleData?.call(articleData);
  }

  late bool fullReload;
  late List<ArticleSource> restrictToSources;

  @override
  Future<bool> run({
    bool awaitFinish = false,
    bool fullReload = false,
    List<ArticleSource> restrictToSources = ArticleSource.values
  }){
    this.fullReload = fullReload;
    this.restrictToSources = restrictToSources;
    return super.run(awaitFinish: awaitFinish);
  }

  @override
  Future<void> perform() async {

    List<ArticleSource> sourcesToLoad = fullReload?
    ArticleSource.values:
    Set.from(unloadedArticleSources).intersection(Set.from(restrictToSources)).toList().cast();

    List<Future> futures = [];
    for(ArticleSource source in sourcesToLoad)
      futures.add(
          _downloadSource(
              source,
              fullReload: fullReload,
              onArticleData: (ArticleDataOrList dataOrList) async {
                await onNewArticles(source, dataOrList.toList());
                await _callOnArticleListeners(dataOrList);
              }
          )
      );

    List results = await Future.wait(futures);
    for(int i=0; i<sourcesToLoad.length; i++) {

      String? updatedNewestLocalIdsSeen = results[i].$1;
      String? updatedOldestLocalIdsSeen = results[i].$2;
      bool? updatedIsAllHistoryLoaded = results[i].$3;

      ArticleSource source = sourcesToLoad[i];

      if(updatedNewestLocalIdsSeen != null)
        await sourceArticleLoaders[source]!.saveNewestLocalIdSeen(updatedNewestLocalIdsSeen);

      if(updatedOldestLocalIdsSeen != null)
        await sourceArticleLoaders[source]!.saveOldestLocalIdSeen(updatedOldestLocalIdsSeen);

      if(updatedIsAllHistoryLoaded != null)
        await sourceArticleLoaders[source]!.saveIsAllHistoryLoaded(updatedIsAllHistoryLoaded);

      newLoaded[source] = true;
    }

  }

}