import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/features/catalog/model/products.dart';
import 'package:summit_parts/features/search/data/search_data_provider.dart';

final searchQueryProvider = StateProvider.autoDispose<String>((ref) => '');

final paginatedSearchProductsProvider = FutureProvider.autoDispose.family<Products, int>((ref, pageIndex) async {
  final searchQuery = ref.watch(searchQueryProvider);
  if (searchQuery.trim().isEmpty) {
    return Products.empty();
  }
  final searchResult = await ref.read(searchDataProvider).search(searchQuery, page: pageIndex + 1);
  ref.keepAlive();
  return searchResult;
});

final searchProductsCountProvider = Provider.autoDispose<AsyncValue<int>>((ref) {
  return ref.watch(paginatedSearchProductsProvider(0)).whenData((products) => products.meta.totalItems);
});
