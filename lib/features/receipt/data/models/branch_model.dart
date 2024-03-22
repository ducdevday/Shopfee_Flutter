import 'package:json_annotation/json_annotation.dart';

part 'branch_model.g.dart';

@JsonSerializable()
class BranchModel {
  final String? id;
  final String? address;

  const BranchModel({
    this.id,
    this.address,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return _$BranchModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BranchModelToJson(this);
  }
}
