// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventLog _$EventLogFromJson(Map<String, dynamic> json) => EventLog(
      $enumDecode(_$OrderStatusEnumMap, json['orderStatus']),
      DateTime.parse(json['time'] as String),
      json['description'] as String?,
      json['makerByEmployee'] as bool?,
    );

Map<String, dynamic> _$EventLogToJson(EventLog instance) => <String, dynamic>{
      'orderStatus': instance.orderStatus,
      'time': instance.time.toIso8601String(),
      'description': instance.description,
      'makerByEmployee': instance.makerByEmployee,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.CREATED: 'CREATED',
  OrderStatus.ACCEPTED: 'ACCEPTED',
  OrderStatus.DELIVERING: 'DELIVERING',
  OrderStatus.CANCELED: 'CANCELED',
  OrderStatus.SUCCEED: 'SUCCEED',
};
