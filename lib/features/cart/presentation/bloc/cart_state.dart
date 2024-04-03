part of cart;

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  CartInitial();

  @override
  List<Object> get props => [];

  factory CartInitial.fromJson(Map<String, dynamic> json) {
    return CartInitial();
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}

class CartLoaded extends CartState {
  final CartEntity cart;

  const CartLoaded({
    required this.cart,
  });

  @override
  List<Object> get props => [cart];

  factory CartLoaded.fromJson(Map<String, dynamic> json) {
    return CartLoaded(
      cart: CartEntity.fromModel(CartModel.fromJson(json["cart"])),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "cart": CartModel.fromEntity(cart).toJson(),
    };
  }
}

class CartFinished extends CartState {
  final OrderResult orderResult;

  const CartFinished({
    required this.orderResult,
  });

  @override
  List<Object> get props => [orderResult];

  factory CartFinished.fromJson(Map<String, dynamic> json) {
    return CartFinished(
      orderResult: OrderResult.fromJson(json["orderResult"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "orderResult": this.orderResult.toJson(),
    };
  }
}
