part of receipt;

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  final ReceiptUseCase _receiptUseCase;

  ReceiptBloc(this._receiptUseCase) : super(ReceiptInitial()) {
    on<ReceiptLoadInformation>(_onReceiptLoadInformation);
    on<ReceiptAddEventLog>(_onReceiptAddEventLog);
    on<ChooseReasonCancel>(_onChooseReasonCancel);
  }

  FutureOr<void> _onReceiptLoadInformation(
      ReceiptLoadInformation event, Emitter<ReceiptState> emit) async {
    try {
      emit(ReceiptLoadInProcess());
      final response = await Future.wait([
        _receiptUseCase.getDetailsOrder(event.orderId),
        _receiptUseCase.getLastStatusOrder(event.orderId)
      ]);
      final ReceiptEntity receipt = response[0] as ReceiptEntity;
      final EventLogEntity lastEventLog = response[1] as EventLogEntity;
      emit(ReceiptLoadSuccess(receipt: receipt, lastEventLog: lastEventLog, isCancelButtonClicked: event.isCancelButtonClicked));
    } catch (e) {
      emit(ReceiptLoadFailure());
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onReceiptAddEventLog(
      ReceiptAddEventLog event, Emitter<ReceiptState> emit) async {
    if (state is ReceiptLoadSuccess) {
      final currentState = state as ReceiptLoadSuccess;
      try {
        EasyLoading.show(maskType: EasyLoadingMaskType.black);
        var response =
            await _receiptUseCase.addEventLog(event.orderId, event.eventLog);
        EasyLoading.dismiss();
        EasyLoading.showSuccess("Canceled",
            duration: Duration(milliseconds: 2000));

        //! Reload Page
        add(ReceiptLoadInformation(
            orderId: event.orderId, isCancelButtonClicked: true));
      } catch (e) {
        print(e);
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
