import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/features/catalog/model/products.dart';
import 'package:summit_parts/features/search/data/search_data_provider.dart';

final searchQueryProvider = StateProvider.autoDispose<String>((ref) => '');

final paginatedSearchProductsProvider = FutureProvider.autoDispose.family<Products, int>((ref, pageIndex) async {
  final searchQuery = ref.watch(searchQueryProvider);
  if (searchQuery.trim().isEmpty) {
    return Products.empty();
  }
  return ref.read(searchDataProvider).search(searchQuery, page: pageIndex + 1);
});
