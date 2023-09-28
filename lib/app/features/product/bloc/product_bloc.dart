import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopfee/data/models/order.dart';
import 'package:shopfee/data/models/product.dart';
import 'package:shopfee/data/models/topping.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<LoadProduct>(_onLoadProduct);
    on<IncreaseQuantity>(_onIncreaseQuantity);
    on<DecreaseQuantity>(_onDecreaseQuantity);
    on<ChooseVariant>(_onChooseVariant);
    on<ChooseSize>(_onChooseSize);
    on<ChooseSugar>(_onChooseSugar);
    on<ChooseTopping>(_onChooseTopping);
    on<TakeNote>(_onTakeNote);
  }

  FutureOr<void> _onLoadProduct(LoadProduct event, Emitter<ProductState> emit) {
    emit(ProductLoaded(order: Order(product: event.product, variant: Variant.Ice, size: Size.Medium, sugar: Sugar.Normal)));
  }

  FutureOr<void> _onIncreaseQuantity(
      IncreaseQuantity event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      final successState = state as ProductLoaded;
      emit(ProductLoaded(
          order: successState.order
              .copyWith(quantity: successState.order.quantity + 1)));
    }
  }

  FutureOr<void> _onDecreaseQuantity(
      DecreaseQuantity event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      final successState = state as ProductLoaded;
      emit(ProductLoaded(
          order: successState.order
              .copyWith(quantity: successState.order.quantity - 1)));
    }
  }

  FutureOr<void> _onChooseVariant(
      ChooseVariant event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      final successState = state as ProductLoaded;
      emit(ProductLoaded(
          order: successState.order.copyWith(variant: event.variant)));
    }
  }

  FutureOr<void> _onChooseSize(ChooseSize event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      final successState = state as ProductLoaded;
      emit(ProductLoaded(order: successState.order.copyWith(size: event.size)));
    }
  }

  FutureOr<void> _onChooseSugar(ChooseSugar event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      final successState = state as ProductLoaded;
      emit(ProductLoaded(
          order: successState.order.copyWith(sugar: event.sugar)));
    }
  }

  FutureOr<void> _onChooseTopping(
      ChooseTopping event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      final successState = state as ProductLoaded;
      if (successState.order.toppings.contains(event.topping)) {
        emit(ProductLoaded(
            order: successState.order.copyWith(
                toppings: List.from(successState.order.toppings)
                  ..remove(event.topping))));
      } else {
        emit(ProductLoaded(
            order: successState.order.copyWith(
                toppings: List.from(successState.order.toppings)
                  ..add(event.topping))));
      }
    }
  }

  FutureOr<void> _onTakeNote(TakeNote event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      final successState = state as ProductLoaded;
      emit(ProductLoaded(
          order: successState.order.copyWith(note: event.note)));
    }
  }
}
