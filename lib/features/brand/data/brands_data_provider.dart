import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/core/data/http/dio_provider.dart';
import 'package:summit_parts/features/brand/model/brand.dart';

final brandsDataProvider = Provider.autoDispose<BrandsDataProvider>((ref) {
  return BrandsDataProvider(ref.read(dioProvider));
});

class BrandsDataProvider {
  BrandsDataProvider(this._dio);

  final Dio _dio;

  Future<List<Brand>> getAllBrands() async {
    final response = await _dio.get('/v1/brands');
    return (response.data as List).map<Brand>((e) => Brand.fromJson(e)).toList();
  }

  Future<List<Brand>> getFeaturedBrands() async {
    final response = await _dio.get('/v1/brands?filter=featured');
    return (response.data as List).map<Brand>((e) => Brand.fromJson(e)).toList();
  }
}
