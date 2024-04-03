// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResult _$OrderResultFromJson(Map<String, dynamic> json) => OrderResult(
      orderId: json['orderId'] as String?,
      paymentUrl: json['paymentUrl'] as String?,
      transactionId: json['transactionId'] as String?,
    );

Map<String, dynamic> _$OrderResultToJson(OrderResult instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'paymentUrl': instance.paymentUrl,
      'transactionId': instance.transactionId,
    };
