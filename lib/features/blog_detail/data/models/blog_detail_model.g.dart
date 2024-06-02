// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogDetailModel _$BlogDetailModelFromJson(Map<String, dynamic> json) =>
    BlogDetailModel(
      title: json['title'] as String,
      summary: json['summary'] as String,
      content: json['content'] as String,
      imageUrl: json['imageUrl'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$BlogDetailModelToJson(BlogDetailModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'summary': instance.summary,
      'content': instance.content,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt.toIso8601String(),
    };
