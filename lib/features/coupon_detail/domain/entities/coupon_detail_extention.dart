import 'package:shopfee/core/common/enum/coupon_condition_type.dart';
import 'package:shopfee/core/common/enum/coupon_type.dart';
import 'package:shopfee/core/common/enum/coupon_usage_type.dart';
import 'package:shopfee/core/utils/format_util.dart';
import 'package:shopfee/features/coupon_detail/domain/entities/coupon_detail_entity.dart';

extension CouponDetailExtension on CouponDetailEntity {
  String conditionListString() {
    List<String> result = [];
    if(minPurchaseConditionString() != null) {
      result.add(minPurchaseConditionString()!);
    }
    if(usageConditionString() != null) {
      result.add(usageConditionString()!);
    }
    if(subjectConditionString() != null) {
      result.add(subjectConditionString()!);
    }
    if(combinationConditionString() != null){
      result.add(combinationConditionString()!);
    }
    return result.join("\n");
  }

  String? minPurchaseConditionString() {
    if (conditionList == null) return null;
    for (var condition in conditionList!) {
      if (condition.type == ConditionType.MIN_PURCHASE &&
          condition.minPurchaseCondition != null)
        return "Min Purchase: ${FormatUtil.formatMoney(condition.minPurchaseCondition!.value)}";
    }
    return null;
  }

  String? usageConditionString() {
    if (conditionList == null) return null;
    for (var condition in conditionList!) {
      if (condition.type == ConditionType.USAGE &&
          condition.usageConditionList != null) {
        List<String> resultList = <String>[];
        for (var usageCondition in condition.usageConditionList!) {
          switch (usageCondition.type) {
            case CouponUsageConditionType.QUANTITY:
              resultList.add("Quantity available: ${usageCondition.value}");
            case CouponUsageConditionType.LIMIT_ONE_FOR_USER:
              resultList.add("Once use per one}");
          }
        }
        return resultList.join(", ");
      }
    }
    return null;
  }

  String? subjectConditionString() {
    if (conditionList == null) return null;
    for (var condition in conditionList!) {
      if (condition.type == ConditionType.TARGET_OBJECT &&
          condition.subjectConditionList != null) {
        List<String> resultList = <String>[];
        for (var subjectCondition in condition.subjectConditionList!) {
          resultList.add(subjectCondition.productName);
        }
        final productString = resultList.join(", ");
        return "Apply product: $productString";
      }
    }
    return null;
  }

  String? combinationConditionString() {
    if (conditionList == null) return null;
    for (var condition in conditionList!) {
      if (condition.type == ConditionType.COMBINATION &&
          condition.combinationConditionList != null) {
        List<String> resultList = <String>[];
        for (var combinationCondition in condition.combinationConditionList!) {
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
    return null;
  }
}
