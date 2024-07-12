// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_take_away_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckTakeAwayResult _$CheckTakeAwayResultFromJson(Map<String, dynamic> json) =>
    CheckTakeAwayResult(
      orderItemInvalidList: (json['orderItemInvalidList'] as List<dynamic>)
          .map((e) => CheckProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CheckTakeAwayResultToJson(
        CheckTakeAwayResult instance) =>
    <String, dynamic>{
      'orderItemInvalidList': instance.orderItemInvalidList,
    };
