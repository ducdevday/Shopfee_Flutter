import 'package:shopfee/core/common/models/order_type.dart';

abstract interface class ICartCostsStrategy {
  late OrderType orderType;
  double calculateTotal(double totalItemPrice, double? shippingFee, num? coin);
  double calculateTotalWithoutCoin(double totalItemPrice, double? shippingFee);
}