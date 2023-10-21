import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopfee/data/models/event_log.dart';
import 'package:shopfee/data/models/receipt.dart';
import 'package:shopfee/data/models/status_order.dart';
import 'package:shopfee/data/repositories/order/order_repository.dart';

part 'receipt_event.dart';

part 'receipt_state.dart';

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  final OrderRepository orderRepository;

  ReceiptBloc({required this.orderRepository}) : super(ReceiptInitial()) {
    on<LoadReceipt>(_onLoadReceipt);
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
}
