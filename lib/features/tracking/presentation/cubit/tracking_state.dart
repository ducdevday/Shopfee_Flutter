part of tracking;

abstract class TrackingState extends Equatable {
  const TrackingState();
}

class TrackingInitial extends TrackingState {
  @override
  List<Object> get props => [];
}

class TrackingLoadInProcess extends TrackingState{
  @override
  List<Object> get props => [];
}

class TrackingLoadSuccess extends TrackingState {
  final List<EventLogEntity> eventlogs;

  const TrackingLoadSuccess({
    required this.eventlogs,
  });

  @override
  List<Object> get props => [eventlogs];
}

class TrackingFailure extends TrackingState{
  @override
  List<Object> get props => [];
}