part of product_detail;

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();
}

class ProductDetailLoadInformation extends ProductDetailEvent {
  final String productId;

  const ProductDetailLoadInformation(this.productId);

  @override
  List<Object?> get props => [productId];
}

class ProductDetailLoadUpdating extends ProductDetailEvent {
  final OrderEntity order;

  const ProductDetailLoadUpdating(this.order);

  @override
  List<Object?> get props => [order];
}

class ProductDetailDecreaseQuantityAndDelete extends ProductDetailEvent{
  List<Object?> get props => [];
}

class ProductDetailIncreaseQuantity extends ProductDetailEvent {
  List<Object?> get props => [];
}

class ProductDetailDecreaseQuantity extends ProductDetailEvent {
  List<Object?> get props => [];
}

class ProductDetailChooseSize extends ProductDetailEvent {
  final SizeEntity size;

  const ProductDetailChooseSize(this.size);

  @override
  List<Object?> get props => [size];
}

class ProductDetailChooseTopping extends ProductDetailEvent {
  final ToppingEntity topping;

  const ProductDetailChooseTopping(this.topping);

  @override
  List<Object> get props => [topping];
}

class ProductDetailTakeNote extends ProductDetailEvent {
  final String note;

  const ProductDetailTakeNote(this.note);

  @override
  List<Object> get props => [note];
}