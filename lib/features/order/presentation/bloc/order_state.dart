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
  final int page;
  final int size;
  final bool isLoadMore;
  final bool cannotLoadMore;
  final String? branchId;
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
    if(branchId != null){
      num++;
    }
    return num;
  }

  get sortNumber {
    int num = 0;
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
      required this.page,
      required this.size,
      this.isLoadMore = false,
      this.cannotLoadMore = false,
      this.branchId,
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
        page,
        size,
        isLoadMore,
        cannotLoadMore,
        branchId,
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
    int? page,
    int? size,
    bool? isLoadMore,
    bool? cannotLoadMore,
    ValueGetter<String?>? branchId,
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
      page: page ?? this.page,
      size: size ?? this.size,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      cannotLoadMore: cannotLoadMore ?? this.cannotLoadMore,
      branchId: branchId != null ? branchId() : this.branchId,
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
