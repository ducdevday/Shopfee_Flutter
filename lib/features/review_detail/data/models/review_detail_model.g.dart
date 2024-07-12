// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewDetailModel _$ReviewDetailModelFromJson(Map<String, dynamic> json) =>
    ReviewDetailModel(
      id: json['id'] as String,
      star: (json['star'] as num).toInt(),
      content: json['content'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      reviewerName: json['reviewerName'] as String,
      likeQuantity: (json['likeQuantity'] as num).toInt(),
      dislikeQuantity: (json['dislikeQuantity'] as num).toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      interaction: $enumDecodeNullable(
          _$ReviewInteractionTypeEnumMap, json['interaction']),
    );

Map<String, dynamic> _$ReviewDetailModelToJson(ReviewDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'star': instance.star,
      'content': instance.content,
      'avatarUrl': instance.avatarUrl,
      'reviewerName': instance.reviewerName,
      'likeQuantity': instance.likeQuantity,
      'dislikeQuantity': instance.dislikeQuantity,
      'createdAt': instance.createdAt?.toIso8601String(),
      'interaction': _$ReviewInteractionTypeEnumMap[instance.interaction],
    };

const _$ReviewInteractionTypeEnumMap = {
  ReviewInteractionType.LIKE: 'LIKE',
  ReviewInteractionType.DISLIKE: 'DISLIKE',
};
