import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/data/models/event_log.dart';
import 'package:shopfee/data/models/receipt.dart';
import 'package:shopfee/data/models/status_order.dart';
import 'package:shopfee/data/repositories/firebase/firebase_repository.dart';
import 'package:shopfee/data/repositories/order/order_repository.dart';

part 'receipt_event.dart';

part 'receipt_state.dart';

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  final OrderRepository orderRepository;
  final FirebaseRepository firebaseRepository;
  ReceiptBloc({required this.orderRepository, required this.firebaseRepository}) : super(ReceiptInitial()) {
    on<LoadReceipt>(_onLoadReceipt);
    on<ChooseReasonCancel>(_onChooseReasonCancel);
    on<AddEventLog>(_onAddEventLog);
  }

  FutureOr<void> _onLoadReceipt(
      LoadReceipt event, Emitter<ReceiptState> emit) async {
    emit(ReceiptLoading());
    await Future.delayed(Duration(seconds: 2));
    try {
      var response = await orderRepository.getDetailsOrder(event.orderId);
      var responseEventLog =
          await orderRepository.getStatusOrder(event.orderId);
      if (response.success && responseEventLog.success) {
        final receipt = Receipt.fromJson(response.data!);
        final eventLogs =
            responseEventLog.data?.map((e) => EventLog.fromJson(e)).toList();
        final lastEventLog = eventLogs![eventLogs.length - 1];
        emit(ReceiptLoaded(receipt: receipt, eventLog: lastEventLog));
      } else {
        emit(ReceiptError());
      }
    } catch (e) {
      print(e);
      emit(ReceiptError());
    }
  }

  FutureOr<void> _onChooseReasonCancel(
      ChooseReasonCancel event, Emitter<ReceiptState> emit) {
    if (state is ReceiptLoaded) {
      final currentState = state as ReceiptLoaded;
      emit(currentState.copyWith(reasonCancel: event.reason));
    }
  }

  FutureOr<void> _onAddEventLog(
      AddEventLog event, Emitter<ReceiptState> emit) async {
    if (state is ReceiptLoaded) {
      final currentState = state as ReceiptLoaded;
      try {
        EasyLoading.show();
        var response =
            await orderRepository.addEventLog(event.orderId, event.eventLog);
        EasyLoading.dismiss();
        if (response.success) {
          emit(currentState.copyWith(eventLog: event.eventLog));
          EasyLoading.showSuccess("Canceled", duration: Duration(milliseconds: 2000));
        }
        var responseNotify = await firebaseRepository.sendOrderMessage(
            "Shopfee For Employee Announce",
            "The order ${event.orderId} was canceled. Please tap to see details",
            event.orderId);
      } catch (e) {
        print(e);
        EasyLoading.showError("Something went wrong");
      }
    }
  }
}
