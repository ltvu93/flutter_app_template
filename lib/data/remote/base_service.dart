import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/models/api_error.dart';

abstract class BaseService {
  Future<dynamic> transformResponse(
    Future<Response> Function() dioCall,
  ) async {
    try {
      final response = await dioCall();

      return response.data['data'] ?? response.data;
    } catch (error) {
      if (error is DioError) {
        debugPrint('DioError: ${error.message}');

        switch (error.type) {
          case DioErrorType.connectTimeout:
          case DioErrorType.sendTimeout:
          case DioErrorType.receiveTimeout:
            throw NetworkTimeoutError();
          case DioErrorType.response:
            if (error.response!.statusCode == 401) {
              throw UnAuthenticateError();
            } else {
              throw ServerError.fromJson(error.response!.data['errors']);
            }
          case DioErrorType.cancel:
            break;
          case DioErrorType.other:
          default:
            throw UnknownError();
        }
      } else if (error is Error) {
        debugPrint('Error: ${error.stackTrace.toString()}');

        throw UnknownError();
      } else {
        debugPrint('UnKnown: $error');

        throw UnknownError();
      }
    }
  }
}
