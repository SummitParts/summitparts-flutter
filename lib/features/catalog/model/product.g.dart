// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: json['id'] as String,
  name: json['description'] as String,
  longDescription: json['longDescription'] as String,
  imageUrl: _parseImageUrl(json['image'] as String),
  price: (json['price'] as num).toDouble(),
  productLine: json['productLine'] as String,
);
