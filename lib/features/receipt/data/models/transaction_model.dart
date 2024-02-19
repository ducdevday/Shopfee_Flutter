import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/core/common/enum/payment_type.dart';
import 'package:shopfee/core/common/enum/payment_status.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel {
  String? id;
  PaymentStatus? status;
  PaymentType? paymentType;
  double? totalPaid;

  TransactionModel({
    this.id,
    this.status,
    this.paymentType,
    this.totalPaid,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return _$TransactionModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TransactionModelToJson(this);
  }
}
