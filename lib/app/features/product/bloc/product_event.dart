part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class LoadProduct extends ProductEvent {
  final Product product;

  LoadProduct(this.product);

  List<Object?> get props => [];
}

class IncreaseQuantity extends ProductEvent {
  List<Object?> get props => [];
}

class DecreaseQuantity extends ProductEvent {
  List<Object?> get props => [];
}

class ChooseVariant extends ProductEvent {
  final Variant variant;

  ChooseVariant(this.variant);

  List<Object?> get props => [variant];
}

class ChooseSize extends ProductEvent {
  final Size size;

  ChooseSize(this.size);

  List<Object?> get props => [size];
}

class ChooseSugar extends ProductEvent {
  final Sugar sugar;

  ChooseSugar(this.sugar);

  @override
  List<Object> get props => [sugar];
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
