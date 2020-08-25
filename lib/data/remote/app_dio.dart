import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app_template/app_config.dart';
import 'package:flutter_app_template/data/local/token_storage.dart';

class AppDio with DioMixin implements Dio {
  final TokenStorage tokenStorage;

  AppDio(this.tokenStorage, [BaseOptions options]) {
    options = BaseOptions(
      baseUrl: AppConfig.instance.apiBaseUrl,
      contentType: 'application/json',
      connectTimeout: 30000,
      sendTimeout: 30000,
      receiveTimeout: 30000,
    );

    this.options = options;
    if (!kReleaseMode) {
      interceptors.add(LogInterceptor(responseBody: true));
    }
    httpClientAdapter = DefaultHttpClientAdapter();
  }

  Future<Map<String, String>> getAuthHeader() async {
    final token = await tokenStorage.getToken();

    return {
      'token': token,
    };
  }
}
