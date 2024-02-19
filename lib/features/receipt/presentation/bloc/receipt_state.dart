part of receipt;

abstract class ReceiptState extends Equatable {
  const ReceiptState();
}

class ReceiptInitial extends ReceiptState {
  @override
  List<Object> get props => [];
}

class ReceiptLoadInProcess extends ReceiptState {
  @override
  List<Object> get props => [];
}

class ReceiptLoadSuccess extends ReceiptState {
  final ReceiptEntity receipt;
  final EventLogEntity lastEventLog;
  final ReasonCancelType? reasonCancel;
  final bool isCancelButtonClicked;

  const ReceiptLoadSuccess(
      {required this.receipt,
      required this.lastEventLog,
      this.reasonCancel,
      this.isCancelButtonClicked = false});

  bool get isOrderSuccess => lastEventLog.orderStatus == OrderStatus.SUCCEED;

  ReceiptLoadSuccess copyWith({
    ReceiptEntity? receipt,
    EventLogEntity? lastEventLog,
    ReasonCancelType? reasonCancel,
    bool? isCancelButtonClicked,
  }) {
    return ReceiptLoadSuccess(
      receipt: receipt ?? this.receipt,
      lastEventLog: lastEventLog ?? this.lastEventLog,
      reasonCancel: reasonCancel ?? this.reasonCancel,
      isCancelButtonClicked:
          isCancelButtonClicked ?? this.isCancelButtonClicked,
    );
  }

  @override
  List<Object?> get props =>
      [receipt, lastEventLog, reasonCancel, isCancelButtonClicked];
}

class ReceiptLoadFailure extends ReceiptState {
  @override
  List<Object> get props => [];
}
