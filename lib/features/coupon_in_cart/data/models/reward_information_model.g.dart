// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RewardInformationModel _$RewardInformationModelFromJson(
        Map<String, dynamic> json) =>
    RewardInformationModel(
      productRewardList: (json['productRewardList'] as List<dynamic>?)
          ?.map((e) => ProductRewardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      moneyReward: json['moneyReward'] == null
          ? null
          : MoneyRewardModel.fromJson(
              json['moneyReward'] as Map<String, dynamic>),
      subjectInformation: json['subjectInformation'] == null
          ? null
          : SubjectRewardModel.fromJson(
              json['subjectInformation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RewardInformationModelToJson(
        RewardInformationModel instance) =>
    <String, dynamic>{
      'productRewardList': instance.productRewardList,
      'moneyReward': instance.moneyReward,
      'subjectInformation': instance.subjectInformation,
    };
