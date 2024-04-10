part of refund;

abstract class RefundState extends Equatable {
  const RefundState();
}

class RefundInitial extends RefundState {
  @override
  List<Object> get props => [];
}

class RefundRequestState extends RefundState {
  @override
  List<Object> get props => [];
}
