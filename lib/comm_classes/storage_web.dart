import 'dart:html';

import 'package:flutter/services.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';


Future<dynamic> openAssetImpl(String assetPath, {bool webOpenInNewTab = false}) async {
  final ByteData bytes = await rootBundle.load(assetPath);
  String? mimeType = lookupMimeType(assetPath);
  var blob = Blob([bytes.buffer.asUint8List()], mimeType??'text/plain', 'native');

  String url = Url.createObjectUrlFromBlob(blob);

  AnchorElement anchor = AnchorElement()
    ..href = url
    ..download = basename(assetPath);

  if(webOpenInNewTab)
    anchor.target = "_blank";

  anchor.click();

  Url.revokeObjectUrl(url);
}
