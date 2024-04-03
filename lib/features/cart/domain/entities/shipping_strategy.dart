import 'package:shopfee/core/common/models/order_type.dart';

import 'i_cart_cost_strategy.dart';

class ShippingStrategy implements ICartCostsStrategy {
  @override
  OrderType orderType = OrderType.SHIPPING;

  @override
  double calculateTotal(double totalItemPrice, double? shippingFee, num? coin) {
    return totalItemPrice + _getShippingFee(shippingFee) - _getCoin(coin);
  }

  @override
  double calculateTotalWithoutCoin(double totalItemPrice, double? shippingFee) {
    return totalItemPrice + _getShippingFee(shippingFee);
  }

  double _getShippingFee(double? shippingFee) {
    if (shippingFee != null) {
      return shippingFee;
    }
    return 0;
  }

  num _getCoin(num? coin) {
    if (coin != null) {
      return coin;
    }
    return 0;
  }
}
