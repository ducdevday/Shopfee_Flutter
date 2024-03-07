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

class CartDeleteInformation extends CartEvent {
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

class CartDeleteItem extends CartEvent {
  final int index;

  const CartDeleteItem({
    required this.index,
  });

  @override
  List<Object> get props => [index];
}

class CartChooseOrderType extends CartEvent {
  final OrderType typeOrder;

  const CartChooseOrderType({required this.typeOrder});

  @override
  List<Object> get props => [typeOrder];
}

class CartChooseAddress extends CartEvent {
  final String addressId;

  const CartChooseAddress({required this.addressId});

  @override
  List<Object> get props => [addressId];
}

class CartAddNote extends CartEvent {
  final String note;

  const CartAddNote({required this.note});

  @override
  List<Object> get props => [note];
}

class CartChooseTypePayment extends CartEvent {
  final PaymentType typePayment;

  const CartChooseTypePayment({required this.typePayment});

  @override
  List<Object> get props => [typePayment];
}

class CartChooseTime extends CartEvent {
  final DateTime receiveTime;

  const CartChooseTime({
    required this.receiveTime,
  });

  @override
  List<Object> get props => [receiveTime];
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

  const SetShippingFee({required this.shippingFee});

  @override
  List<Object> get props => [shippingFee];
}

class CartCreateShippingOrder extends CartEvent {
  @override
  List<Object> get props => [];
}
