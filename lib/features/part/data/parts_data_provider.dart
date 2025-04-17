import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/core/data/http/dio_provider.dart';
import 'package:summit_parts/features/part/model/part.dart';

final partsDataProvider = Provider.autoDispose<PartsDataProvider>((ref) {
  return PartsDataProvider(ref.read(dioProvider));
});

class PartsDataProvider {
  PartsDataProvider(this._dio);

  final Dio _dio;

  Future<List<Part>> getAllParts() async {
    final response = await _dio.get('/v1/parts');
    return (response.data as List).map<Part>((e) => Part.fromJson(e)).toList();
  }

  Future<List<Part>> getFeaturedParts() async {
    final response = await _dio.get('/v1/parts?filter=featured');
    return (response.data as List).map<Part>((e) => Part.fromJson(e)).toList();
  }
}
