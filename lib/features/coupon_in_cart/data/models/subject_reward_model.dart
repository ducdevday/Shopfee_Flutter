import 'package:json_annotation/json_annotation.dart';

part 'subject_reward_model.g.dart';

@JsonSerializable()
class SubjectRewardModel {
  final String? id;
  final String? name;

  const SubjectRewardModel({
    this.id,
    this.name,
  });

  factory SubjectRewardModel.fromJson(Map<String, dynamic> json) {
    return _$SubjectRewardModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubjectRewardModelToJson(this);
  }
}
