part of receipt;

abstract class ReceiptEvent extends Equatable {
  const ReceiptEvent();
}

class ReceiptLoadInformation extends ReceiptEvent {
  final String orderId;
  final bool haveChanged;

  const ReceiptLoadInformation(
      {required this.orderId, this.haveChanged = false});

  @override
  List<Object> get props => [orderId];
}

class ReceiptRefreshInformation extends ReceiptEvent {
  final String orderId;

  ReceiptRefreshInformation({required this.orderId});
  @override
  List<Object> get props => [orderId];
}

class ReceiptDoCancelOrder extends ReceiptEvent {
  final String orderId;

  const ReceiptDoCancelOrder({
    required this.orderId,
  });

  @override
  List<Object> get props => [orderId];
}

class ChooseReasonCancel extends ReceiptEvent {
  final ReasonCancelType reasonCancel;

  const ChooseReasonCancel({
    required this.reasonCancel,
  });

  @override
  List<Object> get props => [reasonCancel];
}
