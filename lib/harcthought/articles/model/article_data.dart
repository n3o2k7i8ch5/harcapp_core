import 'common.dart';

class ArticleData{

  final String localId;
  final String title;
  final List<String> tags;
  final DateTime date;
  final String author;
  final String link;
  final List<ArticleElement> articleElements;

  const ArticleData(
      this.localId,
      { required this.title,
        required this.tags,
        required this.date,
        required this.author,
        required this.link,
        required this.articleElements
      });

}