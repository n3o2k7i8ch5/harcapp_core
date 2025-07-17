import 'package:harcapp_core/harcthought/common/short_read.dart';

class Gaweda extends ShortRead{

  final String? author;

  const Gaweda({
    required super.title,
    required super.titleColor,
    this.author,
    required super.fileName,
    required super.graphicalResource,
    super.soundResource,
    super.readingVoice,
  }):super(
      baseAssetsFolder: 'packages/harcapp_core/assets/gawedy',
  );

}