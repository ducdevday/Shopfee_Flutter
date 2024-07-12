part of product_by_category;

abstract class ProductByCategoryEvent extends Equatable {
  const ProductByCategoryEvent();
}

class ProductByCategoryLoadInformation extends ProductByCategoryEvent {
  final String? categoryId;
  final int page;
  final int size;

  const ProductByCategoryLoadInformation({
    required this.categoryId,
    required this.page,
    required this.size,
  });

  @override
  List<Object?> get props => [categoryId, page, size];
}

class ProductByCategoryLoadMoreInformation extends ProductByCategoryEvent {
  @override
  List<Object?> get props => [];
}

class ProductByCategoryRefreshInformation extends ProductByCategoryEvent {
  final int page;
  final int size;

  const ProductByCategoryRefreshInformation({
    required this.page,
    required this.size,
  });

  @override
  List<Object?> get props => [page, size];
}

class ProductByCategoryChangeViewType extends ProductByCategoryEvent {
  final ProductViewType viewType;

  const ProductByCategoryChangeViewType({
    required this.viewType,
  });

  @override
  List<Object> get props => [viewType];
}
