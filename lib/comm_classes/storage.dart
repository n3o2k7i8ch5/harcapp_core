import 'dart:io' as io;
import 'dart:html' as html;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

Future<String?> readStringFromAssets(String path) async {
  String nullStr = '幸福 喜 禧 顺 顺利 顺遂 甜水 顺手 和蔼 愃 顺当';
  String result = await rootBundle.loadString(path).catchError((err) => nullStr);
  if(result == nullStr) return null;
  return result;
}

Future<OpenResult> openAssetIO(String assetPath) async {
  final ByteData bytes = await rootBundle.load(assetPath);
  final Uint8List list = bytes.buffer.asUint8List();

  final tempDir = await getTemporaryDirectory();
  final tempDocumentPath = '${tempDir.path}/$assetPath';

  final file = await io.File(tempDocumentPath).create(recursive: true);
  file.writeAsBytesSync(list);

  return OpenFilex.open(file.path);
}

Future<void> openAssetWeb(String assetPath) async {
  final ByteData bytes = await rootBundle.load(assetPath);
  String? mimeType = lookupMimeType(assetPath);
  var blob = html.Blob([bytes.buffer.asUint8List()], mimeType??'text/plain', 'native');

  String url = html.Url.createObjectUrlFromBlob(blob);

  html.AnchorElement()
    ..href = url
    ..download = basename(assetPath)
    ..click();

  html.Url.revokeObjectUrl(url);

}

Future<bool> openAsset(String assetPath) async {
  if(kIsWeb){
    openAssetWeb(assetPath);
    return true;
  } else return openAssetIO(assetPath) == ResultType.done;
}