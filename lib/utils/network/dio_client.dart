import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import './auth_interceptor.dart';

class DioClient {
  static const String _baseUrl = "http://192.168.2.115:8000/v2";
  // static const String _baseUrl = "http://192.168.26.183:8000/v2";

  DioClient() {
    dio.interceptors.add(
      LogInterceptor(
        error: true,
        responseBody: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
        logPrint: (o) => debugPrint(o.toString()),
      ),
    );

    _addAuthInterceptor();
  }

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      preserveHeaderCase: true,
      receiveDataWhenStatusError: true,
    ),
  );

  void _addAuthInterceptor() {
    dio.interceptors.add(
      AuthInterceptor(
        dio: dio,
      ),
    );
  }

  void addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
  }
}
