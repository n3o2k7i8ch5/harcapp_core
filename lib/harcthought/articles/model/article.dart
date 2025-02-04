import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:harcapp_core/comm_classes/date_to_str.dart';
import 'package:semaphore_plus/semaphore_plus.dart';
import 'package:tuple/tuple.dart';
import 'package:image/image.dart' as img;

import 'article_data.dart';


abstract class CoreArticle extends ArticleData{

  static Map<String, Tuple2<String, int>>? altCoverUrls;

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

  String get dateString => dateToString(date, shortMonth: true, yearAbbr: 'A.D.');

  CoreArticle(
      super.localId,
      super.source,
      { required super.title,
        required super.tags,
        required super.author,
        required super.date,
        required super.link,
        required super.imageUrl,
        required super.articleElements,
      });

  @protected
  Future<(img.Image?, img.Image?)> downloadCover();

  FutureOr<void> onCoverDownloaded(img.Image? bigImage, img.Image? smallImage){}

  static Uint8List encodeCover(img.Image image) => img.encodeJpg(image, quality: 80);

  static LocalSemaphore downloadCoverSemaphore = LocalSemaphore(3);

  Future<Uint8List?> loadCover(bool big) async {
    await downloadCoverSemaphore.acquire();
    img.Image? bigImage;
    img.Image? smallImage;
    try {
      (bigImage, smallImage) = await downloadCover();
      await onCoverDownloaded(bigImage, smallImage);
    }finally{
      downloadCoverSemaphore.release();
    }
    if ((big && bigImage == null) || (!big && smallImage == null)) return null;
    try {
      return await compute(encodeCover, big?bigImage!:smallImage!);
    } catch(_){
      return null;
    }
  }

  @override
  int get hashCode => uniqName.hashCode;

  @override
  bool operator == (Object other) => other is CoreArticle && uniqName == other.uniqName;

}
