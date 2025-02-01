import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

const Duration defConnectionTimeout = Duration(seconds: 18);
const Duration defReceiveTimeout = Duration(seconds: 40);
const Duration defSendTimeout = Duration(seconds: 10);

Dio get defDio{
  Dio dio = Dio(BaseOptions(
    connectTimeout: defConnectionTimeout,
    receiveTimeout: defReceiveTimeout,
    sendTimeout: defSendTimeout,
  ));

  return dio;
}

String corsProxy(String url) => 'https://corsproxy.io/' + Uri.encodeComponent(url);

String webCorsProxy(String url) => kIsWeb ? corsProxy(url) : url;