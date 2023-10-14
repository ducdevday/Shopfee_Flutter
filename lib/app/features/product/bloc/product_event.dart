part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class LoadProduct extends ProductEvent {
  final String productId;

  LoadProduct(this.productId);

  @override
  List<Object?> get props => [productId];
}

class LoadUpdatingProduct extends ProductEvent {
  final Order order;

  LoadUpdatingProduct(this.order);

  @override
  List<Object?> get props => [order];
}

class DecreaseQuantityAndDelete extends ProductEvent{
  List<Object?> get props => [];
}

class IncreaseQuantity extends ProductEvent {
  List<Object?> get props => [];
}

class DecreaseQuantity extends ProductEvent {
  List<Object?> get props => [];
}

class ChooseSize extends ProductEvent {
  final SizeModel size;

  ChooseSize(this.size);

  @override
  List<Object?> get props => [size];
}

class ChooseTopping extends ProductEvent {
  final Topping topping;

  ChooseTopping(this.topping);

  @override
  List<Object> get props => [topping];
}

class TakeNote extends ProductEvent {
  final String note;

  TakeNote(this.note);

  @override
  List<Object> get props => [note];
}
