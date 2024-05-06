import 'package:shopfee/core/common/enum/reward_unit.dart';
import 'package:shopfee/core/utils/format_util.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/reward_information_entity.dart';

extension RewardInformationExtension on RewardInformationEntity {
  String getFormattedReward() {
    if (moneyReward != null && subjectInformation == null) {
      switch (moneyReward?.unit) {
        case RewardUnit.PERCENTAGE:
          return "- ${FormatUtil.formatPercent(moneyReward?.value)}";
        case RewardUnit.MONEY:
          return "- ${FormatUtil.formatMoney(moneyReward?.value)}";
        default:
          return "";
      }
    }
    if (moneyReward != null && subjectInformation != null) {
      switch (moneyReward?.unit) {
        case RewardUnit.PERCENTAGE:
          return "${subjectInformation?.name} - ${FormatUtil.formatPercent(moneyReward?.value)}";
        case RewardUnit.MONEY:
          return "${subjectInformation?.name} - ${FormatUtil.formatMoney(moneyReward?.value)}";
        default:
          return "";
      }
    }
    if (productRewardList != null) {
      List<String> result = [];
      productRewardList?.forEach((productReward) {
        result.add("+ ${productReward.quantity} ${productReward.name}");
      });
      return result.join("\n");
    }
    return "";
  }
}
