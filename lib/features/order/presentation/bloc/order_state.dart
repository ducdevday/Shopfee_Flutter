part of order;

abstract class OrderState extends Equatable {
  const OrderState();
}

class OrderInitial extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderLoadInProcess extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderLoadSuccess extends OrderState {
  final List<CategoryEntity> categories;
  final CategoryEntity? chosenCategory;
  final List<ProductInformationEntity> products;
  final ViewType viewType;
  final bool isLoadMore;
  final bool cannotLoadMore;

  const OrderLoadSuccess({
    required this.categories,
    this.chosenCategory,
    required this.products,
    this.viewType = ViewType.List_View,
    this.isLoadMore = false,
    this.cannotLoadMore = false,
  });

  @override
  List<Object?> get props => [
        categories,
        chosenCategory,
        products,
        viewType,
        isLoadMore,
        cannotLoadMore,
      ];

  OrderLoadSuccess copyWith({
    List<CategoryEntity>? categories,
    CategoryEntity? chosenCategory,
    List<ProductInformationEntity>? products,
    ViewType? viewType,
    bool? isLoadMore,
    bool? cannotLoadMore,
  }) {
    return OrderLoadSuccess(
      categories: categories ?? this.categories,
      chosenCategory: chosenCategory ?? this.chosenCategory,
      products: products ?? this.products,
      viewType: viewType ?? this.viewType,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      cannotLoadMore: cannotLoadMore ?? this.cannotLoadMore,
    );
  }
}

class OrderLoadFailure extends OrderState {
  @override
  List<Object> get props => [];
}
