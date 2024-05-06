part of refund;

abstract class RefundState extends Equatable {
  const RefundState();
}

class RefundInitial extends RefundState {
  @override
  List<Object> get props => [];
}

class RefundRequestPhase1State extends RefundState {
  final ReasonRefundType? reasonRefundType;

  const RefundRequestPhase1State({
    this.reasonRefundType,
  });

  @override
  List<Object?> get props => [reasonRefundType];
}

class RefundRequestPhase2State extends RefundState {
  final ReasonRefundType reasonRefundType;
  final List<File> mediaList;
  final String note;

  @override
  List<Object?> get props => [reasonRefundType, mediaList, note];

  const RefundRequestPhase2State({
    required this.reasonRefundType,
    required this.mediaList,
    required this.note,
  });

  RefundRequestPhase2State copyWith({
    ReasonRefundType? reasonRefundType,
    List<File>? mediaList,
    String? note,
  }) {
    return RefundRequestPhase2State(
      reasonRefundType: reasonRefundType ?? this.reasonRefundType,
      mediaList: mediaList ?? this.mediaList,
      note: note ?? this.note,
    );
  }
}

class RefundRequestFinished extends RefundState {
  @override
  List<Object> get props => [];
}

class RefundLoadDetailSuccessState extends RefundState {
  final RefundDetailEntity refundDetail;

  const RefundLoadDetailSuccessState({
    required this.refundDetail,
  });

  @override
  List<Object> get props => [refundDetail];
}

class RefundLoadDetailFailure extends RefundState {
  @override
  List<Object> get props => [];
}
