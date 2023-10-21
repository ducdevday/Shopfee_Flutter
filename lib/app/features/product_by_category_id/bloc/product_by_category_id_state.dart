part of 'product_by_category_id_bloc.dart';

enum ViewType{List_View, Grid_View}

abstract class ProductByCategoryIdState extends Equatable {
  const ProductByCategoryIdState();
}

class ProductByCategoryIdInitial extends ProductByCategoryIdState {
  @override
  List<Object> get props => [];
}


class ProductByCategoryLoading extends ProductByCategoryIdState {
  @override
  List<Object> get props => [];
}

class ProductByCategoryLoaded extends ProductByCategoryIdState {
  final List<ProductInformation> products;
  final ViewType viewType;

  @override
  List<Object> get props => [products, viewType];

  const ProductByCategoryLoaded({
    required this.products,
    this.viewType = ViewType.List_View
  });

  @override
  String toString() {
    return 'ProductByCategoryLoaded{' +
        ' products: $products,' +
        ' viewType: $viewType,' +
        '}';
  }

  ProductByCategoryLoaded copyWith({
    List<ProductInformation>? products,
    ViewType? viewType,
  }) {
    return ProductByCategoryLoaded(
      products: products ?? this.products,
      viewType: viewType ?? this.viewType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'products': this.products,
      'viewType': this.viewType,
    };
  }

  factory ProductByCategoryLoaded.fromMap(Map<String, dynamic> map) {
    return ProductByCategoryLoaded(
      products: map['products'] as List<ProductInformation>,
      viewType: map['viewType'] as ViewType,
    );
  }
}

class ProductByCategoryError extends ProductByCategoryIdState{
  @override
  List<Object> get props => [];
}