part of receipt;

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  final ReceiptUseCase _receiptUseCase;

  ReceiptBloc(this._receiptUseCase) : super(ReceiptInitial()) {
    on<ReceiptLoadInformation>(_onReceiptLoadInformation);
    on<ReceiptRefreshInformation>(_onReceiptRefreshInformation);
    on<ReceiptDoCancelOrder>(_onReceiptDoCancelOrder);
    on<ChooseReasonCancel>(_onChooseReasonCancel);
  }

  FutureOr<void> _onReceiptLoadInformation(
      ReceiptLoadInformation event, Emitter<ReceiptState> emit) async {
    try {
      emit(ReceiptLoadInProcess());
      final response = await Future.wait([
        _receiptUseCase.getDetailsOrder(event.orderId),
        _receiptUseCase.getEventLogsOrder(event.orderId)
      ]);
      final ReceiptEntity receipt = response[0] as ReceiptEntity;
      final List<EventLogEntity> eventLogs =
          response[1] as List<EventLogEntity>;
      final OrderStatus? cancelType =
          _receiptUseCase.determineCancelType(eventLogs[0]);
      emit(ReceiptLoadSuccess(
          receipt: receipt,
          eventLogs: eventLogs,
          isCancelButtonClicked: event.haveChanged,
          cancelType: cancelType));
    } catch (e) {
      emit(ReceiptLoadFailure());
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onReceiptRefreshInformation(
      ReceiptRefreshInformation event, Emitter<ReceiptState> emit) async {
    try {
        EasyLoading.show();
        final response = await Future.wait([
          _receiptUseCase.getDetailsOrder(event.orderId),
          _receiptUseCase.getEventLogsOrder(event.orderId)
        ]);
        EasyLoading.dismiss();
        final ReceiptEntity receipt = response[0] as ReceiptEntity;
        final List<EventLogEntity> eventLogs =
            response[1] as List<EventLogEntity>;
        final OrderStatus? cancelType =
            _receiptUseCase.determineCancelType(eventLogs[0]);
        emit(ReceiptLoadSuccess(
            receipt: receipt,
            eventLogs: eventLogs,
            isCancelButtonClicked: true,
            cancelType: cancelType));
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onReceiptDoCancelOrder(
      ReceiptDoCancelOrder event, Emitter<ReceiptState> emit) async {
    if (state is ReceiptLoadSuccess) {
      final currentState = state as ReceiptLoadSuccess;
      try {
        if (currentState.cancelType != null) {
          EasyLoading.show(maskType: EasyLoadingMaskType.black);
          if (currentState.cancelType == OrderStatus.CANCELED) {
            await _receiptUseCase.cancelOrder(
              currentState.receipt.branch!.id!,
                event.orderId, currentState.reasonCancel!.getString());
            EasyLoading.dismiss();
            EasyLoading.showSuccess("Canceled",
                duration: const Duration(seconds: 1));
          } else {
            await _receiptUseCase.requestCancelOrder(
                currentState.receipt.branch!.id!,
                event.orderId, currentState.reasonCancel!.getString());
            EasyLoading.dismiss();
            EasyLoading.showSuccess("Cancel Request Send",
                duration: const Duration(seconds: 1));
          }
          //! Reload Page
          add(ReceiptLoadInformation(
              orderId: event.orderId, haveChanged: true));
        }
      } catch (e) {
        EasyLoading.showError("Something went wrong");
        ExceptionUtil.handle(e);
      }
    }
  }

  FutureOr<void> _onChooseReasonCancel(
      ChooseReasonCancel event, Emitter<ReceiptState> emit) async {
    if (state is ReceiptLoadSuccess) {
      final currentState = state as ReceiptLoadSuccess;
      emit(currentState.copyWith(reasonCancel: event.reasonCancel));
    }
  }
}
