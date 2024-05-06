import 'package:shopfee/features/statistics/data/models/statistic_order_detail_model.dart';

class StatisticOrderDetailEntity {
  final String key;
  final double value;

  const StatisticOrderDetailEntity({
    required this.key,
    required this.value,
  });

  factory StatisticOrderDetailEntity.fromModel(
      StatisticOrderDetailModel model) {
    return StatisticOrderDetailEntity(
      key: model.key,
      value: model.value,
    );
  }

}
