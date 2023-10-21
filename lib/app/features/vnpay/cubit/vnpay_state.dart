part of 'vnpay_cubit.dart';

abstract class VnpayState extends Equatable {
  const VnpayState();
}

class VnpayInitial extends VnpayState {
  @override
  List<Object> get props => [];
}

class VnpayLoaded extends VnpayState {
  @override
  List<Object> get props => [];
}

class VnpaySuccess extends VnpayState {
  @override
  List<Object> get props => [];
}

class VnpayCanceled extends VnpayState {
  @override
  List<Object> get props => [];
}
