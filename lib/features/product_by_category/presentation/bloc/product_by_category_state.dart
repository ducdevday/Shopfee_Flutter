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
  final String? categoryId;
  final int page;
  final int size;
  final List<ProductInformationEntity> products;
  final ProductViewType viewType;
  final bool isLoadMore;
  final bool cannotLoadMore;

  const ProductByCategoryLoadSuccess(
      {this.categoryId,
      required this.page,
      required this.size,
      required this.products,
      this.viewType = ProductViewType.List_View_Vertical,
      this.isLoadMore = false,
      this.cannotLoadMore = false});

  ProductByCategoryLoadSuccess copyWith({
    String? categoryId,
    int? page,
    int? size,
    List<ProductInformationEntity>? products,
    ProductViewType? viewType,
    bool? isLoadMore,
    bool? cannotLoadMore,
  }) {
    return ProductByCategoryLoadSuccess(
      categoryId: categoryId ?? this.categoryId,
      page: page ?? this.page,
      size: size ?? this.size,
      products: products ?? this.products,
      viewType: viewType ?? this.viewType,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      cannotLoadMore: cannotLoadMore ?? this.cannotLoadMore,
    );
  }

  @override
  List<Object?> get props => [
        categoryId,
        page,
        size,
        products,
        viewType,
        isLoadMore,
        cannotLoadMore,
      ];
}

class ProductByCategoryLoadFailure extends ProductByCategoryState {
  @override
  List<Object> get props => [];
}
