import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/features/brand/data/brands_data_provider.dart';
import 'package:summit_parts/features/brand/model/brand.dart';

final featuredBrandsProvider = FutureProvider.autoDispose<List<Brand>>((ref) async {
  return ref.read(brandsDataProvider).getFeaturedBrands();
});

final brandsProvider = FutureProvider.autoDispose<List<Brand>>((ref) async {
  return ref.read(brandsDataProvider).getAllBrands();
});
