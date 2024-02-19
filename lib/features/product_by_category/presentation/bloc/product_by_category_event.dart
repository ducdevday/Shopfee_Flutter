part of product_by_category;

abstract class ProductByCategoryEvent extends Equatable {
  const ProductByCategoryEvent();
}

class ProductByCategoryLoadInformation extends ProductByCategoryEvent {
  final String categoryId;

  const ProductByCategoryLoadInformation({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}

class ProductByCategoryChangeViewType extends ProductByCategoryEvent {
  final ViewType viewType;

  const ProductByCategoryChangeViewType({
    required this.viewType,
  });

  @override
  List<Object> get props => [viewType];
}