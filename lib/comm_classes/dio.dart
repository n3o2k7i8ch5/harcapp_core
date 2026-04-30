import 'package:dio/dio.dart';

const Duration defConnectionTimeout = Duration(seconds: 18);
const Duration defReceiveTimeout = Duration(seconds: 40);
const Duration defSendTimeout = Duration(seconds: 10);

// Mirrors flutter/foundation's `kIsWeb` without depending on Flutter, so this
// file can be compiled to plain JS for use inside Web Workers.
const bool _isJs = identical(0, 0.0);

Dio get defDio{
  Dio dio = Dio(BaseOptions(
    connectTimeout: defConnectionTimeout,
    receiveTimeout: defReceiveTimeout,
    sendTimeout: defSendTimeout,
  ));

  return dio;
}

String corsProxy(String url) => 'https://corsproxy.io/' + Uri.encodeComponent(url);

String webCorsProxy(String url) => _isJs ? corsProxy(url) : url;