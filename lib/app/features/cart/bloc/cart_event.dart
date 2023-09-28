part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class LoadCart extends CartEvent {
  @override
  List<Object> get props => [];
}

class AddItemIntoCart extends CartEvent {
  final Order order;

  const AddItemIntoCart({
    required this.order,
  });

  @override
  List<Object> get props => [order];
}

class ChooseTypeDelivery extends CartEvent {
  final TypeDelivery typeDelivery;

  ChooseTypeDelivery(this.typeDelivery);

  @override
  List<Object> get props => [typeDelivery];
}

class ChooseAddress extends CartEvent {
  final String address;

  ChooseAddress(this.address);

  @override
  List<Object> get props => [address];
}

class WriteInstruction extends CartEvent {
  final String instruction;

  WriteInstruction(this.instruction);

  @override
  List<Object> get props => [instruction];
}

class ChooseDeliveryTime extends CartEvent {
  final DateTime deliveryTime;

  ChooseDeliveryTime(this.deliveryTime);

  @override
  List<Object> get props => [deliveryTime];
}

class ChooseTypePayment extends CartEvent {
  final TypePayment typePayment;

  ChooseTypePayment(this.typePayment);

  @override
  List<Object> get props => [typePayment];
}

class ChooseVoucher extends CartEvent {
  final Voucher voucher;

  ChooseVoucher(this.voucher);

  @override
  List<Object> get props => [voucher];
}

class SetShippingFee extends CartEvent {
  final double shippingFee;

  SetShippingFee(this.shippingFee);

  @override
  List<Object> get props => [shippingFee];
}
