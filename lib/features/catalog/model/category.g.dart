// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  id: json['id'] as String,
  name: json['description'] as String,
  imageUrl: _parseImageUrl(json['image'] as String),
  longDescription: json['longDescription'] as String?,
  banner: json['banner'] as String?,
);
