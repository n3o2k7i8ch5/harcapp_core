import 'package:flutter/widgets.dart';
import 'package:webfeed_plus/domain/atom_item.dart';
import 'package:image/image.dart' as img;

import 'article.dart';
import 'article_data.dart';
import 'article_source.dart';
import 'zhr_utils.dart';

mixin ArticlePojutrzeMixin on CoreArticle{

  static ArticleData fromAtomItem(AtomItem item) => ZHRUtils.fromAtomItem(
      ArticleSource.pojutrze, item
  );

  @override
  @protected
  Future<(img.Image?, img.Image?)> downloadCover(bool? big) => ZHRUtils.downloadCover(link);

}