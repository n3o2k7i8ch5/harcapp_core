import 'package:dio/dio.dart';

const Duration defConnectionTimeout = Duration(seconds: 18);
const Duration defReceiveTimeout = Duration(seconds: 40);
const Duration defSendTimeout = Duration(seconds: 10);

Dio get defDio => Dio(BaseOptions(
  connectTimeout: defConnectionTimeout,
  receiveTimeout: defReceiveTimeout,
  sendTimeout: defSendTimeout,
));