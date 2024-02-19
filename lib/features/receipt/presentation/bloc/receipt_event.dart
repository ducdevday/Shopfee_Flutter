part of receipt;

abstract class ReceiptEvent extends Equatable {
  const ReceiptEvent();
}

class ReceiptLoadInformation extends ReceiptEvent {
  final String orderId;
  final bool isCancelButtonClicked;

  const ReceiptLoadInformation(
      {required this.orderId, this.isCancelButtonClicked = false});

  @override
  List<Object> get props => [orderId];
}

class ReceiptAddEventLog extends ReceiptEvent {
  final String orderId;
  final EventLogEntity eventLog;

  const ReceiptAddEventLog({
    required this.orderId,
    required this.eventLog,
  });

  @override
  List<Object> get props => [orderId, eventLog];
}

class ChooseReasonCancel extends ReceiptEvent {
  final ReasonCancelType reasonCancel;

  const ChooseReasonCancel({
    required this.reasonCancel,
  });

  @override
  List<Object> get props => [reasonCancel];
}
