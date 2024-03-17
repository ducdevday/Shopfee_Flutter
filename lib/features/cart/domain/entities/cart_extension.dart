import 'package:shopfee/core/common/models/order_type.dart';
import 'package:shopfee/core/utils/format_util.dart';
import 'package:shopfee/features/cart/domain/entities/cart_entity.dart';
import 'package:shopfee/features/cart/domain/entities/shipping_strategy.dart';
import 'package:shopfee/features/cart/domain/entities/take_away_strategy.dart';

extension CartExTension on CartEntity {
  double getTotalCartPrice() {
    if (orderType == OrderType.SHIPPING) {
      return ShippingStrategy()
          .calculateTotal(totalItemPrice, shippingFee, coin);
    } else if (orderType == OrderType.ONSITE) {
      return TakeAwayStrategy()
          .calculateTotal(totalItemPrice, shippingFee, coin);
    }
    return 0;
  }

  double getTotalCartPriceWithoutCoin() {
    if (orderType == OrderType.SHIPPING) {
      return ShippingStrategy()
          .calculateTotalWithoutCoin(totalItemPrice, shippingFee);
    } else if (orderType == OrderType.ONSITE) {
      return TakeAwayStrategy()
          .calculateTotalWithoutCoin(totalItemPrice, shippingFee);
    }
    return 0;
  }

  double getCalculatedShippingFee() {
    if (orderType == OrderType.SHIPPING) {
      return shippingFee ?? 0;
    } else if (orderType == OrderType.ONSITE) {
      return 0;
    }
    return 0;
  }

  bool isShippingTypeOrderValid() {
    if (orderType == OrderType.SHIPPING) {
      if (address == null || shippingFee == null) {
        return false;
      }
    }
    return true;
  }

  bool isTakeAwayOrderValid() {
    if (orderType == OrderType.ONSITE) {
      if (store == null) {
        return false;
      } else if (DateTime.now()
              .isBefore(FormatUtil.formatOpenCloseTime(store!.openTime!)) ||
          DateTime.now()
              .isAfter(FormatUtil.formatOpenCloseTime(store!.closeTime!))) {
        return false;
      }
    }
    return true;
  }

  bool isOrderValid() {
    if (isShippingTypeOrderValid() && isTakeAwayOrderValid()) {
      return true;
    }
    return false;
  }

  bool checkChooseValidReceiptTime(DateTime chosenTime) {
    if (chosenTime.isBefore(DateTime.now())) {
      return false;
    }
    return true;
  }

  num getValidCoin(num currentUserCoin) {
    if (currentUserCoin <= getTotalCartPriceWithoutCoin()) {
      return currentUserCoin;
    }
    return getTotalCartPriceWithoutCoin();
  }
}
