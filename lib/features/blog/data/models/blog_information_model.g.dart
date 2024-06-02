// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogInformationModel _$BlogInformationModelFromJson(
        Map<String, dynamic> json) =>
    BlogInformationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$BlogInformationModelToJson(
        BlogInformationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'summary': instance.summary,
      'thumbnailUrl': instance.thumbnailUrl,
      'createdAt': instance.createdAt.toIso8601String(),
    };
