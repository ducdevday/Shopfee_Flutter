part of 'receipt_bloc.dart';

abstract class ReceiptEvent extends Equatable {
  const ReceiptEvent();
}

class LoadReceipt extends ReceiptEvent {
  final String orderId;

  const LoadReceipt({
    required this.orderId,
  });

  @override
  List<Object> get props => [orderId];
}

class AddEventLog extends ReceiptEvent {
  final String orderId;
  final EventLog eventLog;

  const AddEventLog({
    required this.orderId,
    required this.eventLog,
  });

  @override
  List<Object> get props => [orderId, eventLog];
}

class ChooseReasonCancel extends ReceiptEvent {
  final String reason;

  const ChooseReasonCancel({
    required this.reason,
  });

  @override
  List<Object> get props => [reason];
}