import 'package:shopfee/core/common/enum/reward_unit.dart';
import 'package:shopfee/core/common/models/order_type.dart';
import 'package:shopfee/core/utils/format_util.dart';
import 'package:shopfee/features/cart/domain/entities/cart_entity.dart';
import 'package:shopfee/features/product_detail/domain/entities/order_entity.dart';

extension CartExTension on CartEntity {
  double getTotalItemPriceInCart() {
    return totalItemPrice;
  }

  double getShippingCouponValue() {
    double result = 0;
    if (shippingCouponCode != null && shippingFee != null) {
      if (shippingCouponResult?.reward?.moneyReward?.unit == RewardUnit.MONEY) {
        if (shippingCouponResult!.reward!.moneyReward!.value! < shippingFee!) {
          result += shippingCouponResult!.reward!.moneyReward?.value ?? 0;
        } else {
          result += shippingFee!;
        }
      } else if (shippingCouponResult?.reward?.moneyReward?.unit ==
          RewardUnit.PERCENTAGE) {
        result += shippingFee! *
            ((shippingCouponResult!.reward!.moneyReward?.value ?? 0) / 100);
      }
    }
    return result;
  }

  double getOrderCouponValue() {
    double result = 0;
    if (orderCouponCode != null) {
      if (orderCouponResult?.reward?.moneyReward?.unit == RewardUnit.MONEY) {
        result += orderCouponResult!.reward!.moneyReward?.value ?? 0;
      } else if (orderCouponResult?.reward?.moneyReward?.unit ==
          RewardUnit.PERCENTAGE) {
        result += (getTotalItemPriceInCart() - getProductCouponValue()) *
            ((orderCouponResult!.reward!.moneyReward?.value ?? 0) / 100);
      }
    }
    return result;
  }

  double getProductCouponValue() {
    double result = 0;
    if (productCouponCode != null &&
        productCouponResult?.reward?.productRewardList == null) {
      if (productCouponResult?.reward?.moneyReward?.unit == RewardUnit.MONEY) {
        result += getTotalProductById(
                productCouponResult!.reward!.subjectInformation!.id!) *
            (productCouponResult!.reward!.moneyReward?.value ?? 0);
      } else if (productCouponResult?.reward?.moneyReward?.unit ==
          RewardUnit.PERCENTAGE) {
        result += getTotalProductPriceById(
                productCouponResult!.reward!.subjectInformation!.id!) *
            ((productCouponResult!.reward!.moneyReward?.value ?? 0) / 100);
      }
    }
    return result;
  }

  double getCalculatedShippingFee() {
    if (orderType == OrderType.SHIPPING) {
      return shippingFee ?? 0;
    } else if (orderType == OrderType.ONSITE) {
      return 0;
    }
    return 0;
  }

  int getTotalProductById(String id) {
    final product =
        orders.where((element) => element.product.id == id).toList();
    final productTotal =
        product.fold(0, (total, current) => total + current.quantity);
    return productTotal;
  }

  double getTotalProductPriceById(String id) {
    final totalProductPrice = orders
        .where((element) => element.product.id == id)
        .fold(0.0, (total, current) => total + current.totalSizePrice);
    return totalProductPrice;
  }

  double getTotalCouponValue() {
    return getShippingCouponValue() +
        getOrderCouponValue() +
        getProductCouponValue();
  }

  double getCartTotalPriceWithoutCoin() {
    return getTotalItemPriceInCart() +
        getCalculatedShippingFee() -
        getShippingCouponValue() -
        getOrderCouponValue() -
        getProductCouponValue();
  }

  double getCartTotalPrice() {
    return getCartTotalPriceWithoutCoin() - (coin ?? 0);
  }

  double? calculateProductPriceAppliedCoupon(OrderEntity orderEntity) {
    if (productCouponCode == null ||
        productCouponResult?.reward?.productRewardList != null ||
        orderEntity.product.id !=
            productCouponResult?.reward?.subjectInformation?.id) {
      return null;
    }
    double discount = 0;
    double currentSizePrice = orderEntity.size?.price ?? 0;
    double newProductPrice = 0;
    if (productCouponResult?.reward?.moneyReward?.unit == RewardUnit.MONEY) {
      discount += (productCouponResult!.reward!.moneyReward?.value ?? 0);
      currentSizePrice = currentSizePrice - discount;
      newProductPrice = orderEntity.quantity * currentSizePrice +
          orderEntity.quantity *
              orderEntity.toppings
                  .fold(0, (total, current) => total + current.price);
      return newProductPrice;
    } else if (productCouponResult?.reward?.moneyReward?.unit ==
        RewardUnit.PERCENTAGE) {
      discount +=
          ((productCouponResult!.reward!.moneyReward?.value ?? 0) / 100);
      currentSizePrice = currentSizePrice * (1 - discount);
      newProductPrice = orderEntity.quantity * currentSizePrice +
          orderEntity.quantity *
              orderEntity.toppings
                  .fold(0, (total, current) => total + current.price);
      return newProductPrice;
    }
    return null;
  }

  bool haveProductGiftList() {
    if (productCouponCode != null &&
        productCouponResult != null &&
        productCouponResult!.reward != null &&
        productCouponResult!.reward!.productRewardList != null &&
        productCouponResult!.reward!.productRewardList!.isNotEmpty) {
      return true;
    }
    return false;
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
      } else if (receiverOnsite == null ||
          receiverOnsite?.phoneNumber == null ||
          receiverOnsite?.recipientName == null) {
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

  bool isAppliedCoupon() {
    if (shippingCouponCode != null ||
        orderCouponCode != null ||
        productCouponCode != null) {
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
    if (currentUserCoin <= getCartTotalPriceWithoutCoin()) {
      return currentUserCoin;
    }
    return getCartTotalPriceWithoutCoin();
  }

  bool needToCheckCoupon(String? userId){
    if(userId == null) {
      return false;
    }
    if(shippingCouponCode == null && orderCouponCode == null && productCouponCode == null){
      return false;
    }
    return true;
  }
}
