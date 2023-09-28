import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopfee/data/models/cart.dart';
import 'package:shopfee/data/models/order.dart';
import 'package:shopfee/data/models/voucher.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddItemIntoCart>(_onAddItemIntoCart);
  }

  FutureOr<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) {
    emit(CartLoaded(cart: Cart()));
  }

  FutureOr<void> _onAddItemIntoCart(
      AddItemIntoCart event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final successState = state as CartLoaded;
      emit(CartLoaded(
          cart: successState.cart.copyWith(
              orders: List.from(successState.cart.orders)..add(event.order))));
    }
  }

}
