import 'package:json_annotation/json_annotation.dart';

part 'order_result.g.dart';

@JsonSerializable()
class OrderResult {
  final String? orderId;
  final String? paymentUrl;
  final String? transactionId;

  const OrderResult({
    this.orderId,
    this.paymentUrl,
    this.transactionId,
  });

  factory OrderResult.fromJson(Map<String, dynamic> json) {
    return _$OrderResultFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderResultToJson(this);
  }
}
