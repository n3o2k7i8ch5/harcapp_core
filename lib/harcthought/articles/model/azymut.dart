import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as img;
import 'package:rss_dart/domain/atom_item.dart';

import 'article.dart';
import 'article_data.dart';
import 'article_source.dart';
import 'zhr_utils.dart';

mixin ArticleAzymutMixin on CoreArticle{

  static ArticleData fromAtomItem(AtomItem item) => ZHRUtils.fromAtomItem(
      ArticleSource.azymut, item
  );

  @override
  @protected
  Future<(img.Image?, img.Image?)> downloadCover() async => ZHRUtils.downloadCover(link);

}