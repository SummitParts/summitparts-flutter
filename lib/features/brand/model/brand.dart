import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brand.g.dart';

@JsonSerializable()
class Brand extends Equatable {
  const Brand({required this.id, required this.name, required this.imageUrl});

  final int id;
  final String name;
  final String imageUrl;

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);

  @override
  List<Object?> get props => [id, name, imageUrl];
}
