// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptModel _$ReceiptModelFromJson(Map<String, dynamic> json) => ReceiptModel(
      id: json['id'] as String?,
      note: json['note'] as String?,
      total: (json['total'] as num?)?.toDouble(),
      orderType: $enumDecodeNullable(_$OrderTypeEnumMap, json['orderType']),
      address: json['address'] == null
          ? null
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ReceiptProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      transaction: json['transaction'] == null
          ? null
          : TransactionModel.fromJson(
              json['transaction'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReceiptModelToJson(ReceiptModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'note': instance.note,
      'total': instance.total,
      'orderType': instance.orderType,
      'address': instance.address,
      'createdAt': instance.createdAt?.toIso8601String(),
      'products': instance.products,
      'transaction': instance.transaction,
    };

const _$OrderTypeEnumMap = {
  OrderType.SHIPPING: 'SHIPPING',
  OrderType.ONSITE: 'ONSITE',
};
