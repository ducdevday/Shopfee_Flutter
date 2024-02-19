part of product_by_category;

class ProductByCategoryBloc
    extends Bloc<ProductByCategoryEvent, ProductByCategoryState> {
  final ProductByCategoryUseCase _productByCategoryUseCase;

  ProductByCategoryBloc(this._productByCategoryUseCase)
      : super(ProductByCategoryInitial()) {
    on<ProductByCategoryLoadInformation>(_onProductByCategoryLoadInformation);
    on<ProductByCategoryChangeViewType>(_onProductByCategoryChangeViewType);
  }

  FutureOr<void> _onProductByCategoryLoadInformation(
      ProductByCategoryLoadInformation event,
      Emitter<ProductByCategoryState> emit) async {
    emit(ProductByCategoryLoadInProcess());
    try {
      var response = await _productByCategoryUseCase
          .getProductsByCategoryId(event.categoryId);
      await Future.delayed(Duration(seconds: 3));
      emit(ProductByCategoryLoadSuccess(products: response));
    } catch (e) {
      print(e);
      emit(ProductByCategoryLoadFailure());
      ExceptionUtil.handle(e);
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
