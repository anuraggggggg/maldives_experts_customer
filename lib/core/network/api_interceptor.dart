import 'package:dio/dio.dart';

import '../constants/app_constants.dart';
import '../services/secure_storage_service.dart';

class ApiInterceptor extends Interceptor {
  ApiInterceptor(this._storage);

  final SecureStorageService _storage;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.read(AppConstants.authTokenKey);
    if (token != null) options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }
}
