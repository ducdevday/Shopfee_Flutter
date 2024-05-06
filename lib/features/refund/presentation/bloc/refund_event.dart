part of refund;

abstract class RefundEvent extends Equatable {
  const RefundEvent();
}

class RefundInitRequest extends RefundEvent {
  @override
  List<Object> get props => [];
}

class RefundChooseReasonPressed extends RefundEvent {
  final ReasonRefundType reasonRefundType;

  const RefundChooseReasonPressed({
    required this.reasonRefundType,
  });

  @override
  List<Object> get props => [reasonRefundType];
}

class RefundContinuePressed extends RefundEvent {
  final ReasonRefundType chosenReason;
  final List<File> mediaList;
  final String note;

  const RefundContinuePressed({required this.chosenReason,
    required this.mediaList,
    required this.note});

  @override
  List<Object> get props => [chosenReason, mediaList, note];
}

class RefundSetNote extends RefundEvent {
  final String note;

  const RefundSetNote({
    required this.note,
  });

  @override
  List<Object> get props => [note];
}

class RefundChooseMultipleMedia extends RefundEvent {
  final List<XFile?> chosenMediaList;

  const RefundChooseMultipleMedia({
    required this.chosenMediaList,
  });

  @override
  List<Object> get props => [chosenMediaList];
}

class RefundRemoveMedia extends RefundEvent {
  final File chosenMedia;

  const RefundRemoveMedia({
    required this.chosenMedia,
  });

  @override
  List<Object> get props => [chosenMedia];
}

class RefundCreateRequestPressed extends RefundEvent {
  final String orderId;
  final String note;

  const RefundCreateRequestPressed({
    required this.orderId,
    required this.note,
  });

  @override
  List<Object> get props => [orderId, note];
}

class RefundLoadDetail extends RefundEvent {
  final String orderId;

  const RefundLoadDetail({
    required this.orderId,
  });

  @override
  List<Object> get props => [orderId];
}
