import 'package:dio/dio.dart';

const Duration defConnectionTimeout = Duration(seconds: 18);
const Duration defReceiveTimeout = Duration(seconds: 40);
const Duration defSendTimeout = Duration(seconds: 10);

Dio get defDio{
  Dio dio = Dio(BaseOptions(
    connectTimeout: defConnectionTimeout,
    receiveTimeout: defReceiveTimeout,
    sendTimeout: defSendTimeout,
  ));

  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (error, handler) {
        // Do stuff here
        handler.reject(error); // Added this line to let error propagate outside the interceptor
      },
    ),
  );

  return dio;
}

