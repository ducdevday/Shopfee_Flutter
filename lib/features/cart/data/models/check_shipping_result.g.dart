// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_shipping_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckShippingResult _$CheckShippingResultFromJson(Map<String, dynamic> json) =>
    CheckShippingResult(
      branchInvalidList: (json['branchInvalidList'] as List<dynamic>?)
          ?.map((e) => CheckInvalidBranch.fromJson(e as Map<String, dynamic>))
          .toList(),
      branchValid: json['branchValid'] == null
          ? null
          : CheckValidBranch.fromJson(
              json['branchValid'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckShippingResultToJson(
        CheckShippingResult instance) =>
    <String, dynamic>{
      'branchInvalidList': instance.branchInvalidList,
      'branchValid': instance.branchValid,
    };
