import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/core/data/http/dio_provider.dart';
import 'package:summit_parts/features/catalog/model/products.dart';

final searchDataProvider = Provider.autoDispose<SearchDataProvider>((ref) {
  return SearchDataProvider(ref.read(dioProvider));
});

class SearchDataProvider {
  const SearchDataProvider(this._dio);

  final Dio _dio;

  Future<Products> search(String searchQuery, {int page = 1, int limit = 10}) async {
    final response = await _dio.get(
      '/catalog/product/search/$searchQuery',
      queryParameters: {'page': page, 'limit': limit},
    );
    return Products.fromJson(response.data);
  }
}
