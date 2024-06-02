

import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';

part 'blog_detail_model.g.dart';

@JsonSerializable()
class BlogDetailModel {
  final String title;
  final String summary;
  final String content;
  final String imageUrl;
  final DateTime createdAt;

  const BlogDetailModel({
    required this.title,
    required this.summary,
    required this.content,
    required this.imageUrl,
    required this.createdAt,
  });

  factory BlogDetailModel.fromJson(Map<String, dynamic> json) {
    return _$BlogDetailModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BlogDetailModelToJson(this);
  }
}
