// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount_information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscountInformationModel _$DiscountInformationModelFromJson(
        Map<String, dynamic> json) =>
    DiscountInformationModel(
      orderDiscount: (json['orderDiscount'] as num?)?.toDouble(),
      shippingDiscount: (json['shippingDiscount'] as num?)?.toDouble(),
      productGiftList: (json['productGiftList'] as List<dynamic>?)
          ?.map((e) => ProductRewardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DiscountInformationModelToJson(
        DiscountInformationModel instance) =>
    <String, dynamic>{
      'orderDiscount': instance.orderDiscount,
      'shippingDiscount': instance.shippingDiscount,
      'productGiftList': instance.productGiftList,
    };
