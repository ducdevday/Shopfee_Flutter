import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  Future<void> initCheckout() async{
    emit(CheckoutLoading());
    Future.delayed(Duration(milliseconds: 3000));
    emit(CheckoutLoaded());
  }
  

}
