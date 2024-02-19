part of cart;

class CartBloc extends HydratedBloc<CartEvent, CartState> {
  final CartUseCase _cartUseCase;

  CartBloc(this._cartUseCase) : super(CartInitial()) {
    on<CartLoadInformation>(_onLoadCart);
    on<CartDeleteInformation>(_onDeleteCart);
    on<CartAddItem>(_onAddItemIntoCart);
    on<CartUpdateItem>(_onUpdateItemInCart);
    on<CartInitAddress>(_onInitAddress);
    on<CartChooseAddress>(_onChooseAddress);
    on<CartChooseTypePayment>(_onChooseTypePayment);
    on<CartAddNote>(_onAddNote);
    on<CartCreateShippingOrder>(_onCreateShippingOrder);
  }

  FutureOr<void> _onLoadCart(
      CartLoadInformation event, Emitter<CartState> emit) {
    if (state is! CartLoaded) {
      emit(const CartLoaded(cart: CartEntity()));
    }
  }

  FutureOr<void> _onDeleteCart(
      CartDeleteInformation event, Emitter<CartState> emit) {
    emit(CartLoaded(cart: CartEntity()));
  }

  FutureOr<void> _onAddItemIntoCart(
      CartAddItem event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final successState = state as CartLoaded;
      List<OrderEntity> orders = List.from(successState.cart.orders);
      final existingOrderIndex = orders
          .indexWhere((order) => order.isEqualExceptQuantity(event.order));

      if (existingOrderIndex != -1) {
        // Nếu "event.order" đã tồn tại trong danh sách "orders"
        orders[existingOrderIndex] = orders[existingOrderIndex].copyWith(
            quantity:
                orders[existingOrderIndex].quantity + event.order.quantity);
      } else {
        // Nếu "event.order" chưa tồn tại trong danh sách "orders"
        orders.add(event.order);
      }

      emit(CartLoaded(
        cart: successState.cart.copyWith(
          orders: orders,
        ),
      ));
    }
  }

  FutureOr<void> _onUpdateItemInCart(
      CartUpdateItem event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final successState = state as CartLoaded;
      List<OrderEntity> orders = List.from(successState.cart.orders);
      if (event.updatedOrder.quantity == 0) {
        orders.removeAt(event.index);
      } else {
        final existingOrderIndex = orders.indexWhere(
            (order) => order.isEqualExceptQuantity(event.updatedOrder));
        if (existingOrderIndex != -1 && existingOrderIndex != event.index) {
          orders[existingOrderIndex] = orders[existingOrderIndex].copyWith(
              quantity: orders[existingOrderIndex].quantity +
                  event.updatedOrder.quantity);
          orders.removeAt(event.index);
        } else {
          orders[event.index] = event.updatedOrder;
        }
      }
      emit(CartLoaded(
        cart: successState.cart.copyWith(
          orders: orders,
        ),
      ));
    }
  }

  FutureOr<void> _onInitAddress(
      CartInitAddress event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      try {
        EasyLoading.show();
        final defaultAddress =
            await _cartUseCase.getDefaultAddress(SharedService.getUserId()!);
        EasyLoading.dismiss();
        emit(CartLoaded(
          cart: currentState.cart.copyWith(
            address: defaultAddress,
          ),
        ));
      } catch (e) {
        ExceptionUtil.handle(e);
      }
    }
  }

  FutureOr<void> _onChooseAddress(
      CartChooseAddress event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      try {
        final successState = state as CartLoaded;
        EasyLoading.show();
        var chosenAddress =
            await _cartUseCase.getChosenAddress(event.addressId);
        EasyLoading.dismiss();
        emit(CartLoaded(
            cart: successState.cart.copyWith(address: chosenAddress)));
      } catch (e) {
        ExceptionUtil.handle(e);
      }
    }
  }

  FutureOr<void> _onChooseTypePayment(
      CartChooseTypePayment event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final successState = state as CartLoaded;
      emit(CartLoaded(
          cart: successState.cart.copyWith(typePayment: event.typePayment)));
    }
  }

  FutureOr<void> _onAddNote(CartAddNote event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final successState = state as CartLoaded;
      emit(CartLoaded(cart: successState.cart.copyWith(note: event.note)));
    }
  }

  FutureOr<void> _onCreateShippingOrder(
      CartCreateShippingOrder event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      final successState = state as CartLoaded;
      late String orderId;
      try {
        EasyLoading.show();
        final orderResult = await _cartUseCase.createShippingOrder(
            successState.cart, SharedService.getUserId()!);
        EasyLoading.dismiss();

        emit(CartFinished(orderResult: orderResult));

        add(CartLoadInformation());
      } catch (e) {
        EasyLoading.showError(e.toString());
      }
    }
  }

  @override
  CartState? fromJson(Map<String, dynamic> json) {
    return CartLoaded.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(CartState state) {
    if (state is CartInitial) {
      return state.toJson();
    } else if (state is CartLoaded) {
      return state.toJson();
    } else if (state is CartFinished) {
      return state.toJson();
    }
    return null;
  }
}
