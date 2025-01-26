import 'dart:convert';
import 'dart:io';

import 'storage_io.dart'
if(dart.library.io) 'storage_io.dart'
if(dart.library.html) 'storage_web.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

Future<ByteData?> readByteDataFromAssets(String path) async {
  try {
    return await rootBundle.load(path);
  } catch(e) {
    return null;
  }
}

Future<String?> readStringFromAssets(String path) async {
  try {
    return await rootBundle.loadString(path);
  } catch(e) {
    return null;
  }
}

Future<dynamic> openAsset(String assetPath, {bool webOpenInNewTab = false}) async {
  if(kIsWeb)
    return openAssetImpl(assetPath, webOpenInNewTab: webOpenInNewTab);
  else
    return openAssetImpl(assetPath);
}

Future<String> downloadFileAsString(String url) async {
  var httpClient = HttpClient();
  var request = await httpClient.getUrl(Uri.parse(url));
  var response = await request.close();
  var bytes = await consolidateHttpClientResponseBytes(response);
  return utf8.decode(bytes);
}

Future<String> downloadFile(String url) async {
  var httpClient = HttpClient();
  var request = await httpClient.getUrl(Uri.parse(url));
  var response = await request.close();
  var bytes = await consolidateHttpClientResponseBytes(response);
  return utf8.decode(bytes);
}