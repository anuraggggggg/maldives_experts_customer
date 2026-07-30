import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constants/api_endpoints.dart';
import '../constants/app_constants.dart';
import '../exceptions/error_handler.dart';
import '../services/secure_storage_service.dart';
import 'api_interceptor.dart';

class DioClient {
  DioClient({SecureStorageService? secureStorage})
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          connectTimeout: AppConstants.connectTimeout,
          receiveTimeout: AppConstants.receiveTimeout,
          headers: const {'Accept': 'application/json'},
        ),
      ) {
    dio.interceptors.add(
      ApiInterceptor(secureStorage ?? SecureStorageService()),
    );
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }
  }

  final Dio dio;

  Future<Response<T>> get<T>(String path) async {
    try {
      return await dio.get<T>(path);
    } on DioException catch (error) {
      throw ErrorHandler.fromDio(error);
    }
  }
}
