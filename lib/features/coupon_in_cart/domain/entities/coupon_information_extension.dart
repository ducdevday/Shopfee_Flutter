import 'package:shopfee/core/common/enum/coupon_type.dart';
import 'package:shopfee/core/common/enum/coupon_usage_type.dart';
import 'package:shopfee/core/utils/format_util.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/coupon_informaiton_entity.dart';

extension CouponInformationExtension on CouponInformationEntity {
  bool haveConditionList() {
    if (minPurchaseConditionString() != null ||
        usageConditionString() != null ||
        subjectConditionString() != null ||
        combinationConditionString() != null) {
      return true;
    }
    return false;
  }

  String? minPurchaseConditionString() {
    if (minPurchaseCondition == null) return null;
    return "Min Purchase: ${FormatUtil.formatMoney(minPurchaseCondition!.value)}";
  }

  String? usageConditionString() {
    if (usageConditionList == null) return null;
    List<String> resultList = <String>[];
    for (var usageCondition in usageConditionList!) {
      switch (usageCondition.type) {
        case CouponUsageConditionType.QUANTITY:
          resultList.add("Coupon has been used up");
        case CouponUsageConditionType.LIMIT_ONE_FOR_USER:
          resultList.add("Coupon limit to one use per customer");
      }
    }
    return resultList.join(", ");
  }

  String? subjectConditionString() {
    if (subjectConditionList == null) return null;
    List<String> resultList = <String>[];
    for (var subjectCondition in subjectConditionList!) {
      resultList.add(subjectCondition.productName);
    }
    final productString = resultList.join(", ");
    return "Apply product: $productString";
  }

  String? combinationConditionString() {
    if (combinationConditionList == null) return null;
    List<String> resultList = <String>[];
    for (var combinationCondition in combinationConditionList!) {
      switch (combinationCondition.type) {
        case CouponType.ORDER:
          resultList.add("Order Coupon");
        case CouponType.SHIPPING:
          resultList.add("Shipping Coupon");
        case CouponType.PRODUCT:
          resultList.add("Product Coupon");
      }
    }
    final combineString = resultList.join(", ");
    return "Combinable: $combineString";
  }
}
