// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Catalog _$CatalogFromJson(Map<String, dynamic> json) => Catalog(
  id: json['id'] as String,
  description: json['description'] as String,
  longDescription: json['longDescription'] as String,
  bannerImageUrl: _parseBannerImageUrl(json['banner'] as String),
  categories: (json['categories'] as List<dynamic>)
      .map((e) => Category.fromJson(e as Map<String, dynamic>))
      .toList(),
  products: Products.fromJson(json['products'] as Map<String, dynamic>),
);
