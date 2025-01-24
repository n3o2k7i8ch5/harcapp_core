import 'package:webfeed_plus/domain/atom_item.dart';

import 'article.dart';
import 'base_zhr.dart';

class ArticlePojutrze extends BaseZhrArticle{

  @override
  ArticleSource get source => ArticleSource.pojutrze;

  ArticlePojutrze(
      super.localId,
      { required super.title,
        required super.tags,
        required super.date,
        required super.author,
        required super.link,
        required super.articleElements
      });

  static ArticlePojutrze fromJson(String id, String code) {
    BaseZhrArticleData data = BaseZhrArticle.fromJson(id, code);

    return ArticlePojutrze(
        data.localId,
        title: data.title,
        tags: data.tags,
        date: data.date,
        author: data.author,
        link: data.link,
        articleElements: data.articleElements
    );
  }

  static ArticlePojutrze fromAtomItem(AtomItem item){
    BaseZhrArticleData data = BaseZhrArticle.fromAtomItem(item);

    return ArticlePojutrze(
        data.localId,
        title: data.title,
        tags: data.tags,
        date: data.date,
        author: data.author,
        link: data.link,
        articleElements: data.articleElements
    );
  }

}