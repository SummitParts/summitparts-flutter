// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
  cartDetailKey: (json['cartDetailKey'] as num).toInt(),
  cartKey: (json['cartKey'] as num).toInt(),
  itemId: json['itemId'] as String,
  quantity: json['quantity'] as String,
  id: json['id'] as String,
  name: json['description'] as String,
  imageUrl: _parseImageUrl(json['image'] as String),
  price: (json['price'] as num).toDouble(),
);
