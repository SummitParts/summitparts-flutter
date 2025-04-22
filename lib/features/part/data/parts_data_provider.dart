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
    return getFeaturedParts();
    final response = await _dio.get('/v1/parts');
    return (response.data as List).map<Part>((e) => Part.fromJson(e)).toList();
  }

  Future<List<Part>> getFeaturedParts() async {
    await Future.delayed(Duration(seconds: 3));
    return [
      Part(id: 1, name: 'IGNITORS', imageUrl: 'https://www.summitparts.com/wp-content/uploads/2021/05/70367301.jpg'),
      Part(
        id: 2,
        name: 'DRAIN VALVES',
        imageUrl: 'https://www.summitparts.com/wp-content/uploads/2021/05/F200166302B.jpg',
      ),
      Part(id: 3, name: 'LAUNDRY CARTS', imageUrl: 'https://www.summitparts.com/wp-content/uploads/2021/05/100E.jpg'),
      Part(id: 4, name: 'BELTS', imageUrl: 'https://www.summitparts.com/wp-content/uploads/2021/05/3V_Belt_Opti.jpg'),
      Part(
        id: 5,
        name: 'INLET VALVES',
        imageUrl: 'https://www.summitparts.com/wp-content/uploads/2021/05/9379-183-001-O.jpg',
      ),
      Part(id: 6, name: 'RELAYS', imageUrl: 'https://www.summitparts.com/wp-content/uploads/2021/05/510109-O.jpg'),
    ];

    // final response = await _dio.get('/v1/parts?filter=featured');
    // return (response.data as List).map<Part>((e) => Part.fromJson(e)).toList();
  }
}
