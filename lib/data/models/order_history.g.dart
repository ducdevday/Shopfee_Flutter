// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderHistory _$OrderHistoryFromJson(Map<String, dynamic> json) => OrderHistory(
      id: json['id'] as String,
      total: (json['total'] as num).toDouble(),
      orderType: $enumDecode(_$OrderTypeEnumMap, json['orderType']),
      productName: json['productName'] as String,
      productQuantity: json['productQuantity'] as int,
      statusLastEvent:
          $enumDecode(_$OrderStatusEnumMap, json['statusLastEvent']),
      timeLastEvent: DateTime.parse(json['timeLastEvent'] as String),
    );

Map<String, dynamic> _$OrderHistoryToJson(OrderHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'total': instance.total,
      'orderType': instance.orderType,
      'productName': instance.productName,
      'productQuantity': instance.productQuantity,
      'statusLastEvent': instance.statusLastEvent,
      'timeLastEvent': instance.timeLastEvent.toIso8601String(),
    };

const _$OrderTypeEnumMap = {
  OrderType.SHIPPING: 'SHIPPING',
  OrderType.ONSITE: 'ONSITE',
};

const _$OrderStatusEnumMap = {
  OrderStatus.CREATED: 'CREATED',
  OrderStatus.ACCEPTED: 'ACCEPTED',
  OrderStatus.DELIVERING: 'DELIVERING',
  OrderStatus.CANCELED: 'CANCELED',
  OrderStatus.SUCCEED: 'SUCCEED',
};
