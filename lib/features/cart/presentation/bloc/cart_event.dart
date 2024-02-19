part of cart;

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class CartLoadInformation extends CartEvent {
  @override
  List<Object> get props => [];
}

class CartInitAddress extends CartEvent {
  @override
  List<Object> get props => [];
}

class CartDeleteInformation extends CartEvent{
  @override
  List<Object> get props => [];
}

class CartAddItem extends CartEvent {
  final OrderEntity order;

  const CartAddItem({
    required this.order,
  });

  @override
  List<Object> get props => [order];
}

class CartUpdateItem extends CartEvent {
  final OrderEntity updatedOrder;
  final int index;

  const CartUpdateItem({
    required this.updatedOrder,
    required this.index,
  });

  @override
  List<Object> get props => [updatedOrder, index];
}

class ChooseTypeDelivery extends CartEvent {
  final DeliveryType typeDelivery;

  ChooseTypeDelivery(this.typeDelivery);

  @override
  List<Object> get props => [typeDelivery];
}

class CartChooseAddress extends CartEvent {
  final String addressId;

  CartChooseAddress(this.addressId);

  @override
  List<Object> get props => [addressId];
}

class CartAddNote extends CartEvent {
  final String note;

  CartAddNote(this.note);

  @override
  List<Object> get props => [note];
}

class ChooseDeliveryTime extends CartEvent {
  final DateTime deliveryTime;

  ChooseDeliveryTime(this.deliveryTime);

  @override
  List<Object> get props => [deliveryTime];
}

class CartChooseTypePayment extends CartEvent {
  final PaymentType typePayment;

  CartChooseTypePayment(this.typePayment);

  @override
  List<Object> get props => [typePayment];
}

// class ChooseVoucher extends CartEvent {
//   final Voucher voucher;
//
//   ChooseVoucher(this.voucher);
//
//   @override
//   List<Object> get props => [voucher];
// }

class SetShippingFee extends CartEvent {
  final double shippingFee;

  SetShippingFee(this.shippingFee);

  @override
  List<Object> get props => [shippingFee];
}

class CartCreateShippingOrder extends CartEvent {
  @override
  List<Object> get props => [];
}
