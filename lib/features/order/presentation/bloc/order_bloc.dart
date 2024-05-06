part of order;

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderUseCase _orderUseCase;

  OrderBloc(this._orderUseCase) : super(OrderInitial()) {
    on<OrderLoadInformation>(_onOrderLoadInformation);
    on<OrderLoadMoreInformation>(_onOrderLoadMoreInformation);
    on<OrderRefreshInformation>(_onOrderRefreshInformation);
    on<OrderSelectCategory>(_onOrderSelectCategory);
    on<OrderApplyFilter>(_onOrderApplyFilter);
    on<OrderApplySort>(_onOrderApplySort);
    on<OrderChangeViewType>(_onOrderChangeViewType);
  }

  FutureOr<void> _onOrderLoadInformation(
      OrderLoadInformation event, Emitter<OrderState> emit) async {
    try {
      EasyLoading.show();
      final categories = await _orderUseCase.getAllCategory();
      List<ProductInformationEntity> products = [];
      if (categories.isNotEmpty) {
        products = await _orderUseCase.getProductsByCategoryId(categories[0].id,
            page: event.initPage, size: event.initSize);
      }
      emit(OrderLoadSuccess(
          page: event.initPage,
          size: event.initSize,
          categories: categories,
          products: products,
          chosenCategory: categories[0]));
      EasyLoading.dismiss();
    } catch (e) {
      emit(OrderLoadFailure());
    }
  }

  FutureOr<void> _onOrderLoadMoreInformation(
      OrderLoadMoreInformation event, Emitter<OrderState> emit) async {
    try {
      if (state is OrderLoadSuccess) {
        final currentState = state as OrderLoadSuccess;
        emit(currentState.copyWith(isLoadMore: true));
        final OrderQueryEntity orderQuery = OrderQueryEntity(
            minPrice: currentState.minPrice,
            maxPrice: currentState.maxPrice,
            minStar: currentState.minStar,
            sortType: currentState.sortType);
        final products = await _orderUseCase.getProductsByCategoryId(
            currentState.chosenCategory!.id,
            page: currentState.page + 1,
            size: currentState.size,
            query: orderQuery);
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

  FutureOr<void> _onOrderRefreshInformation(
      OrderRefreshInformation event, Emitter<OrderState> emit) async {
    try {
      if (state is OrderLoadSuccess) {
        final currentState = state as OrderLoadSuccess;
        EasyLoading.show();
        OrderQueryEntity orderQuery;

        orderQuery = OrderQueryEntity(
            minPrice: currentState.minPrice,
            maxPrice: currentState.maxPrice,
            minStar: currentState.minStar,
            sortType: currentState.sortType);

        final products = await _orderUseCase.getProductsByCategoryId(
            currentState.chosenCategory?.id,
            page: event.initPage,
            size: event.initSize,
            query: orderQuery);
        emit(currentState.copyWith(
          products: products,
          page: event.initPage,
          size: event.initSize,
          isLoadMore: false,
          cannotLoadMore: false,
        ));
        EasyLoading.dismiss();
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onOrderSelectCategory(
      OrderSelectCategory event, Emitter<OrderState> emit) async {
    try {
      if (state is OrderLoadSuccess) {
        final currentState = state as OrderLoadSuccess;
        EasyLoading.show();
        OrderQueryEntity orderQuery;

        orderQuery = OrderQueryEntity(
            minPrice: currentState.minPrice,
            maxPrice: currentState.maxPrice,
            minStar: currentState.minStar,
            sortType: currentState.sortType);

        final products = await _orderUseCase.getProductsByCategoryId(
            event.category.id,
            page: event.initPage,
            size: event.initSize,
            query: orderQuery);
        emit(currentState.copyWith(
          chosenCategory: event.category,
          products: products,
          page: event.initPage,
          size: event.initSize,
          isLoadMore: false,
          cannotLoadMore: false,
        ));
        EasyLoading.dismiss();
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onOrderApplyFilter(
      OrderApplyFilter event, Emitter<OrderState> emit) async {
    try {
      if (state is OrderLoadSuccess) {
        final currentState = state as OrderLoadSuccess;
        EasyLoading.show();
        OrderQueryEntity orderQuery;
        orderQuery = OrderQueryEntity(
            minPrice: event.minPrice,
            maxPrice: event.maxPrice,
            minStar: event.minStar,
            sortType: currentState.sortType);

        final products = await _orderUseCase.getProductsByCategoryId(
            currentState.chosenCategory?.id,
            page: event.initPage,
            size: event.initSize,
            query: orderQuery);
        emit(currentState.copyWith(
            products: products,
            page: event.initPage,
            size: event.initSize,
            isLoadMore: false,
            cannotLoadMore: false,
            minPrice: () => event.minPrice,
            maxPrice: () => event.maxPrice,
            minStar: () => event.minStar));
        EasyLoading.dismiss();
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onOrderApplySort(
      OrderApplySort event, Emitter<OrderState> emit) async {
    try {
      if (state is OrderLoadSuccess) {
        final currentState = state as OrderLoadSuccess;
        EasyLoading.show();
        OrderQueryEntity orderQuery;
        orderQuery = OrderQueryEntity(
            minPrice: currentState.minPrice,
            maxPrice: currentState.maxPrice,
            minStar: currentState.minStar,
            sortType: event.sortType);

        final products = await _orderUseCase.getProductsByCategoryId(
            currentState.chosenCategory?.id,
            page: event.initPage,
            size: event.initSize,
            query: orderQuery);
        emit(currentState.copyWith(
            products: products,
            page: event.initPage,
            size: event.initSize,
            isLoadMore: false,
            cannotLoadMore: false,
            sortType: () => event.sortType));
        EasyLoading.dismiss();
      }
    } catch (e) {
      ExceptionUtil.handle(e);
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
