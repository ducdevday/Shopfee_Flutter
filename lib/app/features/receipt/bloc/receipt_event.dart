part of 'receipt_bloc.dart';

abstract class ReceiptEvent extends Equatable {
  const ReceiptEvent();
}


class LoadReceipt extends ReceiptEvent {
  final String orderId;

  const LoadReceipt({
    required this.orderId,
  });

  @override
  List<Object> get props => [orderId];
}