part of refund;

class RefundBloc extends Bloc<RefundEvent, RefundState> {
  final RefundUseCase _refundUseCase;

  RefundBloc(this._refundUseCase) : super(RefundInitial()) {
    on<RefundInitRequest>(_onRefundInitRequest);
    on<RefundChooseReasonPressed>(_onRefundChooseReasonPressed);
    on<RefundContinuePressed>(_onRefundContinuePressed);
    on<RefundChooseMultipleMedia>(_onRefundChooseMultipleMedia);
    on<RefundRemoveMedia>(_onRefundRemoveMedia);
    on<RefundSetNote>(_onRefundSetNote);
    on<RefundCreateRequestPressed>(_onRefundCreateRequestPressed);
    on<RefundLoadDetail>(_onRefundLoadDetail);
  }

  FutureOr<void> _onRefundInitRequest(
      RefundInitRequest event, Emitter<RefundState> emit) async {
    try {
      emit(const RefundRequestPhase1State());
    } catch (e) {}
  }

  FutureOr<void> _onRefundChooseReasonPressed(
      RefundChooseReasonPressed event, Emitter<RefundState> emit) async {
    try {
      emit(RefundRequestPhase1State(reasonRefundType: event.reasonRefundType));
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onRefundContinuePressed(
      RefundContinuePressed event, Emitter<RefundState> emit) {
    try {
      emit(RefundRequestPhase2State(
          reasonRefundType: event.chosenReason,
          mediaList: event.mediaList,
          note: event.note));
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onRefundChooseMultipleMedia(
      RefundChooseMultipleMedia event, Emitter<RefundState> emit) async {
    try {
      if (state is RefundRequestPhase2State) {
        final currentState = state as RefundRequestPhase2State;
        final mediaList = event.chosenMediaList
            .where((element) => element != null)
            .map((e) => File(e!.path))
            .toList();
        final totalLength = mediaList.length + currentState.mediaList.length;
        if (totalLength > 6) {
          EasyLoading.showError("You only can upload maximum 6 files");
          return;
        }
        emit(currentState.copyWith(
            mediaList: List.from(currentState.mediaList)..addAll(mediaList)));
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onRefundRemoveMedia(
      RefundRemoveMedia event, Emitter<RefundState> emit) async {
    try {
      if (state is RefundRequestPhase2State) {
        final currentState = state as RefundRequestPhase2State;
        emit(currentState.copyWith(
            mediaList: List.from(currentState.mediaList)
              ..remove(event.chosenMedia)));
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onRefundSetNote(
      RefundSetNote event, Emitter<RefundState> emit) async {
    try {
      if (state is RefundRequestPhase2State) {
        final currentState = state as RefundRequestPhase2State;
        emit(currentState.copyWith(note: event.note));
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onRefundCreateRequestPressed(
      RefundCreateRequestPressed event, Emitter<RefundState> emit) async {
    try {
      if (state is RefundRequestPhase2State) {
        final currentState = state as RefundRequestPhase2State;
        EasyLoading.show(maskType: EasyLoadingMaskType.black);
        final requestParams = RefundRequestParams(
            reason: currentState.reasonRefundType.getString(),
            mediaList: currentState.mediaList,
            note: event.note);
        await _refundUseCase.createRefundRequest(event.orderId, requestParams);
        EasyLoading.dismiss();
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onRefundLoadDetail(
      RefundLoadDetail event, Emitter<RefundState> emit) async {
    try {
      EasyLoading.show();
      final refundDetail = await _refundUseCase.getRefundDetail(event.orderId);
      EasyLoading.dismiss();
      emit(RefundLoadDetailSuccessState(refundDetail: refundDetail));
    } catch (e) {
      emit(RefundLoadDetailFailure());
    }
  }
}
