import 'package:harcapp_core/harcthought/common/short_read.dart';

class Gaweda extends ShortRead{

  const Gaweda({
    required super.title,
    required super.titleColor,
    required super.fileName,
    required super.graphicalResource,
    super.soundResource,
    super.readingVoice,
  }):super(
      baseAssetsFolder: 'package/harcapp_core/assets/gawedy',
  );

}