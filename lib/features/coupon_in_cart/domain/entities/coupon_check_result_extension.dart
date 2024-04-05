import 'package:shopfee/core/common/enum/coupon_type.dart';
import 'package:shopfee/core/common/enum/coupon_usage_type.dart';
import 'package:shopfee/core/utils/format_util.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/coupon_check_result_entity.dart';

extension CouponCheckResultExtension on CouponCheckResultEntity {
  String? getViolatedString() {
    String? result;
    if (minPurchaseConditionString() != null) {
      result = minPurchaseConditionString();
      return result;
    }
    if (usageConditionString() != null) {
      result = usageConditionString();
      return result;
    }
    if (subjectConditionString() != null) {
      result = subjectConditionString();
      return result;
    }
    if (combinationConditionString() != null) {
      result = combinationConditionString();
      return result;
    }
    return result;
  }

  String? minPurchaseConditionString() {
    if (violatedCondition == null &&
        violatedCondition?.minPurchaseCondition == null) return null;
    return "Min Purchase: ${FormatUtil.formatMoney(violatedCondition?.minPurchaseCondition!.value)}";
  }

  String? usageConditionString() {
    if (violatedCondition == null &&
        violatedCondition?.usageConditionList == null) return null;
    List<String> resultList = <String>[];
    for (var usageCondition in violatedCondition!.usageConditionList!) {
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
    if (violatedCondition == null &&
        violatedCondition?.subjectConditionList == null) return null;
    List<String> resultList = <String>[];
    for (var subjectCondition in violatedCondition!.subjectConditionList!) {
      resultList.add(subjectCondition.productName);
    }
    final productString = resultList.join(", ");
    return "Apply product: $productString";
  }

  String? combinationConditionString() {
    if (violatedCondition == null &&
        violatedCondition?.combinationConditionList == null) return null;
    List<String> resultList = <String>[];
    for (var combinationCondition
        in violatedCondition!.combinationConditionList!) {
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
