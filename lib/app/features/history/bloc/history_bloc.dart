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
    on<LoadMoreHistory>(_onLoadMoreHistory);
  }

  FutureOr<void> _onLoadHistory(
      LoadHistory event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading());
    if (GlobalData.ins.userId == null) {
      emit(HistoryNotAuth());
      return;
    }
    List<OrderHistory> orderHistoryList = [];
    int page = 1;
    int size = 8;
    try {
      await Future.delayed(Duration(milliseconds: 500));
      if (event.historyStatus == HistoryStatus.Processing) {
        var responseCreated = await orderRepository.getHistoryOrder(
            GlobalData.ins.userId!, OrderStatus.CREATED,
            page: page, size: size);
        var responseAccepted = await orderRepository.getHistoryOrder(
            GlobalData.ins.userId!, OrderStatus.ACCEPTED,
            page: page, size: size);
        var responseDelivering = await orderRepository.getHistoryOrder(
            GlobalData.ins.userId!, OrderStatus.DELIVERING,
            page: page, size: size);

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
      } else if (event.historyStatus == HistoryStatus.Done) {
        var responseSucceed = await orderRepository.getHistoryOrder(
            GlobalData.ins.userId!, OrderStatus.SUCCEED,
            page: page, size: size);
        if (responseSucceed.success) {
          List<OrderHistory> orderHistoryDoneList = responseSucceed.data!
              .map((e) => OrderHistory.fromJson(e))
              .toList();
          orderHistoryList.addAll(orderHistoryDoneList);
        }
      } else if (event.historyStatus == HistoryStatus.Canceled) {
        var responseCanceled = await orderRepository.getHistoryOrder(
            GlobalData.ins.userId!, OrderStatus.CANCELED,
            page: page, size: size);
        if (responseCanceled.success) {
          List<OrderHistory> orderHistoryCanceledList = responseCanceled.data!
              .map((e) => OrderHistory.fromJson(e))
              .toList();
          orderHistoryList.addAll(orderHistoryCanceledList);
        }
      }
      emit(HistoryLoaded(
          historyStatus: event.historyStatus,
          orderHistoryList: orderHistoryList,
          page: page,
          size: size));
    } catch (e) {
      print(e);
      emit(HistoryError());
    }
  }

  FutureOr<void> _onLoadMoreHistory(
      LoadMoreHistory event, Emitter<HistoryState> emit) async {
    List<OrderHistory> orderMoreHistoryList = [];
    if (state is HistoryLoaded) {
      final currentState = state as HistoryLoaded;
      emit(currentState.copyWith(isLoadMore: true));
      await Future.delayed(Duration(milliseconds: 1000));
      if (event.historyStatus == HistoryStatus.Processing) {
        var responseCreated = await orderRepository.getHistoryOrder(
            GlobalData.ins.userId!, OrderStatus.CREATED,
            page: currentState.page + 1, size: currentState.size);
        var responseAccepted = await orderRepository.getHistoryOrder(
            GlobalData.ins.userId!, OrderStatus.ACCEPTED,
            page: currentState.page + 1, size: currentState.size);
        var responseDelivering = await orderRepository.getHistoryOrder(
            GlobalData.ins.userId!, OrderStatus.DELIVERING,
            page: currentState.page + 1, size: currentState.size);

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
          orderMoreHistoryList.addAll(orderHistoryCreatedList);
          orderMoreHistoryList.addAll(orderHistoryAcceptedList);
          orderMoreHistoryList.addAll(orderHistoryDeliveringList);

          if (orderMoreHistoryList.isNotEmpty) {
            emit(currentState.copyWith(
                orderHistoryList: List.from(currentState.orderHistoryList)
                  ..addAll(orderMoreHistoryList),
                page: currentState.page + 1,
                isLoadMore: false));
          } else {
            emit(currentState.copyWith(cannotLoadMore: true));
          }
        }
      } else if (event.historyStatus == HistoryStatus.Done) {
        var responseSucceed = await orderRepository.getHistoryOrder(
            GlobalData.ins.userId!, OrderStatus.SUCCEED,
            page: currentState.page + 1, size: currentState.size);
        if (responseSucceed.success) {
          List<OrderHistory> orderHistoryDoneList = responseSucceed.data!
              .map((e) => OrderHistory.fromJson(e))
              .toList();
          orderMoreHistoryList.addAll(orderHistoryDoneList);
          if (orderMoreHistoryList.isNotEmpty) {
            emit(currentState.copyWith(
                orderHistoryList: List.from(currentState.orderHistoryList)
                  ..addAll(orderMoreHistoryList),
                page: currentState.page + 1,
                isLoadMore: false));
          } else {
            emit(currentState.copyWith(cannotLoadMore: true));
          }
        }
      } else if (event.historyStatus == HistoryStatus.Canceled) {
        var responseCanceled = await orderRepository.getHistoryOrder(
            GlobalData.ins.userId!, OrderStatus.CANCELED,
            page: currentState.page + 1, size: currentState.size);
        if (responseCanceled.success) {
          List<OrderHistory> orderHistoryCanceledList = responseCanceled.data!
              .map((e) => OrderHistory.fromJson(e))
              .toList();
          orderMoreHistoryList.addAll(orderHistoryCanceledList);
          if (orderMoreHistoryList.isNotEmpty) {
            emit(currentState.copyWith(
                orderHistoryList: List.from(currentState.orderHistoryList)
                  ..addAll(orderMoreHistoryList),
                page: currentState.page + 1,
                isLoadMore: false));
          } else {
            emit(currentState.copyWith(cannotLoadMore: true));
          }
        }
      }
    }
  }
}
