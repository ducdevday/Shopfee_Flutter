// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptModel _$ReceiptModelFromJson(Map<String, dynamic> json) => ReceiptModel(
      id: json['id'] as String?,
      note: json['note'] as String?,
      totalPayment: json['totalPayment'] as num?,
      shippingFee: json['shippingFee'] as num?,
      totalItemPrice: json['totalItemPrice'] as num?,
      orderType: $enumDecodeNullable(_$OrderTypeEnumMap, json['orderType']),
      address: json['shippingInformation'] == null
          ? null
          : AddressModel.fromJson(
              json['shippingInformation'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      itemList: (json['itemList'] as List<dynamic>?)
          ?.map((e) => ReceiptProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      transaction: json['transaction'] == null
          ? null
          : TransactionModel.fromJson(
              json['transaction'] as Map<String, dynamic>),
      branchAddress: json['branchAddress'] as String?,
    );

Map<String, dynamic> _$ReceiptModelToJson(ReceiptModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'note': instance.note,
      'totalPayment': instance.totalPayment,
      'shippingFee': instance.shippingFee,
      'totalItemPrice': instance.totalItemPrice,
      'orderType': instance.orderType,
      'shippingInformation': instance.address,
      'createdAt': instance.createdAt?.toIso8601String(),
      'itemList': instance.itemList,
      'transaction': instance.transaction,
      'branchAddress': instance.branchAddress,
    };

const _$OrderTypeEnumMap = {
  OrderType.SHIPPING: 'SHIPPING',
  OrderType.ONSITE: 'ONSITE',
};
