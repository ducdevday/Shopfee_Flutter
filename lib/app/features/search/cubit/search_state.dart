part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoaded extends SearchState {
  final String query;
  final List<ProductInformation> _products;
  final List<ProductInformation> productsFiltered;

  @override
  List<Object> get props => [query, _products, productsFiltered];

  const SearchLoaded({
    this.query = "",
    products = const [],
    this.productsFiltered = const [],
  }) : _products = products;

  SearchLoaded copyWith({
    String? query,
    List<ProductInformation>? products,
    List<ProductInformation>? productsFiltered,
  }) {
    return SearchLoaded(
      query: query ?? this.query,
      products: products ?? this._products,
      productsFiltered: productsFiltered ?? this.productsFiltered,
    ) ;
  }
}

class SearchNoResult extends SearchState {
  @override
  List<Object> get props => [];
}
