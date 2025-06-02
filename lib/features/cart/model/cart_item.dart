import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:summit_parts/features/catalog/model/product.dart';

part 'cart_item.g.dart';

@JsonSerializable()
class CartItem extends Equatable {
  const CartItem({
    required this.cartDetailKey,
    required this.cartKey,
    required this.itemId,
    required this.quantity,
    required this.id,
    required this.name,
    required this.longDescription,
    required this.imageUrl,
    required this.price,
    required this.productLine,
  });

  final int cartDetailKey;
  final int cartKey;
  @JsonKey(name: 'itemID')
  final String itemId;
  final int quantity;
  final String id;
  @JsonKey(name: 'description')
  final String name;
  final String longDescription;
  @JsonKey(name: 'image', fromJson: _parseImageUrl)
  final String imageUrl;
  final double price;
  final String? productLine;

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);

  Product get product => Product(
    id: id,
    name: name,
    longDescription: longDescription,
    imageUrl: imageUrl,
    price: price,
    productLine: productLine,
  );

  @override
  List<Object?> get props => [
    id,
    name,
    longDescription,
    imageUrl,
    price,
    productLine,
    cartDetailKey,
    cartKey,
    itemId,
    quantity,
  ];
}

String _parseImageUrl(String imageName) {
  if (imageName.isEmpty) imageName = 'missing.jpg';
  return 'https://www.summitparts.com/shop/catalog/items/$imageName';
}
