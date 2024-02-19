part of tracking;

class TrackingCubit extends Cubit<TrackingState> {
  final TrackingUseCase _trackingUseCase;

  TrackingCubit(this._trackingUseCase) : super(TrackingInitial());

  void loadTrackingInformation(String orderId) async {
    emit(TrackingLoadInProcess());
    try {
      var eventLogs = await _trackingUseCase.getEventLogsOrder(orderId);

      emit(TrackingLoadSuccess(eventlogs: eventLogs));
    } catch (e) {
      emit(TrackingFailure());
      ExceptionUtil.handle(e);
    }
  }
}
