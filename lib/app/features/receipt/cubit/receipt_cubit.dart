import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'receipt_state.dart';

class ReceiptCubit extends Cubit<ReceiptState> {
  ReceiptCubit() : super(ReceiptInitial());

  Future<void> initCheckout() async {
    emit(ReceiptLoading());
    Future.delayed(Duration(milliseconds: 3000), () {
      emit(ReceiptLoaded());
    });
  }
}
