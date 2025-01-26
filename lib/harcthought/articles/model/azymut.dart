import 'package:flutter/widgets.dart';
import 'package:webfeed_plus/domain/atom_item.dart';

import 'article.dart';
import 'article_data.dart';
import 'article_source.dart';
import 'zhr_utils.dart';

mixin ArticleAzymut on CoreArticle{

  @override
  ArticleSource get source => ArticleSource.azymut;

  static ArticleData fromAtomItem(AtomItem item) => ZHRUtils.fromAtomItem(item);

  @override
  @protected
  Future<ImageProvider?> downloadCover() async {
    return ZHRUtils.downloadCover(link);
  }

}