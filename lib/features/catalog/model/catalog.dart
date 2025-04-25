import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:summit_parts/features/catalog/model/category.dart';
import 'package:summit_parts/features/catalog/model/product.dart';
import 'package:summit_parts/features/catalog/model/products.dart';

part 'catalog.g.dart';

@JsonSerializable()
class Catalog extends Equatable {
  const Catalog({required this.categories, required this.products});

  final List<Category> categories;
  final Products products;

  factory Catalog.fromJson(Map<String, dynamic> json) => _$CatalogFromJson(json);

  @override
  List<Object?> get props => [categories, products];
}
