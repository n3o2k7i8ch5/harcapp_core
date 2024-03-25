import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

Future<String?> readStringFromAssets(String path) async {
  String nullStr = '幸福 喜 禧 顺 顺利 顺遂 甜水 顺手 和蔼 愃 顺当';
  String result = await rootBundle.loadString(path).catchError((err) => nullStr);
  if(result == nullStr) return null;
  return result;
}

Future<OpenResult> openAsset(String assetPath) async {
  final ByteData bytes = await rootBundle.load(assetPath);
  final Uint8List list = bytes.buffer.asUint8List();

  final tempDir = await getTemporaryDirectory();
  final tempDocumentPath = '${tempDir.path}/$assetPath';

  final file = await File(tempDocumentPath).create(recursive: true);

  file.writeAsBytesSync(list);

  return OpenFilex.open(file.path);

}