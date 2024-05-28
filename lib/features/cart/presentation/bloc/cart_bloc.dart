part of cart;

class CartBloc extends HydratedBloc<CartEvent, CartState> {
  final CartUseCase _cartUseCase;

  CartBloc(this._cartUseCase) : super(CartInitial()) {
    on<CartLoadInformation>(_onCartLoadInformation);
    on<CartDeleteInformation>(_onCartDeleteInformation);
    on<CartAddItem>(_onCartAddItem);
    on<CartDeleteItem>(_onCartDeleteItem);
    on<CartUpdateItem>(_onCartUpdateItem);
    on<CartInitAddressAndReceiver>(_onCartInitAddress);
    on<CartLoadReceiverInformation>(_onCartLoadReceiverInformation);
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
    on<CartUpdateChosenCoupon>(_onCartUpdateChosenCoupon);
    on<CartCheckCoupon>(_onCartCheckCoupon);
    on<CartUpdateOrderInformation>(_onCartUpdateOrderInformation);
    on<CartCheckShippingOrder>(_onCartCheckShippingOrder);
    on<CartCheckTakeAwayOrder>(_onCartCartCheckTakeAwayOrder);
    on<CartChooseBranchConflict>(_onCartChooseBranchConflict);
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
      add(CartCheckCoupon());
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
      add(CartCheckCoupon());
      if (currentState.cart.cartInvalidBranchList.isNotEmpty &&
          currentState.cart.orderType == OrderType.SHIPPING) {
        add(CartCheckShippingOrder());
      } else if (currentState.cart.cartInvalidBranchList.isNotEmpty &&
          currentState.cart.orderType == OrderType.ONSITE) {
        add(CartCheckTakeAwayOrder());
      }
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
      add(CartCheckCoupon());
    }
  }

  FutureOr<void> _onCartInitAddress(
      CartInitAddressAndReceiver event, Emitter<CartState> emit) async {
    try {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        if (currentState.cart.address != null ||
            SharedService.getUserId() == null) return;
        EasyLoading.show();
        final defaultAddress =
            await _cartUseCase.getDefaultAddress(SharedService.getUserId()!);
        EasyLoading.dismiss();
        emit(CartLoaded(
          cart: currentState.cart.copyWith(
              address: defaultAddress,
              receiverOnsite: event.receiverInformation),
        ));
        if (defaultAddress != null) {
          // add(CartSetShippingFee(
          //     lat: defaultAddress.latitude!, lng: defaultAddress.longitude!));
          add(CartCheckShippingOrder());
        }
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onCartLoadReceiverInformation(
      CartLoadReceiverInformation event, Emitter<CartState> emit) {
    try {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        emit(CartLoaded(
            cart: currentState.cart
                .copyWith(receiverOnsite: event.receiverInformation)));
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onCartChooseShippingAddress(
      CartChooseShippingAddress event, Emitter<CartState> emit) async {
    try {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        EasyLoading.show();
        final chosenAddress =
            await _cartUseCase.getChosenShippingAddress(event.addressId);
        EasyLoading.dismiss();
        emit(CartLoaded(
            cart: currentState.cart.copyWith(address: chosenAddress)));
        if (chosenAddress != null) {
          // add(CartSetShippingFee(
          //     lat: chosenAddress.latitude!, lng: chosenAddress.longitude!));
          add(CartCheckShippingOrder());
        }
      }
    } catch (e) {
      ExceptionUtil.handle(e);
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
      if (currentState.cart.checkChooseValidReceiptTime(event.receiveTime)) {
        emit(CartLoaded(
            cart: currentState.cart.copyWith(receiveTime: event.receiveTime)));
      } else {
        EasyLoading.showInfo("Chosen Receive Time Is Not Valid");
      }
    }
  }

  FutureOr<void> _onCartChooseOrderType(
      CartChooseOrderType event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      if (event.typeOrder == OrderType.ONSITE) {
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
      if (event.typeOrder == OrderType.ONSITE) {
        add(CartCheckTakeAwayOrder());
      } else if (event.typeOrder == OrderType.SHIPPING) {
        add(CartCheckShippingOrder());
      }
    }
  }

  FutureOr<void> _onCartInitStore(
      CartInitStore event, Emitter<CartState> emit) async {
    try {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        EasyLoading.show();
        final currentPosition = await GlobalData.ins.getCurrentPosition();
        final nearestStore = await _cartUseCase.getNearestStore(
            currentPosition.latitude, currentPosition.longitude);
        EasyLoading.dismiss();
        emit(CartLoaded(
          cart: currentState.cart.copyWith(store: nearestStore),
        ));
        add(CartCheckTakeAwayOrder());
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onCartChooseStore(
      CartChooseStore event, Emitter<CartState> emit) async {
    try {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        EasyLoading.show();
        final chosenStore = await _cartUseCase.getDetailStore(event.branchId);
        EasyLoading.dismiss();
        emit(CartLoaded(
          cart: currentState.cart.copyWith(store: chosenStore),
        ));
        add(CartCheckTakeAwayOrder());
      }
    } catch (e) {
      ExceptionUtil.handle(e);
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
      if (e is ServerFailure) {
        final currentState = state as CartLoaded;
        emit(CartLoaded(
            cart: currentState.cart.copyWith(shippingFee: () => null)));
      }
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onCartUpdateChosenCoupon(
      CartUpdateChosenCoupon event, Emitter<CartState> emit) async {
    try {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        emit(CartLoaded(
            cart: currentState.cart.copyWith(
                shippingCouponCode: () => event.shippingCouponChosenCode,
                orderCouponCode: () => event.orderCouponChosenCode,
                productCouponCode: () => event.productCouponChosenCode)));
        add(CartCheckCoupon());
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onCartCheckCoupon(
      CartCheckCoupon event, Emitter<CartState> emit) async {
    try {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        if (currentState.cart.needToCheckCoupon(SharedService.getUserId()) ==
            false) {
          return;
        }
        final couponResultList =
            await _cartUseCase.checkCouponInCart(currentState.cart);
        String? currentShippingCoupon = currentState.cart.shippingCouponCode;
        String? currentOrderCoupon = currentState.cart.orderCouponCode;
        String? currentProductCoupon = currentState.cart.productCouponCode;
        CouponCheckResultEntity? shippingCouponResult;
        CouponCheckResultEntity? orderCouponResult;
        CouponCheckResultEntity? productCouponResult;
        for (var couponResult in couponResultList) {
          switch (couponResult.couponType) {
            case CouponType.SHIPPING:
              if (couponResult.valid == false) {
                currentShippingCoupon = null;
                shippingCouponResult = null;
                if (couponResult.getViolatedString() != null) {
                  EasyLoading.showToast(
                      "Shipping Coupon has been remove because of\n${couponResult.getViolatedString()}");
                }
              } else {
                shippingCouponResult = couponResult;
              }
              break;
            case CouponType.ORDER:
              if (couponResult.valid == false) {
                currentOrderCoupon = null;
                orderCouponResult = null;
                if (couponResult.getViolatedString() != null) {
                  EasyLoading.showToast(
                      "Order Coupon has been remove because of\n${couponResult.getViolatedString()}");
                }
              } else {
                orderCouponResult = couponResult;
              }
              break;
            case CouponType.PRODUCT:
              if (couponResult.valid == false) {
                currentProductCoupon = null;
                productCouponResult = null;
                if (couponResult.getViolatedString() != null) {
                  EasyLoading.showToast(
                      "Product Coupon has been remove because of\n${couponResult.getViolatedString()}");
                }
              } else {
                productCouponResult = couponResult;
              }
              break;

            case null:
              break;
          }
        }
        emit(CartLoaded(
            cart: currentState.cart.copyWith(
                shippingCouponCode: () => currentShippingCoupon,
                orderCouponCode: () => currentOrderCoupon,
                productCouponCode: () => currentProductCoupon,
                shippingCouponResult: () => shippingCouponResult,
                orderCouponResult: () => orderCouponResult,
                productCouponResult: () => productCouponResult)));
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onCartUpdateOrderInformation(
      CartUpdateOrderInformation event, Emitter<CartState> emit) async {
    try {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        EasyLoading.show();
        final updatedInformationOrders =
            await _cartUseCase.updateOrderInformation(currentState.cart.orders);
        emit(CartLoaded(
            cart:
                currentState.cart.copyWith(orders: updatedInformationOrders)));
        EasyLoading.dismiss();
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onCartCheckShippingOrder(
      CartCheckShippingOrder event, Emitter<CartState> emit) async {
    try {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        if (currentState.cart.address == null) return;
        EasyLoading.show();
        final checkResult =
            await _cartUseCase.checkShippingOrder(currentState.cart);
        if (checkResult.branchValid != null) {
          emit(CartLoaded(
              cart: currentState.cart.copyWith(
                  shippingFee: () =>
                      checkResult.branchValid!.shippingFee.toDouble(),
                  cartInvalidBranchList: [])));
        } else if (checkResult.branchInvalidList != null &&
            checkResult.branchInvalidList!.isNotEmpty) {
          List<CartInvalidBranch> cartInValidBranchList = [];
          for (var invalidBranch in checkResult.branchInvalidList!) {
            final branchEntity =
                await _cartUseCase.getDetailStore(invalidBranch.branchId);
            final invalidProductIdList = invalidBranch.orderItemInvalidList
                .map((e) => e.productId)
                .toList();
            final Set<String> invalidProductNameSet = {};
            final currentOrder =
                List<OrderEntity>.from(currentState.cart.orders);
            final invalidCurrentOrder = currentOrder
                .where((element) =>
                    invalidProductIdList.contains(element.product.id))
                .toList();
            invalidProductNameSet.addAll(
                invalidCurrentOrder.map((e) => e.product.name!).toList());
            final List<String> invalidProductNameList =
                invalidProductNameSet.toList();
            cartInValidBranchList.add(CartInvalidBranch(
              branchId: branchEntity.id!,
              branchName: branchEntity.name!,
              invalidProductIdList: invalidProductIdList,
              invalidProductNameList: invalidProductNameList,
            ));
          }
          emit(CartLoaded(
              cart: currentState.cart
                  .copyWith(cartInvalidBranchList: cartInValidBranchList)));
        }
        EasyLoading.dismiss();
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onCartCartCheckTakeAwayOrder(
      CartCheckTakeAwayOrder event, Emitter<CartState> emit) async {
    try {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        if (currentState.cart.store == null) return;
        EasyLoading.show();
        final checkResult =
            await _cartUseCase.checkTakeAwayOrder(currentState.cart);
        if (checkResult.orderItemInvalidList.isNotEmpty) {
          List<CartInvalidBranch> cartInValidBranchList = [];
          final branchEntity =
              await _cartUseCase.getDetailStore(currentState.cart.store!.id!);
          final invalidProductIdList =
              checkResult.orderItemInvalidList.map((e) => e.productId).toList();
          final Set<String> invalidProductNameSet = {};
          final currentOrder = List<OrderEntity>.from(currentState.cart.orders);
          final invalidCurrentOrder = currentOrder
              .where((element) =>
                  invalidProductIdList.contains(element.product.id))
              .toList();
          invalidProductNameSet
              .addAll(invalidCurrentOrder.map((e) => e.product.name!).toList());
          final List<String> invalidProductNameList =
              invalidProductNameSet.toList();
          cartInValidBranchList.add(CartInvalidBranch(
            branchId: branchEntity.id!,
            branchName: branchEntity.name!,
            invalidProductIdList: invalidProductIdList,
            invalidProductNameList: invalidProductNameList,
          ));
          emit(CartLoaded(
              cart: currentState.cart
                  .copyWith(cartInvalidBranchList: cartInValidBranchList)));
        }
        EasyLoading.dismiss();
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onCartChooseBranchConflict(
      CartChooseBranchConflict event, Emitter<CartState> emit) async {
    try {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        final currentOrderItem =
            List<OrderEntity>.from(currentState.cart.orders);
        currentOrderItem.removeWhere((element) =>
            event.branch.invalidProductIdList.contains(element.product.id));
        emit(CartLoaded(
            cart: currentState.cart.copyWith(
                orders: currentOrderItem, cartInvalidBranchList: [])));
        EasyLoading.showInfo("Some product has been remove from cart");
        EasyLoading.dismiss();
        if (currentState.cart.orderType != null &&
            currentState.cart.orderType == OrderType.SHIPPING) {
          add(CartCheckShippingOrder());
        } else if (currentState.cart.orderType != null &&
            currentState.cart.orderType == OrderType.ONSITE) {
          add(CartCheckTakeAwayOrder());
        }
        add(CartCheckCoupon());
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onCartCreateShippingOrder(
      CartCreateShippingOrder event, Emitter<CartState> emit) async {
    try {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        EasyLoading.show();
        final orderResult = await _cartUseCase.createShippingOrder(
            currentState.cart, SharedService.getUserId()!);
        EasyLoading.dismiss();
        emit(CartFinished(orderResult: orderResult));
        add(CartLoadInformation());
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onCartCreateTakeAwayOrder(
      CartCreateTakeAwayOrder event, Emitter<CartState> emit) async {
    try {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
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
      }
    } catch (e) {
      ExceptionUtil.handle(e);
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
