// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refund_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefundDetailModel _$RefundDetailModelFromJson(Map<String, dynamic> json) =>
    RefundDetailModel(
      reason: json['reason'] as String?,
      note: json['note'] as String?,
      status: $enumDecode(_$RefundStatusEnumMap, json['status']),
      mediaList: (json['mediaList'] as List<dynamic>?)
          ?.map((e) => RefundMediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RefundDetailModelToJson(RefundDetailModel instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'note': instance.note,
      'status': _$RefundStatusEnumMap[instance.status]!,
      'mediaList': instance.mediaList,
    };

const _$RefundStatusEnumMap = {
  RefundStatus.PENDING: 'PENDING',
  RefundStatus.ACCEPTED: 'ACCEPTED',
  RefundStatus.REFUSED: 'REFUSED',
};
