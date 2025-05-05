import 'dart:io';

import 'package:dio/dio.dart';
import 'package:summit_parts/core/constants/storage_constants.dart';
import 'package:summit_parts/core/data/local/in_memory_storage_data_provider.dart';

class AuthorizationInterceptor extends Interceptor {
  AuthorizationInterceptor(this.inMemoryStorageDataProvider);

  final InMemoryStorageDataProvider inMemoryStorageDataProvider;

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
}
