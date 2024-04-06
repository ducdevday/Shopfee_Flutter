part of home;

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeLoadInformation extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class HomeRefreshInformation extends HomeEvent {
  @override
  List<Object> get props => [];
}
