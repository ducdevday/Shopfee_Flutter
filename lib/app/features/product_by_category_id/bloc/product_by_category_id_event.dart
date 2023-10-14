part of 'product_by_category_id_bloc.dart';

abstract class ProductByCategoryIdEvent extends Equatable {
  const ProductByCategoryIdEvent();
}

class LoadProduct extends ProductByCategoryIdEvent {
  final String categoryId;

  LoadProduct({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}

class ChangeViewTypeProduct extends ProductByCategoryIdEvent {
  final ViewType viewType;

  const ChangeViewTypeProduct({
    required this.viewType,
  });

  @override
  List<Object> get props => [viewType];
}