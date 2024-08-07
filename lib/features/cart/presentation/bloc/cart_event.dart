part of cart;

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class CartLoadInformation extends CartEvent {
  @override
  List<Object> get props => [];
}

class CartUpdateOrderInformation extends CartEvent {
  @override
  List<Object> get props => [];
}

class CartInitAddressAndReceiver extends CartEvent {
  final ReceiverOnsiteEntity? receiverInformation;

  const CartInitAddressAndReceiver({
    this.receiverInformation,
  });

  @override
  List<Object?> get props => [receiverInformation];


}

class CartLoadReceiverInformation extends CartEvent {
  final ReceiverOnsiteEntity receiverInformation;

  const CartLoadReceiverInformation({
    required this.receiverInformation,
  });

  @override
  List<Object> get props => [receiverInformation];
}

class CartInitStore extends CartEvent {
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

class CartChooseShippingAddress extends CartEvent {
  final String addressId;

  const CartChooseShippingAddress({required this.addressId});

  @override
  List<Object> get props => [addressId];
}

class CartChooseStore extends CartEvent {
  final String branchId;

  const CartChooseStore({required this.branchId});

  @override
  List<Object> get props => [branchId];
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

class CartSetShippingFee extends CartEvent {
  final double lat;
  final double lng;

  const CartSetShippingFee({
    required this.lat,
    required this.lng,
  });

  @override
  List<Object> get props => [lat, lng];
}

class CartApplyCoin extends CartEvent {
  final num? coin;

  @override
  List<Object?> get props => [coin];

  const CartApplyCoin({
    this.coin,
  });
}

class CartRemoveCoin extends CartEvent {
  @override
  List<Object> get props => [];
}

class CartUpdateChosenCoupon extends CartEvent {
  final String? shippingCouponChosenCode;
  final String? orderCouponChosenCode;
  final String? productCouponChosenCode;

  const CartUpdateChosenCoupon({
    this.shippingCouponChosenCode,
    this.orderCouponChosenCode,
    this.productCouponChosenCode,
  });

  @override
  List<Object?> get props =>
      [
        shippingCouponChosenCode,
        orderCouponChosenCode,
        productCouponChosenCode,
      ];
}

class CartCheckCoupon extends CartEvent {
  @override
  List<Object> get props => [];
}

class CartCheckShippingOrder extends CartEvent {
  @override
  List<Object> get props => [];
}

class CartCheckTakeAwayOrder extends CartEvent {
  @override
  List<Object> get props => [];
}


class CartCreateShippingOrder extends CartEvent {
  @override
  List<Object> get props => [];
}

class CartCreateTakeAwayOrder extends CartEvent {
  @override
  List<Object> get props => [];
}

class CartChooseBranchConflict extends CartEvent {
  final CartInvalidBranch branch;

  const CartChooseBranchConflict({
    required this.branch,
  });

  @override
  List<Object> get props => [branch];
}