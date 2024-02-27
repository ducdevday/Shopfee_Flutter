part of order;

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderUseCase _orderUseCase;

  OrderBloc(this._orderUseCase) : super(OrderInitial()) {
    on<OrderLoadInformation>(_onOrderLoadInformation);
    on<OrderLoadMoreInformation>(_onOrderLoadMoreInformation);
    on<OrderChooseCategory>(_onOrderChooseCategory);
    on<OrderChangeViewType>(_onOrderChangeViewType);
  }

  FutureOr<void> _onOrderLoadInformation(
      OrderLoadInformation event, Emitter<OrderState> emit) async {
    try {
      EasyLoading.show();
      final categories = await _orderUseCase.getAllCategory();
      List<ProductInformationEntity> products = [];
      if (categories.isNotEmpty) {
        products = await _orderUseCase.getProductsByCategoryId(
            categories[0].id!,
            page: event.page,
            size: event.size);
      }
      emit(OrderLoadSuccess(
          categories: categories,
          products: products,
          chosenCategory: categories[0]));
      EasyLoading.dismiss();
    } catch (e) {
      ExceptionUtil.handle(e);
      emit(OrderLoadFailure());
    }
  }

  FutureOr<void> _onOrderLoadMoreInformation(
      OrderLoadMoreInformation event, Emitter<OrderState> emit) async {
    try {
      if (state is OrderLoadSuccess) {
        final currentState = state as OrderLoadSuccess;
        emit(currentState.copyWith(isLoadMore: true));
        final products = await _orderUseCase.getProductsByCategoryId(
            currentState.chosenCategory!.id!,
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
    } catch (e) {
      ExceptionUtil.handle(e);
      emit(OrderLoadFailure());
    }
  }

  FutureOr<void> _onOrderChooseCategory(
      OrderChooseCategory event, Emitter<OrderState> emit) async {
    try {
      if (state is OrderLoadSuccess) {
        final currentState = state as OrderLoadSuccess;
        EasyLoading.show();
        final products = await _orderUseCase.getProductsByCategoryId(
            event.category.id!,
            page: event.page,
            size: event.size);
        emit(currentState.copyWith(
            chosenCategory: event.category,
            products: products,
            isLoadMore: false,
            cannotLoadMore: false));
        EasyLoading.dismiss();
      }
    } catch (e) {
      ExceptionUtil.handle(e);
      emit(OrderLoadFailure());
    }
  }

  FutureOr<void> _onOrderChangeViewType(
      OrderChangeViewType event, Emitter<OrderState> emit) async {
    try {
      if (state is OrderLoadSuccess) {
        final successState = state as OrderLoadSuccess;
        emit(successState.copyWith(viewType: event.viewType));
      }
    } catch (e) {
      print(e);
      emit(OrderLoadFailure());
    }
  }
}
