part of product_by_category;

abstract class ProductByCategoryState extends Equatable {
  const ProductByCategoryState();
}

class ProductByCategoryInitial extends ProductByCategoryState {
  @override
  List<Object> get props => [];
}

class ProductByCategoryLoadInProcess extends ProductByCategoryState {
  @override
  List<Object> get props => [];
}

class ProductByCategoryLoadSuccess extends ProductByCategoryState {
  final List<ProductInformationEntity> products;
  final ProductViewType viewType;
  final bool isLoadMore;
  final bool cannotLoadMore;

  const ProductByCategoryLoadSuccess({
    required this.products,
    this.viewType = ProductViewType.List_View_Vertical,
    this.isLoadMore = false,
    this.cannotLoadMore = false
  });

  ProductByCategoryLoadSuccess copyWith({
    List<ProductInformationEntity>? products,
    ProductViewType? viewType,
    int? page,
    int? size,
    bool? isLoadMore,
    bool? cannotLoadMore,
  }) {
    return ProductByCategoryLoadSuccess(
      products: products ?? this.products,
      viewType: viewType ?? this.viewType,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      cannotLoadMore: cannotLoadMore ?? this.cannotLoadMore,
    );
  }

  @override
  List<Object> get props =>
      [products, viewType, isLoadMore, cannotLoadMore,];
}

class ProductByCategoryLoadFailure extends ProductByCategoryState {
  @override
  List<Object> get props => [];
}