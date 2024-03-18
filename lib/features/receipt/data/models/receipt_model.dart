import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/core/common/models/order_type.dart';
import 'package:shopfee/features/receipt/data/models/receipt_product_model.dart';
import 'package:shopfee/features/receipt/data/models/transaction_model.dart';
import 'package:shopfee/features/saved_address/data/models/address_model.dart';

part 'receipt_model.g.dart';

@JsonSerializable()
class ReceiptModel {
  String? id;
  String? note;
  num? totalPayment;
  num? shippingFee;
  num? totalItemPrice;
  OrderType? orderType;
  AddressModel? shippingInformation;
  DateTime? createdAt;
  List<ReceiptProductModel>? itemList;
  TransactionModel? transaction;
  DateTime? receiveTime;
  String? branchAddress;
  int? coin;

  ReceiptModel({
    this.id,
    this.note,
    this.totalPayment,
    this.shippingFee,
    this.totalItemPrice,
    this.orderType,
    this.shippingInformation,
    this.createdAt,
    this.itemList,
    this.transaction,
    this.receiveTime,
    this.branchAddress,
    this.coin,
  });

  factory ReceiptModel.fromJson(Map<String, dynamic> json) {
    return _$ReceiptModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ReceiptModelToJson(this);
  }
}
