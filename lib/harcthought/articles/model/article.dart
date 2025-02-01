
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:harcapp_core/comm_classes/date_to_str.dart';
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

  static const String paramImage = 'image';
  static const String paramImageSource = 'image_source';
  static const String paramAuthCode = 'auth_code';

  static const String paramArtclItems = 'items';
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
        required super.articleElements,
      });

  @protected
  Future<img.Image?> downloadCover();

  Future<ImageProvider?> loadCover() async {
    img.Image? image = await downloadCover();
    if (image == null) return null;
    Uint8List encodedImage = img.encodeJpg(image, quality: 80);
    return MemoryImage(encodedImage);
  }

  @override
  int get hashCode => uniqName.hashCode;

  @override
  bool operator == (Object other) => other is CoreArticle && uniqName == other.uniqName;

}
