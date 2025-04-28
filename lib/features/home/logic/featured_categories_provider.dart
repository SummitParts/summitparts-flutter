import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/features/catalog/model/category.dart';
import 'package:summit_parts/features/home/data/featured_categories_data_provider.dart';

final featuredPartsProvider = FutureProvider.autoDispose<List<Category>>((ref) async {
  return ref.read(featuredCategoriesDataProvider).getFeaturedLaundryParts();
});

final featuredBrandsProvider = FutureProvider.autoDispose<List<Category>>((ref) async {
  return ref.read(featuredCategoriesDataProvider).getFeaturedBrands();
});
