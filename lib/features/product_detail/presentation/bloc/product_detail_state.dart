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

  const ProductDetailLoadSuccess({
    required this.order,
  });

  @override
  List<Object> get props => [order];
}

class ProductDetailLoadFailure extends ProductDetailState{
  @override
  List<Object> get props => [];
}