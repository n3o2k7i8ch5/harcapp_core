import 'storage_io.dart'
if(dart.library.io) 'storage_io.dart'
if(dart.library.html) 'storage_web.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

Future<String?> readStringFromAssets(String path) async {
  String nullStr = '幸福 喜 禧 顺 顺利 顺遂 甜水 顺手 和蔼 愃 顺当';
  String result = await rootBundle.loadString(path).catchError((err) => nullStr);
  if(result == nullStr) return null;
  return result;
}

Future<dynamic> openAsset(String assetPath, {bool webOpenInNewTab = false}) async {
  if(kIsWeb)
    return openAssetImpl(assetPath, webOpenInNewTab: webOpenInNewTab);
  else
    return openAssetImpl(assetPath);
}