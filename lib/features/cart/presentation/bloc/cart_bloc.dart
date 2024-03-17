part of cart;

class CartBloc extends HydratedBloc<CartEvent, CartState> {
  final CartUseCase _cartUseCase;

  CartBloc(this._cartUseCase) : super(CartInitial()) {
    on<CartLoadInformation>(_onCartLoadInformation);
    on<CartDeleteInformation>(_onCartDeleteInformation);
    on<CartAddItem>(_onCartAddItem);
    on<CartDeleteItem>(_onCartDeleteItem);
    on<CartUpdateItem>(_onCartUpdateItem);
    on<CartInitAddress>(_onCartInitAddress);
    on<CartChooseShippingAddress>(_onCartChooseShippingAddress);
    on<CartInitStore>(_onCartInitStore);
    on<CartChooseStore>(_onCartChooseStore);
    on<CartChooseOrderType>(_onCartChooseOrderType);
    on<CartChooseTypePayment>(_onCartChooseTypePayment);
    on<CartChooseTime>(_onCartChooseTime);
    on<CartAddNote>(_onCartAddNote);
    on<CartApplyCoin>(_onCartApplyCoin);
    on<CartRemoveCoin>(_onCartRemoveCoin);
    on<CartSetShippingFee>(_onCartSetShippingFee);
    on<CartCreateShippingOrder>(_onCartCreateShippingOrder);
    on<CartCreateTakeAwayOrder>(_onCartCreateTakeAwayOrder);
  }

  FutureOr<void> _onCartLoadInformation(
      CartLoadInformation event, Emitter<CartState> emit) {
    if (state is! CartLoaded) {
      emit(const CartLoaded(cart: CartEntity()));
    }
  }

  FutureOr<void> _onCartDeleteInformation(
      CartDeleteInformation event, Emitter<CartState> emit) {
    emit(CartLoaded(cart: CartEntity()));
  }

