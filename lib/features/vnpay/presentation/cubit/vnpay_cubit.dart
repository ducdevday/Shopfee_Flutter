part of vnpay;

class VnPayCubit extends Cubit<VnPayState> {
  final VnPayUseCase _vnPayUseCase;

  VnPayCubit(this._vnPayUseCase) : super(VnPayInitial());

  Future<void> handlePayment(
      {required String transactionId, required String orderId}) async {
    try {
      EasyLoading.show(
          status: 'Processing...', maskType: EasyLoadingMaskType.black);
      final status = await _vnPayUseCase.updateTransaction(transactionId);
      if (status == "PAID") {
        emit(VnPaySuccess());
      } else {
        final eventLog = EventLogEntity(
            orderStatus: OrderStatus.CANCELED,
            time: DateTime.now(),
            description: "Online Payment Canceled",
            makerByEmployee: false);
        await _vnPayUseCase.addEventLog(orderId, eventLog);
        emit(VnPayCanceled());
      }
      EasyLoading.dismiss();
    } catch (e) {
      emit(VnPayCanceled());
      ExceptionUtil.handle(e);
    }
  }
}
