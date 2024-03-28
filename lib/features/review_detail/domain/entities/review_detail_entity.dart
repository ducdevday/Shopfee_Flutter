import 'package:flutter/material.dart';
import 'package:shopfee/core/common/enum/review_interaction_type.dart';
import 'package:shopfee/features/review_detail/data/models/review_detail_model.dart';

class ReviewDetailEntity {
  final String id;
  final int star;
  final String? content;
  final String? avatarUrl;
  final String reviewerName;
  final int likeQuantity;
  final int dislikeQuantity;
  final DateTime? createdAt;
  final ReviewInteractionType? interaction;

  const ReviewDetailEntity({
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

  factory ReviewDetailEntity.fromModel(ReviewDetailModel model) {
    return ReviewDetailEntity(
        id: model.id,
        star: model.star,
        content: model.content,
        avatarUrl: model.avatarUrl,
        reviewerName: model.reviewerName,
        likeQuantity: model.likeQuantity,
        dislikeQuantity: model.dislikeQuantity,
        createdAt: model.createdAt,
        interaction: model.interaction);
  }

  ReviewDetailEntity copyWith({
    String? id,
    int? star,
    String? content,
    String? avatarUrl,
    String? reviewerName,
    int? likeQuantity,
    int? dislikeQuantity,
    DateTime? createdAt,
    ValueGetter<ReviewInteractionType?>? interaction,
  }) {
    return ReviewDetailEntity(
      id: id ?? this.id,
      star: star ?? this.star,
      content: content ?? this.content,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      reviewerName: reviewerName ?? this.reviewerName,
      likeQuantity: likeQuantity ?? this.likeQuantity,
      dislikeQuantity: dislikeQuantity ?? this.dislikeQuantity,
      createdAt: createdAt ?? this.createdAt,
      interaction: interaction != null ? interaction() : this.interaction,
    );
  }
}