  FutureOr<void> _onCartAddItem(CartAddItem event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      List<OrderEntity> orders = List.from(currentState.cart.orders);
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
        cart: currentState.cart.copyWith(
          orders: orders,
        ),
      ));
    }
  }

  FutureOr<void> _onCartDeleteItem(
      CartDeleteItem event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      List<OrderEntity> orders = List.from(currentState.cart.orders);
      orders.removeAt(event.index);
      emit(CartLoaded(
        cart: currentState.cart.copyWith(
          orders: orders,
        ),
      ));
    }
  }

  FutureOr<void> _onCartUpdateItem(
      CartUpdateItem event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      List<OrderEntity> orders = List.from(currentState.cart.orders);
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
        cart: currentState.cart.copyWith(
          orders: orders,
        ),
      ));
    }
  }

  FutureOr<void> _onCartInitAddress(
      CartInitAddress event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      if(currentState.cart.address != null) return;
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
        if (defaultAddress != null) {
          add(CartSetShippingFee(
              lat: defaultAddress.latitude!, lng: defaultAddress.longitude!));
        }
      } catch (e) {
        ExceptionUtil.handle(e);
      }
    }
  }

  FutureOr<void> _onCartChooseShippingAddress(
      CartChooseShippingAddress event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      try {
        final currentState = state as CartLoaded;
        EasyLoading.show();
        final chosenAddress =
            await _cartUseCase.getChosenShippingAddress(event.addressId);
        EasyLoading.dismiss();
        emit(CartLoaded(
            cart: currentState.cart.copyWith(address: chosenAddress)));
        if (chosenAddress != null) {
          add(CartSetShippingFee(
              lat: chosenAddress.latitude!, lng: chosenAddress.longitude!));
        }
      } catch (e) {
        ExceptionUtil.handle(e);
      }
    }
  }

  FutureOr<void> _onCartChooseTypePayment(
      CartChooseTypePayment event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      emit(CartLoaded(
          cart: currentState.cart.copyWith(paymentType: event.typePayment)));
    }
  }

  FutureOr<void> _onCartChooseTime(
      CartChooseTime event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      if(currentState.cart.checkChooseValidReceiptTime(event.receiveTime)) {
        emit(CartLoaded(
          cart: currentState.cart.copyWith(receiveTime: event.receiveTime)));
      }
      else{
        EasyLoading.showInfo("Chosen Receive Time Is Not Valid");
      }
    }
  }

  FutureOr<void> _onCartChooseOrderType(
      CartChooseOrderType event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      if (event.typeOrder == OrderType.SHIPPING) {
        if (await PermissionUtil.requestLocationPermission() == false) {
          AlertUtil.showToast("You must enable location to use Take Away");
          return;
        }
      }
      emit(CartLoaded(
          cart: currentState.cart.copyWith(orderType: event.typeOrder)));
      if (currentState.cart.store == null) {
        add(CartInitStore());
      }
    }
  }

  FutureOr<void> _onCartInitStore(
      CartInitStore event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      try {
        EasyLoading.show();
        final currentPosition = await GlobalData.ins.getCurrentPosition();
        final nearestStore = await _cartUseCase.getNearestStore(
            currentPosition.latitude, currentPosition.longitude);
        EasyLoading.dismiss();
        emit(CartLoaded(
          cart: currentState.cart
              .copyWith(store: nearestStore),
        ));
      } catch (e) {
        ExceptionUtil.handle(e);
      }
    }
  }

  FutureOr<void> _onCartChooseStore(
      CartChooseStore event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      try {
        EasyLoading.show();
        final chosenStore = await _cartUseCase.getDetailStore(event.branchId);
        EasyLoading.dismiss();
        emit(CartLoaded(
          cart: currentState.cart
              .copyWith(store: chosenStore),
        ));
      } catch (e) {
        ExceptionUtil.handle(e);
      }
    }
  }

  FutureOr<void> _onCartAddNote(CartAddNote event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      emit(CartLoaded(cart: currentState.cart.copyWith(note: event.note)));
    }
  }

  FutureOr<void> _onCartApplyCoin(
      CartApplyCoin event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      emit(
          CartLoaded(cart: currentState.cart.copyWith(coin: () => event.coin)));
    }
  }

  FutureOr<void> _onCartRemoveCoin(
      CartRemoveCoin event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      emit(CartLoaded(cart: currentState.cart.copyWith(coin: () => null)));
    }
  }

  FutureOr<void> _onCartSetShippingFee(
      CartSetShippingFee event, Emitter<CartState> emit) async {
    try {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        EasyLoading.show();
        final shippingFee =
            await _cartUseCase.getShippingFee(event.lat, event.lng);
        EasyLoading.dismiss();
        emit(CartLoaded(
            cart: currentState.cart.copyWith(shippingFee: () => shippingFee)));
      }
    } catch (e) {
      if(e is ServerFailure){
        final currentState = state as CartLoaded;
        emit(CartLoaded(
            cart: currentState.cart.copyWith(shippingFee: () => null)));
      }
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onCartCreateShippingOrder(
      CartCreateShippingOrder event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      try {
        EasyLoading.show();
        final orderResult = await _cartUseCase.createShippingOrder(
            currentState.cart, SharedService.getUserId()!);
        EasyLoading.dismiss();
        emit(CartFinished(orderResult: orderResult));

        add(CartLoadInformation());
      } catch (e) {
        ExceptionUtil.handle(e);
      }
    }
  }

  FutureOr<void> _onCartCreateTakeAwayOrder(
      CartCreateTakeAwayOrder event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      try {
        EasyLoading.show();
        OrderResult orderResult;
        if (currentState.cart.receiveTime != null) {
          orderResult = await _cartUseCase.createTakeAwayOrder(
              currentState.cart, SharedService.getUserId()!);
        } else {
          orderResult = await _cartUseCase.createTakeAwayOrder(
              currentState.cart.copyWith(receiveTime: DateTime.now()),
              SharedService.getUserId()!);
        }
        EasyLoading.dismiss();
        emit(CartFinished(orderResult: orderResult));
        add(CartLoadInformation());
      } catch (e) {
        ExceptionUtil.handle(e);
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
