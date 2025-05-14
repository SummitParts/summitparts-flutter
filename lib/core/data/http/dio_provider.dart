import 'package:dio/dio.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/core/constants/api_constants.dart';
import 'package:summit_parts/core/data/http/authorization_interceptor.dart';
import 'package:summit_parts/core/data/local/in_memory_storage_data_provider.dart';
import 'package:summit_parts/core/data/local/secure_storage_data_provider.dart';

const _defaultTimeout = Duration(seconds: 30);

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(baseUrl: ApiConstants.baseUrl, connectTimeout: _defaultTimeout, receiveTimeout: _defaultTimeout),
  );
  dio.transformer = BackgroundTransformer();

  dio.interceptors.addAll([
    AuthorizationInterceptor(ref.read(inMemoryStorageProvider), ref.read(secureStorageProvider), dio),
    LoggyDioInterceptor(),
  ]);

  return dio;
});
