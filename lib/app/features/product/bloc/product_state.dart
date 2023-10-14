part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
}

class ProductInitial extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoaded extends ProductState {
  final Order order;

  const ProductLoaded({
    required this.order,
  });

  @override
  List<Object> get props => [order];
}

class ProductError extends ProductState{
  @override
  List<Object> get props => [];
}