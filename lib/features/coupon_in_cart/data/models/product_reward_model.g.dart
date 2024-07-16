// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_reward_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductRewardModel _$ProductRewardModelFromJson(Map<String, dynamic> json) =>
    ProductRewardModel(
      id: json['productId'] as String?,
      name: json['name'] as String?,
      size: json['size'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductRewardModelToJson(ProductRewardModel instance) =>
    <String, dynamic>{
      'productId': instance.id,
      'name': instance.name,
      'size': instance.size,
      'quantity': instance.quantity,
    };
