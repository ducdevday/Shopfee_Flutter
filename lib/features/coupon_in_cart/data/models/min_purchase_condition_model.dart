import 'package:json_annotation/json_annotation.dart';

part 'min_purchase_condition_model.g.dart';

@JsonSerializable()
class MinPurchaseConditionModel{
  final num value;

  const MinPurchaseConditionModel({
    required this.value,
  });

  factory MinPurchaseConditionModel.fromJson(Map<String, dynamic> json) {
    return _$MinPurchaseConditionModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MinPurchaseConditionModelToJson(this);
  }
}


