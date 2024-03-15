// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptProductModel _$ReceiptProductModelFromJson(Map<String, dynamic> json) =>
    ReceiptProductModel(
      productId: json['productId'] as String?,
      name: json['name'] as String?,
      itemDetailList: (json['itemDetailList'] as List<dynamic>?)
          ?.map((e) =>
              ReceiptProductDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReceiptProductModelToJson(
        ReceiptProductModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'name': instance.name,
      'itemDetailList': instance.itemDetailList,
    };
