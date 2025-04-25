import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category extends Equatable {
  const Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.longDescription,
    required this.banner,
  });

  final String id;
  @JsonKey(name: 'description')
  final String name;
  @JsonKey(name: 'image', fromJson: _parseImageUrl)
  final String imageUrl;
  final String? longDescription;
  final String? banner;

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  @override
  List<Object?> get props => [id, name, imageUrl, longDescription, banner];
}

String _parseImageUrl(String imageName) {
  if (imageName.isEmpty) imageName = 'missing.jpg';
  return 'https://www.summitparts.com/shop/catalog/categories/$imageName';
}
