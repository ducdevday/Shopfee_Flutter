part of 'checkout_cubit.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();
}

class CheckoutInitial extends CheckoutState {
  @override
  List<Object> get props => [];
}

class CheckoutLoading extends CheckoutState{
  @override
  List<Object> get props => [];
}

class CheckoutLoaded extends CheckoutState{
  @override
  List<Object> get props => [];
}