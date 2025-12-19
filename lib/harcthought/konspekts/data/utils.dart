import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';

const String baseKonspektAssetsPath = 'packages/harcapp_core/assets/konspekty';

String urlToGitlabFile(String konspektName, String filename) => "https://gitlab.com/n3o2k7i8ch5/harcapp_data/raw/master/konspekts/${konspektName}/${filename}";
String urlToPoradnikFile(String poradnikName, String filename) => "https://gitlab.com/n3o2k7i8ch5/harcapp_data/raw/master/poradniki/${poradnikName}/${filename}";

String getCoverPath({
  required KonspektCategory category,
  required String konspektName,
  String? customCoverDirName
}) => '${baseKonspektAssetsPath}/${category.path}/${customCoverDirName??konspektName}/cover.webp';

String getKonspektJsonPath({
  required KonspektCategory category,
  required String konspektName,
}) => '${baseKonspektAssetsPath}/${category.path}/${konspektName}/konspekt.json';