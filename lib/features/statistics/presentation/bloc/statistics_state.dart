part of statistics;

abstract class StatisticsState extends Equatable {
  const StatisticsState();
}

class StatisticsInitial extends StatisticsState {
  @override
  List<Object> get props => [];
}

class StatisticsAmountPaidState extends StatisticsState {
  final double total;
  final List<ChartCircularData> chartData;

  const StatisticsAmountPaidState({
    required this.total,
    required this.chartData,
  });

  @override
  List<Object> get props => [total, chartData];
}

class StatisticsTotalOrderState extends StatisticsState {
  final double total;
  final List<ChartCircularData> chartData;

  const StatisticsTotalOrderState({
    required this.total,
    required this.chartData,
  });

  @override
  List<Object> get props => [total, chartData];
}

class StatisticsTrackingState extends StatisticsState {
  final double total;
  final List<ChartLineData> chartData;

  const StatisticsTrackingState({
    required this.total,
    required this.chartData,
  });

  @override
  List<Object> get props => [total, chartData];
}
