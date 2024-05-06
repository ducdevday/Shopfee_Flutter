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
  final List<EventLogEntity> eventLogs;
  final ReasonCancelType? reasonCancel;
  final OrderStatus? cancelType;
  final bool
      isCancelButtonClicked; // ? Mục đích reload tại trang history nếu có event thay đổi

  EventLogEntity get lastEventLog => eventLogs.first;

  const ReceiptLoadSuccess(
      {required this.receipt,
      required this.eventLogs,
      this.reasonCancel,
      this.cancelType,
      this.isCancelButtonClicked = false});

  ReceiptLoadSuccess copyWith({
    ReceiptEntity? receipt,
    List<EventLogEntity>? eventLogs,
    ReasonCancelType? reasonCancel,
    OrderStatus? cancelType,
    bool? isCancelButtonClicked,
  }) {
    return ReceiptLoadSuccess(
      receipt: receipt ?? this.receipt,
      eventLogs: eventLogs ?? this.eventLogs,
      reasonCancel: reasonCancel ?? this.reasonCancel,
      cancelType: cancelType ?? this.cancelType,
      isCancelButtonClicked:
          isCancelButtonClicked ?? this.isCancelButtonClicked,
    );
  }

  @override
  List<Object?> get props => [
        receipt,
        eventLogs,
        reasonCancel,
        cancelType,
        isCancelButtonClicked,
      ];
}

class ReceiptLoadFailure extends ReceiptState {
  @override
  List<Object> get props => [];
}
