part of statistics;

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final StatisticsUseCase _statisticUseCase;

  StatisticsBloc(this._statisticUseCase) : super(StatisticsInitial()) {
    on<StatisticsChooseAmountPaid>(_onStatisticsChooseAmountPaid);
    on<StatisticsChooseTotalOrder>(_onStatisticsChooseTotalOrder);
    on<StatisticsChooseTracking>(_onStatisticsChooseTracking);
  }

  FutureOr<void> _onStatisticsChooseAmountPaid(
      StatisticsChooseAmountPaid event, Emitter<StatisticsState> emit) async {
    try {
      EasyLoading.show();
      final orderChart = await _statisticUseCase.getOrderStatistic(
          SharedService.getUserId()!, ChartType.PAYMENT_TYPE);
      EasyLoading.dismiss();
      emit(StatisticsAmountPaidState(
          total: orderChart.total,
          chartData: orderChart.statistics
              .map((e) => ChartCircularData(
                  e.key,
                  e.value,
                  FormatUtil.formatPercent(
                      FormatUtil.calculatePercent(e.value, orderChart.total))))
              .toList()));
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onStatisticsChooseTotalOrder(
      StatisticsChooseTotalOrder event, Emitter<StatisticsState> emit) async {
    try {
      EasyLoading.show();
      final orderChart = await _statisticUseCase.getOrderStatistic(
          SharedService.getUserId()!, ChartType.ORDER_STATUS);
      EasyLoading.dismiss();
      emit(StatisticsTotalOrderState(
          total: orderChart.total,
          chartData: orderChart.statistics
              .map((e) => ChartCircularData(
                  e.key,
                  e.value,
                  FormatUtil.formatPercent(
                      FormatUtil.calculatePercent(e.value, orderChart.total))))
              .toList()));
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onStatisticsChooseTracking(
      StatisticsChooseTracking event, Emitter<StatisticsState> emit) async {
    try {
      EasyLoading.show();
      final trackingChart = await _statisticUseCase.getSpentStatistic(
          SharedService.getUserId()!, event.dateTimes[0]!, event.dateTimes[1]!);
      EasyLoading.dismiss();
      emit(StatisticsTrackingState(
          total: trackingChart.totalSpent,
          chartData: trackingChart.statistics
              .map((e) => ChartLineData(
                  time: FormatUtil.formattedStatisticStringToDatetime(e.time)!,
                  value: e.amount))
              .toList()));
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }
}
