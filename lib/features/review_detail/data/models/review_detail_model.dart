import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/core/common/enum/review_interaction_type.dart';

part 'review_detail_model.g.dart';

@JsonSerializable()
class ReviewDetailModel {
  final String id;
  final int star;
  final String? content;
  final String? avatarUrl;
  final String reviewerName;
  final int likeQuantity;
  final int dislikeQuantity;
  final DateTime? createdAt;
  final ReviewInteractionType? interaction;

  const ReviewDetailModel({
    required this.id,
    required this.star,
    this.content,
    this.avatarUrl,
    required this.reviewerName,
    required this.likeQuantity,
    required this.dislikeQuantity,
    this.createdAt,
    this.interaction,
  });

  factory ReviewDetailModel.fromJson(Map<String, dynamic> json) {
    return _$ReviewDetailModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ReviewDetailModelToJson(this);
  }
}
