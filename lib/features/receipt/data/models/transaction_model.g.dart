// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      id: json['id'] as String?,
      status: $enumDecodeNullable(_$PaymentStatusEnumMap, json['status']),
      paymentType:
          $enumDecodeNullable(_$PaymentTypeEnumMap, json['paymentType']),
      totalPaid: (json['totalPaid'] as num?)?.toDouble(),
      paymentUrl: json['paymentUrl'] as String?,
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'paymentType': instance.paymentType,
      'totalPaid': instance.totalPaid,
      'paymentUrl': instance.paymentUrl,
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.PAID: 'PAID',
  PaymentStatus.UNPAID: 'UNPAID',
  PaymentStatus.FAILED: 'FAILED',
};

const _$PaymentTypeEnumMap = {
  PaymentType.CASHING: 'CASHING',
  PaymentType.VNPAY: 'VNPAY',
  PaymentType.ZALOPAY: 'ZALOPAY',
};
