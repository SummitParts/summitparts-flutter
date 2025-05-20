import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/features/catalog/data/catalog_data_provider.dart';
import 'package:summit_parts/features/catalog/model/catalog.dart';

typedef CatalogPage = ({String id, int pageIndex});

final paginatedCatalogProvider = FutureProvider.autoDispose.family<Catalog, CatalogPage>(
  (ref, catalogPage) async => ref.read(catalogDataProvider).getCatalog(catalogPage.id, page: catalogPage.pageIndex + 1),
);
