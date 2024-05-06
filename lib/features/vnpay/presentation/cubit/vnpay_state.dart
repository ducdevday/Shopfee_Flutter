part of vnpay;

abstract class VnPayState extends Equatable {
  const VnPayState();
}

class VnPayInitial extends VnPayState {
  @override
  List<Object> get props => [];
}

class VnPayFinished extends VnPayState {
  @override
  List<Object> get props => [];
}