import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class Item extends Equatable {
  const Item({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.forBrand,
    required this.price,
    required this.description,
  });

  final String id;
  final String name;
  final String imageUrl;
  final String? forBrand;
  final double price;
  final String? description;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  @override
  List<Object?> get props => [id, name, imageUrl, forBrand, price, description];
}
