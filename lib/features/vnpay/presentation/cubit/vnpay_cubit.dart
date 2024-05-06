part of vnpay;

class VnPayCubit extends Cubit<VnPayState> {
  final VnPayUseCase _vnPayUseCase;

  VnPayCubit(this._vnPayUseCase) : super(VnPayInitial());

  Future<void> handlePayment({required String transactionId}) async {
    try {
      EasyLoading.show(
          status: 'Processing...', maskType: EasyLoadingMaskType.black);
      await _vnPayUseCase.updateTransaction(transactionId);
      EasyLoading.dismiss();
      emit(VnPayFinished());
    } catch (e) {
      ExceptionUtil.handle(e);
      emit(VnPayFinished());
    }
  }
}
