import 'package:dio/dio.dart';

import '../constants/app_strings.dart';
import 'api_exception.dart';

abstract final class ErrorHandler {
  static ApiException fromDio(DioException error) {
    final statusCode = error.response?.statusCode;
    final responseData = error.response?.data;
    final serverMessage = responseData is Map<String, dynamic>
        ? responseData['message'] as String?
        : null;
    final message = switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.sendTimeout => AppStrings.noInternet,
      DioExceptionType.connectionError => AppStrings.noInternet,
      _ => serverMessage ?? AppStrings.genericError,
    };
    return ApiException(message, statusCode: statusCode);
  }
}
