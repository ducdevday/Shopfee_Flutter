// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventLogModel _$EventLogModelFromJson(Map<String, dynamic> json) =>
    EventLogModel(
      orderStatus:
          $enumDecodeNullable(_$OrderStatusEnumMap, json['orderStatus']),
      time: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      description: json['description'] as String?,
      note: json['note'] as String?,
      actor: $enumDecodeNullable(_$ActorTypeEnumMap, json['actor']),
    );

Map<String, dynamic> _$EventLogModelToJson(EventLogModel instance) =>
    <String, dynamic>{
      'orderStatus': instance.orderStatus,
      'createdAt': instance.time?.toIso8601String(),
      'description': instance.description,
      'note': instance.note,
      'actor': instance.actor,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.CREATED: 'CREATED',
  OrderStatus.ACCEPTED: 'ACCEPTED',
  OrderStatus.CANCELLATION_REQUEST: 'CANCELLATION_REQUEST',
  OrderStatus.CANCELLATION_REQUEST_REFUSED: 'CANCELLATION_REQUEST_REFUSED',
  OrderStatus.CANCELLATION_REQUEST_ACCEPTED: 'CANCELLATION_REQUEST_ACCEPTED',
  OrderStatus.PENDING_PICK_UP: 'PENDING_PICK_UP',
  OrderStatus.IN_DELIVERY: 'IN_DELIVERY',
  OrderStatus.NOT_RECEIVED: 'NOT_RECEIVED',
  OrderStatus.CANCELED: 'CANCELED',
  OrderStatus.SUCCEED: 'SUCCEED',
};

const _$ActorTypeEnumMap = {
  ActorType.EMPLOYEE: 'EMPLOYEE',
  ActorType.USER: 'USER',
  ActorType.AUTOMATIC: 'AUTOMATIC',
};
