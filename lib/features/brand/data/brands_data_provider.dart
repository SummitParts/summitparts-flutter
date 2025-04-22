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
    return getFeaturedBrands();
    final response = await _dio.get('/v1/brands');
    return (response.data as List).map<Brand>((e) => Brand.fromJson(e)).toList();
  }

  Future<List<Brand>> getFeaturedBrands() async {
    await Future.delayed(Duration(seconds: 3));
    return [
      Brand(
        id: 1,
        name: 'WHIRLPOOL',
        imageUrl: 'https://www.summitparts.com/wp-content/uploads/2021/05/Shop-Whirlpool-parts-1.jpg',
      ),
      Brand(id: 2, name: 'LG', imageUrl: 'https://www.summitparts.com/wp-content/uploads/2021/05/Shop-LG-parts.png'),
      Brand(
        id: 3,
        name: 'MAYTAG',
        imageUrl: 'https://www.summitparts.com/wp-content/uploads/2021/05/Shop-Maytag-parts.jpg',
      ),
      Brand(
        id: 4,
        name: 'DEXTER',
        imageUrl: 'https://www.summitparts.com/wp-content/uploads/2021/05/Shop-Dexter-parts.jpg',
      ),
      Brand(
        id: 5,
        name: 'WASCOMAT',
        imageUrl: 'https://www.summitparts.com/wp-content/uploads/2021/05/wascomat-logo.jpeg',
      ),
      Brand(
        id: 6,
        name: 'GIRBAU',
        imageUrl: 'https://www.summitparts.com/wp-content/uploads/2021/05/Shop-Girbau-parts.jpg',
      ),
    ];
    // final response = await _dio.get('/v1/brands?filter=featured');
    // return (response.data as List).map<Brand>((e) => Brand.fromJson(e)).toList();
  }
}
