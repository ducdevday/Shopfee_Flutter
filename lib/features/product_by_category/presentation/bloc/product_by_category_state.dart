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
  final ViewType viewType;

  @override
  List<Object> get props => [products, viewType];

  const ProductByCategoryLoadSuccess({
    required this.products,
    this.viewType = ViewType.List_View
  });

  ProductByCategoryLoadSuccess copyWith({
    List<ProductInformationEntity>? products,
    ViewType? viewType,
  }) {
    return ProductByCategoryLoadSuccess(
      products: products ?? this.products,
      viewType: viewType ?? this.viewType,
    );
  }
}

class ProductByCategoryLoadFailure extends ProductByCategoryState{
  @override
  List<Object> get props => [];
}