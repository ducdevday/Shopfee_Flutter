part of product_detail;

abstract class ProductDetailState extends Equatable {
  const ProductDetailState();
}

class ProductDetailInitial extends ProductDetailState {
  @override
  List<Object> get props => [];
}

class ProductDetailLoadInProcess extends ProductDetailState {
  @override
  List<Object> get props => [];
}

class ProductDetailLoadSuccess extends ProductDetailState {
  final OrderEntity order;
  final List<ProductInformationEntity> viewedProducts;

  const ProductDetailLoadSuccess({
    required this.order,
    this.viewedProducts = const<ProductInformationEntity>[]
  });

  @override
  List<Object> get props => [order, viewedProducts];
}

class ProductDetailLoadFailure extends ProductDetailState{
  @override
  List<Object> get props => [];
}