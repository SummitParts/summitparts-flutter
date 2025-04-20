import 'package:dio/dio.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/core/constants/api_constants.dart';

const _defaultTimeout = Duration(seconds: 30);

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(baseUrl: ApiConstants.baseUrl, connectTimeout: _defaultTimeout, receiveTimeout: _defaultTimeout),
  );
  dio.transformer = BackgroundTransformer();
  dio.interceptors.addAll([LoggyDioInterceptor()]);
  return dio;
});
