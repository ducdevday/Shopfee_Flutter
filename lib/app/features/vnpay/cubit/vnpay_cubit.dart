import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopfee/data/repositories/transaction/transaction_repository.dart';

part 'vnpay_state.dart';

class VnpayCubit extends Cubit<VnpayState> {
  final TransactionRepository transactionRepository;

  VnpayCubit({required this.transactionRepository}) : super(VnpayInitial());

  void initVnpay() {
    emit(VnpayLoaded());
  }

  void doPayment(String transactionId)async {
    try{
      var response = await transactionRepository.updateTransaction(transactionId);
      if(response.success){
        emit(VnpaySuccess());
      }
      else{
        emit(VnpayCanceled());
      }
    }
    catch(e){
      print(e);
      emit(VnpayCanceled());
    }
  }

  Future<void> cancelPayment(String transactionId) async {
    try{
      var response = await transactionRepository.updateTransaction(transactionId);
      if(response.success){
        emit(VnpayCanceled());
      }
      else{
        emit(VnpayCanceled());
      }
    }
    catch(e){
      print(e);
      emit(VnpayCanceled());
    }
  }
}
