// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money_reward_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoneyRewardModel _$MoneyRewardModelFromJson(Map<String, dynamic> json) =>
    MoneyRewardModel(
      unit: $enumDecodeNullable(_$RewardUnitEnumMap, json['unit']),
      value: json['value'] as num?,
    );

Map<String, dynamic> _$MoneyRewardModelToJson(MoneyRewardModel instance) =>
    <String, dynamic>{
      'unit': instance.unit,
      'value': instance.value,
    };

const _$RewardUnitEnumMap = {
  RewardUnit.PERCENTAGE: 'PERCENTAGE',
  RewardUnit.MONEY: 'MONEY',
};
