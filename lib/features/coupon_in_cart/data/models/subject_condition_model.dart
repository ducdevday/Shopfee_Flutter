import 'package:json_annotation/json_annotation.dart';

part "subject_condition_model.g.dart";

@JsonSerializable()
class SubjectConditionModel {
  final String productName;
  final num value;

  const SubjectConditionModel({
    required this.productName,
    required this.value,
  });

  factory SubjectConditionModel.fromJson(Map<String, dynamic> json) {
    return _$SubjectConditionModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubjectConditionModelToJson(this);
  }
}
