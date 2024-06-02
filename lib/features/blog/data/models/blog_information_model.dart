

import 'package:json_annotation/json_annotation.dart';

part 'blog_information_model.g.dart';

@JsonSerializable()
class BlogInformationModel {
  final String id;
  final String title;
  final String summary;
  final String thumbnailUrl;
  final DateTime createdAt;

  const BlogInformationModel({
    required this.id,
    required this.title,
    required this.summary,
    required this.thumbnailUrl,
    required this.createdAt,
  });

  factory BlogInformationModel.fromJson(Map<String, dynamic> json) {
    return _$BlogInformationModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BlogInformationModelToJson(this);
  }
}
