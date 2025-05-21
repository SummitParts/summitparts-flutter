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

  Future<CartItem> addToCart(String productId, int quantity) async {
    final response = await _dio.post(
      '/cart',
      data: {'itemID': productId, 'quantity': quantity, 'unitOfMeasure': 'EA', 'unitPrice': 0},
    );
    return CartItem.fromJson(response.data);
  }

  Future<CartItem> updateItemInCart(String cartDetailKey) async {
    final response = await _dio.patch('/cart/$cartDetailKey', data: {'quantity': 0});
    return CartItem.fromJson(response.data);
  }

  Future<void> removeFromCart(String cartDetailKey) async {
    await _dio.delete('/cart/$cartDetailKey');
  }
}
