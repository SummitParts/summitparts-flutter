import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/core/data/http/dio_provider.dart';
import 'package:summit_parts/features/cart/model/cart_item.dart';

final cartDataProvider = Provider.autoDispose<CartDataProvider>((ref) {
  return CartDataProvider(ref.read(dioProvider));
});

class CartDataProvider {
  const CartDataProvider(this._dio);

  final Dio _dio;

  Future<List<CartItem>> getCart() async {
    final response = await _dio.get('/cart');
    return (response.data as List).map((item) => CartItem.fromJson(item)).toList();
  }

  Future<dynamic> addToCart(String productId) async {
    final response = await _dio.post(
      '/cart',
      data: {'comment': 'string', 'itemID': 'string', 'quantity': 0, 'unitOfMeasure': 'string', 'unitPrice': 0},
    );
    return response.data;
  }

  Future<dynamic> updateItemInCart(String cartDetailKey) async {
    final response = await _dio.patch('/cart/$cartDetailKey', data: {'quantity': 0});
    return response.data;
  }

  Future<dynamic> removeFromCart(String cartDetailKey) async {
    final response = await _dio.delete('/cart/$cartDetailKey');
    return response.data;
  }
}
