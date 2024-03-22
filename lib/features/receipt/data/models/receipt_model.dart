import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/core/common/models/order_type.dart';
import 'package:shopfee/features/receipt/data/models/branch_model.dart';
import 'package:shopfee/features/receipt/data/models/receipt_product_model.dart';
import 'package:shopfee/features/receipt/data/models/receiver_information_model.dart';
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
  ReceiverInformationModel? receiverInformation;
  DateTime? createdAt;
  List<ReceiptProductModel>? itemList;
  TransactionModel? transaction;
  BranchModel? branch;
  int? coin;

  ReceiptModel({
    this.id,
    this.note,
    this.totalPayment,
    this.shippingFee,
    this.totalItemPrice,
    this.orderType,
    this.receiverInformation,
    this.createdAt,
    this.itemList,
    this.transaction,
    this.branch,
    this.coin,
  });

  factory ReceiptModel.fromJson(Map<String, dynamic> json) {
    return _$ReceiptModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ReceiptModelToJson(this);
  }
}
