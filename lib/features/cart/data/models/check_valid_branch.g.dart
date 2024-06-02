// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_valid_branch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckValidBranch _$CheckValidBranchFromJson(Map<String, dynamic> json) =>
    CheckValidBranch(
      branchId: json['branchId'] as String,
      shippingFee: (json['shippingFee'] as num).toInt(),
    );

Map<String, dynamic> _$CheckValidBranchToJson(CheckValidBranch instance) =>
    <String, dynamic>{
      'branchId': instance.branchId,
      'shippingFee': instance.shippingFee,
    };
