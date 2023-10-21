import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/data/models/address.dart';
import 'package:shopfee/data/models/order_type.dart';
import 'package:shopfee/data/models/receipt_product.dart';
import 'package:shopfee/data/models/review.dart';
import 'package:shopfee/data/models/transaction.dart';

part 'receipt.g.dart';

@JsonSerializable()
class Receipt  {
  String? id;
  String? note;
  double? total;
  OrderType? orderType;
  Address? address;
  DateTime? createdAt;
  List<ReceiptProduct>? products;
  Transaction? transaction;
  Review? review;
  Receipt({
    this.id,
    this.note,
    this.total,
    this.orderType,
    this.address,
    this.createdAt,
    this.products,
    this.transaction,
    this.review
  });

  String get totalString => "${NumberFormat.decimalPattern().format(total)}đ";

  factory Receipt.fromJson(Map<String, dynamic> json) =>
      _$ReceiptFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptToJson(this);
}
