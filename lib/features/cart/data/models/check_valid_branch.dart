import 'package:json_annotation/json_annotation.dart';

part 'check_valid_branch.g.dart';

@JsonSerializable()
class CheckValidBranch {
  final String branchId;
  final int shippingFee;

  const CheckValidBranch({
    required this.branchId,
    required this.shippingFee,
  });

  factory CheckValidBranch.fromJson(Map<String, dynamic> json) {
    return _$CheckValidBranchFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CheckValidBranchToJson(this);
  }
}
