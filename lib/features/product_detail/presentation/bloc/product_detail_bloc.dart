part of product_detail;

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductDetailUseCase _productDetailUseCase;

  ProductDetailBloc(this._productDetailUseCase)
      : super(ProductDetailInitial()) {
    on<ProductDetailLoadInformation>(_onProductDetailLoadInformation);
    on<ProductDetailLoadUpdating>(_onProductDetailLoadUpdating);
    on<ProductDetailDecreaseQuantityAndDelete>(
        _onProductDetailDecreaseQuantityAndDelete);
    on<ProductDetailIncreaseQuantity>(_onProductDetailIncreaseQuantity);
    on<ProductDetailDecreaseQuantity>(_onProductDetailDecreaseQuantity);
    on<ProductDetailChooseSize>(_onProductDetailChooseSize);
    on<ProductDetailChooseTopping>(_onProductDetailChooseTopping);
    on<ProductDetailTakeNote>(_onProductDetailTakeNote);
  }

  FutureOr<void> _onProductDetailLoadInformation(
      ProductDetailLoadInformation event,
      Emitter<ProductDetailState> emit) async {
    try {
      emit(ProductDetailLoadInProcess());
      final product =
          await _productDetailUseCase.getProductById(event.productId);
      emit(ProductDetailLoadSuccess(
          order: OrderEntity(
        product: product,
        size: product.sizeList![0],
      )));
    } catch (e) {
      emit(ProductDetailLoadFailure());
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onProductDetailLoadUpdating(
      ProductDetailLoadUpdating event, Emitter<ProductDetailState> emit) {
    try {
      emit(ProductDetailLoadSuccess(
          order: OrderEntity(
        product: event.order.product,
        quantity: event.order.quantity,
        size: event.order.size,
        toppings: event.order.toppings,
        note: event.order.note,
      )));
    } catch (e) {
      emit(ProductDetailLoadFailure());
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onProductDetailDecreaseQuantityAndDelete(
      ProductDetailDecreaseQuantityAndDelete event,
      Emitter<ProductDetailState> emit) {
    if (state is ProductDetailLoadSuccess) {
      final successState = state as ProductDetailLoadSuccess;
      emit(ProductDetailLoadSuccess(
          order: successState.order.copyWith(
              quantity: successState.order.quantity == 0
                  ? successState.order.quantity
                  : successState.order.quantity - 1)));
    }
  }

  FutureOr<void> _onProductDetailIncreaseQuantity(
      ProductDetailIncreaseQuantity event, Emitter<ProductDetailState> emit) {
    if (state is ProductDetailLoadSuccess) {
      final successState = state as ProductDetailLoadSuccess;
      emit(ProductDetailLoadSuccess(
          order: successState.order
              .copyWith(quantity: successState.order.quantity + 1)));
    }
  }

  FutureOr<void> _onProductDetailDecreaseQuantity(
      ProductDetailDecreaseQuantity event, Emitter<ProductDetailState> emit) {
    if (state is ProductDetailLoadSuccess) {
      final successState = state as ProductDetailLoadSuccess;
      emit(ProductDetailLoadSuccess(
          order: successState.order.copyWith(
              quantity: successState.order.quantity == 1
                  ? successState.order.quantity
                  : successState.order.quantity - 1)));
    }
  }

  FutureOr<void> _onProductDetailChooseSize(
      ProductDetailChooseSize event, Emitter<ProductDetailState> emit) {
    if (state is ProductDetailLoadSuccess) {
      final successState = state as ProductDetailLoadSuccess;
      emit(ProductDetailLoadSuccess(
          order: successState.order.copyWith(size: event.size)));
    }
  }

  FutureOr<void> _onProductDetailChooseTopping(
      ProductDetailChooseTopping event, Emitter<ProductDetailState> emit) {
    if (state is ProductDetailLoadSuccess) {
      final successState = state as ProductDetailLoadSuccess;
      if (successState.order.toppings.contains(event.topping)) {
        emit(ProductDetailLoadSuccess(
            order: successState.order.copyWith(
                toppings: List.from(successState.order.toppings)
                  ..remove(event.topping))));
      } else {
        emit(ProductDetailLoadSuccess(
            order: successState.order.copyWith(
                toppings: List.from(successState.order.toppings)
                  ..add(event.topping))));
      }
    }
  }

  FutureOr<void> _onProductDetailTakeNote(
      ProductDetailTakeNote event, Emitter<ProductDetailState> emit) {
    if (state is ProductDetailLoadSuccess) {
      final successState = state as ProductDetailLoadSuccess;
      emit(ProductDetailLoadSuccess(
          order: successState.order.copyWith(note: event.note)));
    }
  }
}
