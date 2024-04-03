import 'package:json_annotation/json_annotation.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel {
  final int star;
  final String? content;
  final DateTime? createdAt;

  const ReviewModel({
    required this.star,
    this.content,
    this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return _$ReviewModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ReviewModelToJson(this);
  }
}
