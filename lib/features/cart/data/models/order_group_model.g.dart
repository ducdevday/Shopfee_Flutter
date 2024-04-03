// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderGroupModel _$OrderGroupModelFromJson(Map<String, dynamic> json) =>
    OrderGroupModel(
      json['productId'] as String,
      (json['itemDetailList'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$OrderGroupModelToJson(OrderGroupModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'itemDetailList': instance.itemDetailList,
    };
