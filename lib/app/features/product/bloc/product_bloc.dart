import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopfee/data/models/order.dart';
import 'package:shopfee/data/models/product.dart';
import 'package:shopfee/data/models/size.dart';
import 'package:shopfee/data/models/topping.dart';
import 'package:shopfee/data/repositories/product/product_repository.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  ProductBloc({required this.productRepository}) : super(ProductInitial()) {
    on<LoadProduct>(_onLoadProduct);
    on<LoadUpdatingProduct>(_onLoadUpdatingProduct);
    on<DecreaseQuantityAndDelete>(_onDecreaseQuantityAndDelete);
    on<IncreaseQuantity>(_onIncreaseQuantity);
    on<DecreaseQuantity>(_onDecreaseQuantity);
    on<ChooseSize>(_onChooseSize);
    on<ChooseTopping>(_onChooseTopping);
    on<TakeNote>(_onTakeNote);
  }

  FutureOr<void> _onLoadProduct(LoadProduct event, Emitter<ProductState> emit) async{
    emit(ProductLoading());
    try{
      var response = await productRepository.getProductById(event.productId);
      if(response.success){
        Product product = Product.fromJson(response.data!);
        emit(ProductLoaded(
            order: Order(
              product: product,
              size: product.sizeList![0],
            )));
      }
    }
    catch(e){
      emit(ProductError());
    }
  }

  FutureOr<void> _onLoadUpdatingProduct(LoadUpdatingProduct event, Emitter<ProductState> emit) {
    try{
        emit(ProductLoaded(
            order: Order(
              product: event.order.product,
              quantity: event.order.quantity,
              size: event.order.size,
              toppings: event.order.toppings,
              note: event.order.note,
            )));
    }
    catch(e){
      emit(ProductError());
    }
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
          order: successState.order.copyWith(
              quantity: successState.order.quantity == 1
                  ? successState.order.quantity
                  : successState.order.quantity - 1)));
    }
  }

  FutureOr<void> _onDecreaseQuantityAndDelete(DecreaseQuantityAndDelete event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      final successState = state as ProductLoaded;
      emit(ProductLoaded(
          order: successState.order.copyWith(
              quantity: successState.order.quantity == 0
                  ? successState.order.quantity
                  : successState.order.quantity - 1)));
    }
  }

  FutureOr<void> _onChooseSize(ChooseSize event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      final successState = state as ProductLoaded;
      emit(ProductLoaded(order: successState.order.copyWith(size: event.size)));
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
      emit(ProductLoaded(order: successState.order.copyWith(note: event.note)));
    }
  }
}
