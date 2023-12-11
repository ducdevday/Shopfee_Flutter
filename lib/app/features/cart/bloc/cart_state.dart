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

  // bool get isValid => cart.address != null && (DateTime.now().hour >= 8 && DateTime.now().hour < 20);
  bool get isValid => cart.address != null ;

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
  final String? paymentUrl;
  final String? transactionId;

  const CartFinished({
    required this.orderId,
    this.paymentUrl, this.transactionId,
  });

  @override
  List<Object?> get props => [orderId, paymentUrl, transactionId];

  factory CartFinished.fromJson(Map<String, dynamic> json) {
    return CartFinished(
      orderId: json["orderId"],
      paymentUrl: json["paymentUrl"] as String?,
      transactionId: json["transactionId"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "orderId": this.orderId,
      "paymentUrl": this.paymentUrl,
      "transactionId": this.transactionId,
    };
  }
}