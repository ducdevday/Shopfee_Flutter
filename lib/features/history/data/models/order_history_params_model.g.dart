// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderHistoryParamsModel _$OrderHistoryParamsModelFromJson(
        Map<String, dynamic> json) =>
    OrderHistoryParamsModel(
      historyStatusName: json['order_phases_status'] as String,
      page: json['page'] as int,
      size: json['size'] as int,
    );

Map<String, dynamic> _$OrderHistoryParamsModelToJson(
        OrderHistoryParamsModel instance) =>
    <String, dynamic>{
      'order_phases_status': instance.historyStatusName,
      'page': instance.page,
      'size': instance.size,
    };
