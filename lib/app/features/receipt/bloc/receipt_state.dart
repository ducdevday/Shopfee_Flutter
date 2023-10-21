part of 'receipt_bloc.dart';

abstract class ReceiptState extends Equatable {
  const ReceiptState();
}

class ReceiptInitial extends ReceiptState {
  @override
  List<Object> get props => [];
}

class ReceiptLoading extends ReceiptState {
  @override
  List<Object> get props => [];
}

class ReceiptLoaded extends ReceiptState {
  final Receipt receipt;
  final EventLog eventLog;

  const ReceiptLoaded( {required this.receipt, required this.eventLog});

  bool get isSuccess => eventLog.orderStatus == OrderStatus.SUCCEED;

  @override
  List<Object> get props => [receipt, eventLog];
}

class ReceiptError extends ReceiptState {
  @override
  List<Object> get props => [];
}

class ReceiptFinished extends ReceiptState {
  @override
  List<Object> get props => [];
}