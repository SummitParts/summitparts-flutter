import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/core/data/http/dio_provider.dart';
import 'package:summit_parts/features/catalog/model/catalog.dart';

final categoriesDataProvider = Provider.autoDispose<CategoriesDataProvider>((ref) {
  return CategoriesDataProvider(ref.read(dioProvider));
});

class CategoriesDataProvider {
  CategoriesDataProvider(this._dio);

  final Dio _dio;

  Future<Catalog> getCatalog(String id, {int page = 1, int limit = 10}) async {
    final response = await _dio.get('/catalog/$id', queryParameters: {
      'page': page,
      'limit': limit,
    });
    return Catalog.fromJson(response.data);
  }
}
