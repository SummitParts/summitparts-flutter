import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/core/constants/storage_constants.dart';
import 'package:summit_parts/core/data/local/secure_storage_data_provider.dart';
import 'package:summit_parts/features/auth/logic/user_provider.dart';
import 'package:summit_parts/features/cart/data/cart_data_provider.dart';
import 'package:summit_parts/features/cart/model/cart_item.dart';

final cartIdProvider = FutureProvider<String>((ref) async {
  return await ref.read(cartDataProvider).getCartIdOrCreateOne();
});

final cartItemsProvider = FutureProvider.autoDispose<List<CartItem>>((ref) async {
  final userProfile = await ref.read(userNotifierProvider.future);
  if (userProfile == null) {
    return [];
  }
  final secureStorage = ref.read(secureStorageProvider);
  String? cartId = await secureStorage.read(key: StorageConstants.cartIdKey);
  if (cartId == null) {
    return [];
  }
  return ref.read(cartDataProvider).getCart(cartId);
});

final addToCartProvider = FutureProvider.autoDispose.family<List<CartItem>, ({String productId, int quantity})>((
  ref,
  args,
) async {
  final secureStorage = ref.read(secureStorageProvider);
  String? cartId = await secureStorage.read(key: StorageConstants.cartIdKey);
  if (cartId == null) {
    cartId = await ref.read(cartDataProvider).getCartIdOrCreateOne();
    await secureStorage.write(key: StorageConstants.cartIdKey, value: cartId);
  }

  final result = await ref.read(cartDataProvider).addToCart(cartId, args.productId, args.quantity);
  ref.invalidate(cartItemsProvider);
  return result;
});

final removeFromCartProvider = FutureProvider.autoDispose.family<void, int>((ref, cartDetailKey) async {
  final result = await ref.read(cartDataProvider).removeFromCart(cartDetailKey);
  ref.invalidate(cartItemsProvider);
  return result;
});

final updateCartItemProvider = FutureProvider.autoDispose.family<CartItem, int>((ref, cartDetailKey) async {
  final result = await ref.read(cartDataProvider).updateItemInCart(cartDetailKey);
  ref.invalidate(cartItemsProvider);
  return result;
});
