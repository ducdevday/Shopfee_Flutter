// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderHistoryModel _$OrderHistoryModelFromJson(Map<String, dynamic> json) =>
    OrderHistoryModel(
      id: json['id'] as String?,
      total: (json['total'] as num?)?.toDouble(),
      orderType: $enumDecodeNullable(_$OrderTypeEnumMap, json['orderType']),
      productName: json['productName'] as String?,
      productQuantity: json['productQuantity'] as int?,
      statusLastEvent:
          $enumDecodeNullable(_$OrderStatusEnumMap, json['statusLastEvent']),
      timeLastEvent: json['timeLastEvent'] == null
          ? null
          : DateTime.parse(json['timeLastEvent'] as String),
    );

Map<String, dynamic> _$OrderHistoryModelToJson(OrderHistoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'total': instance.total,
      'orderType': instance.orderType,
      'productName': instance.productName,
      'productQuantity': instance.productQuantity,
      'statusLastEvent': instance.statusLastEvent,
      'timeLastEvent': instance.timeLastEvent?.toIso8601String(),
    };

const _$OrderTypeEnumMap = {
  OrderType.SHIPPING: 'SHIPPING',
  OrderType.ONSITE: 'ONSITE',
};

const _$OrderStatusEnumMap = {
  OrderStatus.CREATED: 'CREATED',
  OrderStatus.ACCEPTED: 'ACCEPTED',
  OrderStatus.CANCELLATION_REQUEST: 'CANCELLATION_REQUEST',
  OrderStatus.CANCELLATION_REQUEST_REFUSED: 'CANCELLATION_REQUEST_REFUSED',
  OrderStatus.CANCELLATION_REQUEST_ACCEPTED: 'CANCELLATION_REQUEST_ACCEPTED',
  OrderStatus.DELIVERING: 'DELIVERING',
  OrderStatus.SUCCEED: 'SUCCEED',
  OrderStatus.CANCELED: 'CANCELED',
};
