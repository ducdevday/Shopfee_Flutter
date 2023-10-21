import 'package:shopfee/app/features/history/screen/history_screen.dart';
import 'package:shopfee/data/models/status_payment.dart';
import 'package:shopfee/data/models/type_payment.dart';

class Transaction{
  String? id;
  StatusPayment? status;
  TypePayment? type;
  double? totalPaid;

  Transaction({
    this.id,
    this.status,
    this.type,
    this.totalPaid,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json["id"],
      status: StatusPayment.fromJson(json["status"]),
      type: TypePayment.fromJson(json["paymentType"]),
      totalPaid: json["totalPaid"] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "status": this.status,
      "type": this.type,
      "totalPaid": this.totalPaid,
    };
  }
}