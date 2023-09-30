part of 'receipt_cubit.dart';

abstract class ReceiptState extends Equatable {
  const ReceiptState();
}

class ReceiptInitial extends ReceiptState {
  @override
  List<Object> get props => [];
}

class ReceiptLoading extends ReceiptState{
  @override
  List<Object> get props => [];
}

class ReceiptLoaded extends ReceiptState{
  @override
  List<Object> get props => [];
}