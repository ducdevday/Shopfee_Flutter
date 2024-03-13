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
  final ProductViewType viewType;
  final bool isLoadMore;
  final bool cannotLoadMore;
  final num? minPrice;
  final num? maxPrice;
  final num? minStar;
  final ProductSortType? sortType;

  get filterNumber {
    int num = 0;
    if (minPrice != null || maxPrice != null) {
      num++;
    }
    if (minStar != null && minStar! > 0) {
      num++;
    }
    if (sortType != null) {
      num++;
    }
    return num;
  }

  const OrderLoadSuccess(
      {required this.categories,
      this.chosenCategory,
      required this.products,
      this.viewType = ProductViewType.List_View_Vertical,
      this.isLoadMore = false,
      this.cannotLoadMore = false,
      this.minPrice,
      this.maxPrice,
      this.minStar,
      this.sortType});

  @override
  List<Object?> get props => [
        categories,
        chosenCategory,
        products,
        viewType,
        isLoadMore,
        cannotLoadMore,
        minPrice,
        maxPrice,
        minStar,
        sortType,
      ];

  OrderLoadSuccess copyWith({
    List<CategoryEntity>? categories,
    CategoryEntity? chosenCategory,
    List<ProductInformationEntity>? products,
    ProductViewType? viewType,
    bool? isLoadMore,
    bool? cannotLoadMore,
    ValueGetter<num?>? minPrice,
    ValueGetter<num?>? maxPrice,
    ValueGetter<num?>? minStar,
    ValueGetter<ProductSortType?>? sortType,
  }) {
    return OrderLoadSuccess(
      categories: categories ?? this.categories,
      chosenCategory: chosenCategory ?? this.chosenCategory,
      products: products ?? this.products,
      viewType: viewType ?? this.viewType,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      cannotLoadMore: cannotLoadMore ?? this.cannotLoadMore,
      minPrice: minPrice != null ? minPrice() : this.minPrice,
      maxPrice: maxPrice != null ? maxPrice() : this.maxPrice,
      minStar: minStar != null ? minStar() : this.minStar,
      sortType: sortType != null ? sortType() : this.sortType,
    );
  }
}

class OrderLoadFailure extends OrderState {
  @override
  List<Object> get props => [];
}
