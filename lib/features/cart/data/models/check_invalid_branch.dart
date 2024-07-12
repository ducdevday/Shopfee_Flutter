import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/cart/data/models/check_product.dart';

part 'check_invalid_branch.g.dart';

@JsonSerializable()
class CheckInvalidBranch{
  final String branchId;
  final List<CheckProduct> orderItemInvalidList;

  const CheckInvalidBranch({
    required this.branchId,
    required this.orderItemInvalidList,
  });

  factory CheckInvalidBranch.fromJson(Map<String, dynamic> json) {
    return _$CheckInvalidBranchFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CheckInvalidBranchToJson(this);
  }
}