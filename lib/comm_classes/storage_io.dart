import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

Future<OpenResult> openAssetImpl(String assetPath, {bool webOpenInNewTab = false}) async {
  final ByteData bytes = await rootBundle.load(assetPath);
  final Uint8List list = bytes.buffer.asUint8List();

  final tempDir = await getTemporaryDirectory();
  final tempDocumentPath = '${tempDir.path}/$assetPath';

  final file = await File(tempDocumentPath).create(recursive: true);
  file.writeAsBytesSync(list);

  return OpenFilex.open(file.path);
}
