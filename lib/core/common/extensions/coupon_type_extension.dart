import 'package:shopfee/core/common/enum/coupon_type.dart';
import 'package:shopfee/core/config/app_path.dart';

extension CouponTypeExtension on CouponType {
  String getImage() {
    switch (this) {
      case (CouponType.SHIPPING):
        return AppPath.imgCouponShipping;
      case (CouponType.PRODUCT):
        return AppPath.imgCouponProduct;
      case (CouponType.ORDER):
        return AppPath.imgCouponOrder;
    }
  }

  String getTitle() {
    switch (this) {
      case (CouponType.SHIPPING):
        return "Shipping fees discount code";
      case (CouponType.PRODUCT):
        return "Product discount/reward code";
      case (CouponType.ORDER):
        return "Order discount code";
    }
  }

  String getIconType() {
    switch (this) {
      case (CouponType.SHIPPING):
        return AppPath.icShippingCoupon;
      case (CouponType.PRODUCT):
        return AppPath.icProductCoupon;
      case (CouponType.ORDER):
        return AppPath.icOrderCoupon;
    }
  }
}
