// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_reward_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductRewardModel _$ProductRewardModelFromJson(Map<String, dynamic> json) =>
    ProductRewardModel(
      id: json['productId'] as String?,
      name: json['productName'] as String?,
      size: json['productSize'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductRewardModelToJson(ProductRewardModel instance) =>
    <String, dynamic>{
      'productId': instance.id,
      'productName': instance.name,
      'productSize': instance.size,
      'quantity': instance.quantity,
    };
