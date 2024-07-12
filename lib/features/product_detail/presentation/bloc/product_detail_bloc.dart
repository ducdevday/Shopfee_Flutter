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

      if (SharedService.getUserId() == null) {
        final product =
            await _productDetailUseCase.getProductById(event.productId);
        await Future.delayed(Duration(seconds: 1));
        emit(ProductDetailLoadSuccess(
            order: OrderEntity(
          product: product,
          size: (product.sizeList != null && product.sizeList!.isNotEmpty)
              ? product.sizeList![0]
              : SizeEntity(size: "", price: product.price!),
        )));
      } else {
        final response = await Future.wait([
          _productDetailUseCase.getProductById(event.productId),
          _productDetailUseCase.getViewedProduct(event.sizeViewedProduct)
        ]);
        await Future.delayed(Duration(seconds: 1));
        final product = response[0] as ProductDetailEntity;
        final viewedProducts = response[1] as List<ProductInformationEntity>;
        emit(
          ProductDetailLoadSuccess(
              order: OrderEntity(
                product: product,
                size: (product.sizeList != null && product.sizeList!.isNotEmpty)
                    ? product.sizeList![0]
                    : SizeEntity(size: "", price: product.price!),
              ),
              viewedProducts: viewedProducts),
        );
      }
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
