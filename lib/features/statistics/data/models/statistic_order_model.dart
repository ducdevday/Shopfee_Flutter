
import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/statistics/data/models/statistic_order_detail_model.dart';

part 'statistic_order_model.g.dart';

@JsonSerializable()
class StatisticOrderModel{
  final double total;
  final List<StatisticOrderDetailModel> statistics;

  const StatisticOrderModel({
    required this.total,
    required this.statistics,
  });

  factory StatisticOrderModel.fromJson(Map<String, dynamic> json) {
    return _$StatisticOrderModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StatisticOrderModelToJson(this);
  }
}