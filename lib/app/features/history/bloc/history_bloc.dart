import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopfee/app/common/data/global_data.dart';
import 'package:shopfee/app/features/history/screen/history_screen.dart';
import 'package:shopfee/data/models/order_history.dart';
import 'package:shopfee/data/models/status_order.dart';
import 'package:shopfee/data/repositories/order/order_repository.dart';

part 'history_event.dart';

part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final OrderRepository orderRepository;

  HistoryBloc({required this.orderRepository}) : super(HistoryInitial()) {
    on<LoadHistory>(_onLoadHistory);
  }

  FutureOr<void> _onLoadHistory(
      LoadHistory event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading());
    if(GlobalData.ins.userId == null){
      emit(HistoryNotAuth());
      return;
    }
    List<OrderHistory> orderHistoryList = [];
    try {
      if (event.historyStatus == HistoryStatus.Processing) {
        var responseCreated = await orderRepository.getHistoryOrder(
            GlobalData.ins.userId!, OrderStatus.CREATED);
        var responseAccepted = await orderRepository.getHistoryOrder(
            GlobalData.ins.userId!, OrderStatus.ACCEPTED);
        var responseDelivering = await orderRepository.getHistoryOrder(
            GlobalData.ins.userId!, OrderStatus.DELIVERING);

        if (responseCreated.success &&
            responseAccepted.success &&
            responseDelivering.success) {
          List<OrderHistory> orderHistoryCreatedList = responseCreated.data!
              .map((e) => OrderHistory.fromJson(e))
              .toList();

          List<OrderHistory> orderHistoryAcceptedList = responseAccepted.data!
              .map((e) => OrderHistory.fromJson(e))
              .toList();

          List<OrderHistory> orderHistoryDeliveringList = responseDelivering
              .data!
              .map((e) => OrderHistory.fromJson(e))
              .toList();

          orderHistoryList.addAll(orderHistoryCreatedList);
          orderHistoryList.addAll(orderHistoryAcceptedList);
          orderHistoryList.addAll(orderHistoryDeliveringList);
        }
      }
      else if(event.historyStatus == HistoryStatus.Done){
        var responseSucceed = await orderRepository.getHistoryOrder(
            GlobalData.ins.userId!, OrderStatus.SUCCEED);
        if(responseSucceed.success){
          List<OrderHistory> orderHistoryDoneList = responseSucceed.data!
              .map((e) => OrderHistory.fromJson(e))
              .toList();
          orderHistoryList.addAll(orderHistoryDoneList);
        }
      }
      else if(event.historyStatus == HistoryStatus.Canceled){
        var responseCanceled = await orderRepository.getHistoryOrder(
            GlobalData.ins.userId!, OrderStatus.CANCELED);
        if(responseCanceled.success){
          List<OrderHistory> orderHistoryCanceledList = responseCanceled.data!
              .map((e) => OrderHistory.fromJson(e))
              .toList();
          orderHistoryList.addAll(orderHistoryCanceledList);
        }
      }
      emit(HistoryLoaded(
          historyStatus: event.historyStatus,
          orderHistoryList: orderHistoryList));

    } catch (e) {
      print(e);
      emit(HistoryError());
    }
  }
}
