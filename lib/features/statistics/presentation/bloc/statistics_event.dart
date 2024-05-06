part of statistics;

abstract class StatisticsEvent extends Equatable {
  const StatisticsEvent();
}

class StatisticsChooseAmountPaid extends StatisticsEvent {
  @override
  List<Object> get props => [];
}

class StatisticsChooseTotalOrder extends StatisticsEvent {
  @override
  List<Object> get props => [];
}

class StatisticsChooseTracking extends StatisticsEvent {
  final List<DateTime?> dateTimes;

  const StatisticsChooseTracking({
    required this.dateTimes,
  });

  @override
  List<Object> get props => [dateTimes];
}
