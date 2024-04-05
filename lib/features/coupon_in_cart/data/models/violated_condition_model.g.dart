// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'violated_condition_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViolatedConditionModel _$ViolatedConditionModelFromJson(
        Map<String, dynamic> json) =>
    ViolatedConditionModel(
      minPurchaseCondition: json['minPurchaseCondition'] == null
          ? null
          : MinPurchaseConditionModel.fromJson(
              json['minPurchaseCondition'] as Map<String, dynamic>),
      usageConditionList: (json['usageConditionList'] as List<dynamic>?)
          ?.map((e) => UsageConditionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      subjectConditionList: (json['subjectConditionList'] as List<dynamic>?)
          ?.map(
              (e) => SubjectConditionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      combinationConditionList:
          (json['combinationConditionList'] as List<dynamic>?)
              ?.map((e) =>
                  CombinationConditionModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$ViolatedConditionModelToJson(
        ViolatedConditionModel instance) =>
    <String, dynamic>{
      'minPurchaseCondition': instance.minPurchaseCondition,
      'usageConditionList': instance.usageConditionList,
      'subjectConditionList': instance.subjectConditionList,
      'combinationConditionList': instance.combinationConditionList,
    };
