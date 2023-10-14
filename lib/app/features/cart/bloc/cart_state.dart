part of 'cart_bloc.dart';

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

class CartLoading extends CartState {
  CartLoading();

  @override
  List<Object> get props => [];

  factory CartLoading.fromJson(Map<String, dynamic> json) {
    return CartLoading();
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}

class CartLoaded extends CartState {
  final Cart cart;

  const CartLoaded({
    required this.cart,
  });

  @override
  List<Object> get props => [cart];

  factory CartLoaded.fromJson(Map<String, dynamic> json) {
    return CartLoaded(
      cart: Cart.fromJson(json["cart"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "cart": this.cart.toJson(),
    };
  }
}

class CartFinished extends CartState {
  final String orderId;
  const CartFinished({
    required this.orderId,
  });
  @override
  List<Object> get props => [orderId];

  factory CartFinished.fromJson(Map<String, dynamic> json) {
    return CartFinished(
      orderId: json["orderId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "orderId": this.orderId,
    };
  }
}