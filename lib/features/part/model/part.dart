import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'part.g.dart';

@JsonSerializable()
class Part extends Equatable {
  const Part({required this.id, required this.name, required this.imageUrl});

  final int id;
  final String name;
  final String imageUrl;

  factory Part.fromJson(Map<String, dynamic> json) => _$PartFromJson(json);

  @override
  List<Object?> get props => [id, name, imageUrl];
}
