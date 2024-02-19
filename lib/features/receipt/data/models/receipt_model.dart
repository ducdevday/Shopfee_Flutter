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
  double? total;
  OrderType? orderType;
  AddressModel? address;
  DateTime? createdAt;
  List<ReceiptProductModel>? products;
  TransactionModel? transaction;

  // Review? review;

  ReceiptModel({
    this.id,
    this.note,
    this.total,
    this.orderType,
    this.address,
    this.createdAt,
    this.products,
    this.transaction,
    // this.review
  });

  factory ReceiptModel.fromJson(Map<String, dynamic> json) {
    return _$ReceiptModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ReceiptModelToJson(this);
  }
}
