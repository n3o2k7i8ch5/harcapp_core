
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
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
  Future<img.Image?> downloadCover();

  static LocalSemaphore loadCoverSemaphore = LocalSemaphore(3);

  Future<ImageProvider?> loadCover() async {
    await loadCoverSemaphore.acquire();
    img.Image? image = await downloadCover();
    loadCoverSemaphore.release();
    if (image == null) return null;
    Uint8List encodedImage = img.encodeJpg(image, quality: 80);
    return MemoryImage(encodedImage);
  }

  @override
  int get hashCode => uniqName.hashCode;

  @override
  bool operator == (Object other) => other is CoreArticle && uniqName == other.uniqName;

}
