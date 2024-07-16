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
  final List<ProductInformationEntity> recommendProducts;

  const ProductDetailLoadSuccess({
    required this.order,
    this.recommendProducts = const<ProductInformationEntity>[]
  });

  @override
  List<Object> get props => [order, recommendProducts];
}

class ProductDetailLoadFailure extends ProductDetailState{
  @override
  List<Object> get props => [];
}