import 'dart:convert';

import 'package:dio/dio.dart';

import 'dio.dart';
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

Future<String?> downloadFileAsString(String url, {bool webCors = false}) async {
  try {
    Response response = await defDio.get(
      webCors ? webCorsProxy(url) : url,
      options: Options(responseType: ResponseType.bytes)
    );
    return utf8.decode(response.data);
  } catch(e){
    return null;
  }
}

Future<String?> downloadFile(String url, {bool webCors = false}) async {
  try {
    Response response = await defDio.get(
      webCors ? webCorsProxy(url) : url,
      options: Options(responseType: ResponseType.plain)
    );
    return response.data;
  } catch(e){
    return null;
  }
}