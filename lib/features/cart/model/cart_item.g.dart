// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
  cartDetailKey: (json['cartDetailKey'] as num).toInt(),
  cartKey: (json['cartKey'] as num).toInt(),
  itemId: json['itemID'] as String,
  quantity: (json['quantity'] as num).toInt(),
  id: json['id'] as String,
  name: json['description'] as String,
  longDescription: json['longDescription'] as String,
  imageUrl: _parseImageUrl(json['image'] as String),
  price: (json['price'] as num).toDouble(),
  productLine: json['productLine'] as String?,
);
