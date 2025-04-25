import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:summit_parts/features/catalog/model/category.dart';
import 'package:summit_parts/features/catalog/model/products.dart';

part 'catalog.g.dart';

@JsonSerializable()
class Catalog extends Equatable {
  const Catalog({
    required this.id,
    required this.description,
    required this.longDescription,
    required this.bannerImageUrl,
    required this.categories,
    required this.products,
  });

  final String id;
  final String description;
  final String longDescription;
  @JsonKey(name: 'banner', fromJson: _parseBannerImageUrl)
  final String? bannerImageUrl;
  final List<Category> categories;
  final Products products;

  factory Catalog.fromJson(Map<String, dynamic> json) => _$CatalogFromJson(json);

  @override
  List<Object?> get props => [id, description, longDescription, bannerImageUrl, categories, products];
}

String? _parseBannerImageUrl(String imageName) {
  if (imageName.isEmpty) return null;
  return 'https://www.summitparts.com/shop/catalog/categories/$imageName';
}
