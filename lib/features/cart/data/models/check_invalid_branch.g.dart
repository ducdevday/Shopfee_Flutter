// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_invalid_branch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckInvalidBranch _$CheckInvalidBranchFromJson(Map<String, dynamic> json) =>
    CheckInvalidBranch(
      branchId: json['branchId'] as String,
      orderItemInvalidList: (json['orderItemInvalidList'] as List<dynamic>)
          .map((e) => CheckProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CheckInvalidBranchToJson(CheckInvalidBranch instance) =>
    <String, dynamic>{
      'branchId': instance.branchId,
      'orderItemInvalidList': instance.orderItemInvalidList,
    };
