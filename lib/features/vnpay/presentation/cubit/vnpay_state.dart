part of vnpay;

abstract class VnPayState extends Equatable {
  const VnPayState();
}

class VnPayInitial extends VnPayState {
  @override
  List<Object> get props => [];
}

class VnPaySuccess extends VnPayState {
  @override
  List<Object> get props => [];
}

class VnPayCanceled extends VnPayState {
  @override
  List<Object> get props => [];
}
