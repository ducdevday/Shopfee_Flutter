import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/data/models/event_log.dart';
import 'package:shopfee/data/models/status_order.dart';
import 'package:shopfee/data/repositories/firebase/firebase_repository.dart';
import 'package:shopfee/data/repositories/order/order_repository.dart';
import 'package:shopfee/data/repositories/transaction/transaction_repository.dart';

part 'vnpay_state.dart';

class VnpayCubit extends Cubit<VnpayState> {
  final TransactionRepository transactionRepository;
  final OrderRepository orderRepository;
  final FirebaseRepository firebaseRepository;

  VnpayCubit(
      {required this.transactionRepository,
      required this.orderRepository,
      required this.firebaseRepository})
      : super(VnpayInitial());

  void initVnpay() {
    emit(VnpayLoaded());
  }

  Future<void> handlePayment(
      {required String transactionId, required String orderId}) async {
    try {
      EasyLoading.show(status: 'Processing...', maskType: EasyLoadingMaskType.black);
      var response =
          await transactionRepository.updateTransaction(transactionId);
      if (response.success && response.data!["status"] == "PAID") {
        emit(VnpaySuccess());
      } else {
        final eventLog = EventLog(OrderStatus.CANCELED, DateTime.now(),
            "Online Payment Canceled", false);
        await orderRepository.addEventLog(orderId, eventLog);
        await firebaseRepository.sendOrderMessage(
            "Shopfee For Employee Announce",
            "The order ${orderId} was canceled. Please tap to see details",
            orderId);
        emit(VnpayCanceled());
      }
      EasyLoading.dismiss();
    } catch (e) {
      print(e);
      emit(VnpayCanceled());
    }
  }
}
