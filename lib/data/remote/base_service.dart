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
          case DioErrorType.CONNECT_TIMEOUT:
          case DioErrorType.RECEIVE_TIMEOUT:
          case DioErrorType.SEND_TIMEOUT:
            throw NetworkTimeoutError();
          case DioErrorType.RESPONSE:
            if (error.response.statusCode == 401) {
              throw UnAuthenticateError();
            } else {
              throw ServerError.fromJson(error.response.data['errors']);
            }
            break;
          case DioErrorType.CANCEL:
            break;
          case DioErrorType.DEFAULT:
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
