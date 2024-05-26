import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/cart/data/models/check_invalid_branch.dart';
import 'package:shopfee/features/cart/data/models/check_valid_branch.dart';

part 'check_shipping_result.g.dart';

@JsonSerializable()
class CheckShippingResult{
  final List<CheckInvalidBranch>? branchInvalidList;
  final CheckValidBranch? branchValid;

  const CheckShippingResult({
    required this.branchInvalidList,
    required this.branchValid,
  });

  factory CheckShippingResult.fromJson(Map<String, dynamic> json) {
    return _$CheckShippingResultFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CheckShippingResultToJson(this);
  }
}