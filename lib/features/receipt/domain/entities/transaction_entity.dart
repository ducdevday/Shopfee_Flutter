import 'package:shopfee/core/common/enum/payment_type.dart';
import 'package:shopfee/core/common/enum/payment_status.dart';
import 'package:shopfee/features/receipt/data/models/transaction_model.dart';

class TransactionEntity {
  String? id;
  PaymentStatus? status;
  PaymentType? type;
  double? totalPaid;
  String? paymentUrl;

  TransactionEntity(
      {this.id, this.status, this.type, this.totalPaid, this.paymentUrl});

  factory TransactionEntity.fromModel(TransactionModel model) {
    return TransactionEntity(
        id: model.id,
        status: model.status,
        type: model.paymentType,
        totalPaid: model.totalPaid,
        paymentUrl: model.paymentUrl);
  }
}
