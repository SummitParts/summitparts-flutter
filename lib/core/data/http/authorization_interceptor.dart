import 'dart:io';

import 'package:dio/dio.dart';
import 'package:summit_parts/core/constants/api_constants.dart';
import 'package:summit_parts/core/constants/storage_constants.dart';
import 'package:summit_parts/core/data/local/in_memory_storage_data_provider.dart';
import 'package:summit_parts/core/data/local/secure_storage_data_provider.dart';
import 'package:summit_parts/features/auth/model/sign_in_response.dart';

class AuthorizationInterceptor extends Interceptor {
  AuthorizationInterceptor(this.inMemoryStorageDataProvider, this.secureStorageDataProvider, this.dio);

  final InMemoryStorageDataProvider inMemoryStorageDataProvider;
  final SecureStorageDataProvider secureStorageDataProvider;
  final Dio dio;
  bool _isRefreshing = false;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (inMemoryStorageDataProvider.containsKey(key: StorageConstants.accessTokenKey)) {
      options.headers.addAll({
        HttpHeaders.authorizationHeader:
            'Bearer ${inMemoryStorageDataProvider.get<String>(key: StorageConstants.accessTokenKey)!}',
      });
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;
      try {
        // Get the refresh token
        final refreshToken = inMemoryStorageDataProvider.get<String>(key: StorageConstants.refreshTokenKey);
        if (refreshToken != null) {
          // Call refresh token endpoint
          // Create a base dio instance without interceptors for the auth interceptor to use
          final refreshDio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

          final response = await refreshDio.post(
            '/auth/refresh',
            options: Options(headers: {HttpHeaders.authorizationHeader: 'Bearer $refreshToken'}),
          );

          final signInResponse = SignInResponse.fromJson(response.data);
          // Update tokens in storage
          inMemoryStorageDataProvider.put(key: StorageConstants.accessTokenKey, value: signInResponse.accessToken);
          inMemoryStorageDataProvider.put(key: StorageConstants.refreshTokenKey, value: signInResponse.refreshToken);
          await secureStorageDataProvider.write(
            key: StorageConstants.accessTokenKey,
            value: signInResponse.accessToken,
          );
          await secureStorageDataProvider.write(
            key: StorageConstants.refreshTokenKey,
            value: signInResponse.refreshToken,
          );

          // Retry the original request
          final options = err.requestOptions;
          options.headers[HttpHeaders.authorizationHeader] = 'Bearer ${signInResponse.accessToken}';

          final retryResponse = await dio.fetch(options);
          handler.resolve(retryResponse);
          _isRefreshing = false;
          return;
        }
      } catch (e) {
        // If refresh fails, clear tokens and let the error propagate
        inMemoryStorageDataProvider.delete(key: StorageConstants.accessTokenKey);
        inMemoryStorageDataProvider.delete(key: StorageConstants.refreshTokenKey);
        await secureStorageDataProvider.delete(key: StorageConstants.accessTokenKey);
        await secureStorageDataProvider.delete(key: StorageConstants.refreshTokenKey);
      } finally {
        _isRefreshing = false;
      }
    }
    handler.next(err);
  }
}
