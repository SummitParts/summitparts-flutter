import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:summit_parts/features/catalog/model/product.dart';

part 'products.g.dart';

@JsonSerializable()
class Products extends Equatable {
  const Products({required this.items, required this.meta});

  final List<Product> items;
  final PaginationMeta meta;

  factory Products.fromJson(Map<String, dynamic> json) => _$ProductsFromJson(json);

  @override
  List<Object?> get props => [items, meta];
}

@JsonSerializable(fieldRename: FieldRename.none)
class PaginationMeta extends Equatable {
  const PaginationMeta({
    required this.totalItems,
    required this.itemCount,
    required this.itemsPerPage,
    required this.totalPages,
    required this.currentPage,
  });

  final int totalItems;
  final int itemCount;
  final int itemsPerPage;
  final int totalPages;
  final int currentPage;

  factory PaginationMeta.fromJson(Map<String, dynamic> json) => _$PaginationMetaFromJson(json);

  @override
  List<Object?> get props => [totalItems, itemCount, itemsPerPage, totalPages, currentPage];
}
