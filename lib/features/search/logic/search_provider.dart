import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/features/catalog/model/products.dart';
import 'package:summit_parts/features/search/data/search_data_provider.dart';

final searchProductsNotifierProvider = AsyncNotifierProvider.autoDispose<SearchProductsNotifier, Products>(
  SearchProductsNotifier.new,
);

class SearchProductsNotifier extends AutoDisposeAsyncNotifier<Products> {
  @override
  Future<Products> build() async {
    return Products(items: [], meta: PaginationMeta.empty());
  }

  Future<void> search(String searchQuery) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.read(searchDataProvider).search(searchQuery));
  }

  void clear() {
    state = AsyncValue.data(Products(items: [], meta: PaginationMeta.empty()));
  }
}
