import 'package:shopfee/features/review_detail/data/models/review_statistic_data_model.dart';
import 'package:shopfee/features/review_detail/data/models/review_statistic_model.dart';

class ChartStackedBarData {
  final int star;
  final int current;
  final int total;

  const ChartStackedBarData({
    required this.star,
    required this.current,
    required this.total,
  }); //

  factory ChartStackedBarData.fromModel(
      int total, ReviewStatisticDataModel data) {
    return ChartStackedBarData(
        star: data.star,
        current: data.count,
        total: total);
  }
}
