import 'package:image/image.dart' as img;

import 'article.dart';
import 'article_source.dart';


mixin ArticleHarcAppMixin on CoreArticle{

  @override
  ArticleSource get source => ArticleSource.harcApp;

  @override
  @override
  Future<(img.Image?, img.Image?)> downloadCover(bool? big) async {
    String downloadUrl = "https://gitlab.com/n3o2k7i8ch5/harcapp_data/raw/master/...";
    return (null, null);
  }

}