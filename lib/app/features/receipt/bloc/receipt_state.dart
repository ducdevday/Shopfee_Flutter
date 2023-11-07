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
  final String reasonCancel;

  const ReceiptLoaded({
    required this.receipt,
    required this.eventLog,
    this.reasonCancel = "I want to update address",
  });

  bool get isSuccess => eventLog.orderStatus == OrderStatus.SUCCEED;

  @override
  List<Object> get props => [receipt, eventLog, reasonCancel];

  ReceiptLoaded copyWith({
    Receipt? receipt,
    EventLog? eventLog,
    String? reasonCancel,
  }) {
    return ReceiptLoaded(
      receipt: receipt ?? this.receipt,
      eventLog: eventLog ?? this.eventLog,
      reasonCancel: reasonCancel ?? this.reasonCancel,
    );
  }
}

class ReceiptError extends ReceiptState {
  @override
  List<Object> get props => [];
}

class ReceiptFinished extends ReceiptState {
  @override
  List<Object> get props => [];
}
