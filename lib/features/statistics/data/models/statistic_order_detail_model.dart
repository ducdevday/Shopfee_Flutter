import 'package:json_annotation/json_annotation.dart';

part 'statistic_order_detail_model.g.dart';

@JsonSerializable()
class StatisticOrderDetailModel{
  final String key;
  final double value;

  const StatisticOrderDetailModel({
    required this.key,
    required this.value,
  });

  factory StatisticOrderDetailModel.fromJson(Map<String, dynamic> json) {
    return _$StatisticOrderDetailModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StatisticOrderDetailModelToJson(this);
  }
}