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
    on<ProductByCategoryRefreshInformation>(
        _onProductByCategoryRefreshInformation);
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
      await Future.delayed(Duration(seconds: 1));
      emit(ProductByCategoryLoadSuccess(
          products: products,
          categoryId: event.categoryId,
          page: event.page,
          size: event.size));
    } catch (e) {
      emit(ProductByCategoryLoadFailure());
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onProductByCategoryLoadMoreInformation(
      ProductByCategoryLoadMoreInformation event,
      Emitter<ProductByCategoryState> emit) async {
    try {
      if (state is ProductByCategoryLoadSuccess) {
        final currentState = state as ProductByCategoryLoadSuccess;
        emit(currentState.copyWith(isLoadMore: true));
        final products = await _productByCategoryUseCase
            .getProductsByCategoryId(currentState.categoryId,
                page: currentState.page + 1, size: currentState.size);
        await Future.delayed(Duration(milliseconds: 1000));
        if (products.isNotEmpty) {
          emit(currentState.copyWith(
              products: List.from(currentState.products)..addAll(products),
              page: currentState.page + 1,
              isLoadMore: false));
        } else {
          emit(currentState.copyWith(cannotLoadMore: true));
        }
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onProductByCategoryChangeViewType(
      ProductByCategoryChangeViewType event,
      Emitter<ProductByCategoryState> emit) {
    try {
      if (state is ProductByCategoryLoadSuccess) {
        final successState = state as ProductByCategoryLoadSuccess;
        emit(successState.copyWith(viewType: event.viewType));
      }
    } catch (e) {
      print(e);
      emit(ProductByCategoryLoadFailure());
    }
  }

  FutureOr<void> _onProductByCategoryRefreshInformation(
      ProductByCategoryRefreshInformation event,
      Emitter<ProductByCategoryState> emit) async {
    try {
      if (state is ProductByCategoryLoadSuccess) {
        final currentState = state as ProductByCategoryLoadSuccess;
        var products = await _productByCategoryUseCase.getProductsByCategoryId(
            currentState.categoryId,
            page: event.page,
            size: event.size);
        emit(ProductByCategoryLoadSuccess(
            products: products,
            categoryId: currentState.categoryId,
            page: event.page,
            size: event.size,
            viewType: currentState.viewType));
      }
    } catch (e) {
      print(e);
      emit(ProductByCategoryLoadFailure());
    }
  }
}
