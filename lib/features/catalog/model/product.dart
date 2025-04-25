import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  final String id;
  @JsonKey(name: 'description')
  final String name;
  @JsonKey(name: 'image', fromJson: _parseImageUrl)
  final String imageUrl;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  @override
  List<Object?> get props => [id, name, imageUrl];
}

String _parseImageUrl(String imageName) {
  if (imageName.isEmpty) imageName = 'missing.jpg';
  return 'https://www.summitparts.com/shop/catalog/items/$imageName';
}
