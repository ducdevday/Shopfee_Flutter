part of 'tracking_cubit.dart';

abstract class TrackingState extends Equatable {
  const TrackingState();
}

class TrackingInitial extends TrackingState {
  @override
  List<Object> get props => [];
}

class TrackingLoading extends TrackingState{
  @override
  List<Object> get props => [];
}

class TrackingLoaded extends TrackingState {
  final List<EventLog> eventlogs;

  const TrackingLoaded({
    required this.eventlogs,
  });

  @override
  List<Object> get props => [eventlogs];
}

class TrackingError extends TrackingState{
  @override
  List<Object> get props => [];
}
