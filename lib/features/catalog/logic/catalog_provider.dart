import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/features/catalog/data/categories_data_provider.dart';
import 'package:summit_parts/features/catalog/model/catalog.dart';

final catalogProvider = FutureProvider.autoDispose.family<Catalog, String>((ref, id) async {
  return ref.read(categoriesDataProvider).getCatalog(id);
});
