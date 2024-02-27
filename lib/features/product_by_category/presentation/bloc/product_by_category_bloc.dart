part of product_by_category;

class ProductByCategoryBloc
    extends Bloc<ProductByCategoryEvent, ProductByCategoryState> {
  final ProductByCategoryUseCase _productByCategoryUseCase;

  ProductByCategoryBloc(this._productByCategoryUseCase)
      : super(ProductByCategoryInitial()) {
    on<ProductByCategoryLoadInformation>(_onProductByCategoryLoadInformation);
    on<ProductByCategoryChangeViewType>(_onProductByCategoryChangeViewType);
    on<ProductByCategoryLoadMoreInformation>(
        _onProductByCategoryLoadMoreInformation);
  }

  FutureOr<void> _onProductByCategoryLoadInformation(
      ProductByCategoryLoadInformation event,
      Emitter<ProductByCategoryState> emit) async {
    try {
      emit(ProductByCategoryLoadInProcess());
      var products = await _productByCategoryUseCase.getProductsByCategoryId(
          event.categoryId,
          page: event.page,
          size: event.size);
      await Future.delayed(Duration(seconds: 3));
      emit(ProductByCategoryLoadSuccess(products: products));
    } catch (e) {
      print(e);
      emit(ProductByCategoryLoadFailure());
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onProductByCategoryLoadMoreInformation(
      ProductByCategoryLoadMoreInformation event,
      Emitter<ProductByCategoryState> emit) async {
    if (state is ProductByCategoryLoadSuccess) {
      final currentState = state as ProductByCategoryLoadSuccess;
      emit(currentState.copyWith(isLoadMore: true));
      final products = await _productByCategoryUseCase.getProductsByCategoryId(
          event.categoryId,
          page: event.page,
          size: event.size);
      await Future.delayed(Duration(milliseconds: 1000));
      if (products.isNotEmpty) {
        emit(currentState.copyWith(
            products: List.from(currentState.products)..addAll(products),
            isLoadMore: false));
      } else {
        emit(currentState.copyWith(cannotLoadMore: true));
      }
    }
  }

  FutureOr<void> _onProductByCategoryChangeViewType(
      ProductByCategoryChangeViewType event,
      Emitter<ProductByCategoryState> emit) {
    if (state is ProductByCategoryLoadSuccess) {
      try {
        final successState = state as ProductByCategoryLoadSuccess;
        emit(successState.copyWith(viewType: event.viewType));
      } catch (e) {
        print(e);
        emit(ProductByCategoryLoadFailure());
      }
    }
  }
}
