part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoaded extends SearchState {
  final String query;
  final int page;
  final int size;
  final List<ProductInformation> products;
  final bool isLoadMore;
  final bool cannotLoadMore;

  const SearchLoaded({
    this.query = "",
    this.products = const [],
    required this.page,
    required this.size,
    this.isLoadMore = false,
    this.cannotLoadMore = false
  });

  @override
  List<Object> get props =>
      [query, page, size, products, isLoadMore, cannotLoadMore,];

  SearchLoaded copyWith({
    String? query,
    int? page,
    int? size,
    List<ProductInformation>? products,
    bool? isLoadMore,
    bool? cannotLoadMore,
  }) {
    return SearchLoaded(
      query: query ?? this.query,
      page: page ?? this.page,
      size: size ?? this.size,
      products: products ?? this.products,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      cannotLoadMore: cannotLoadMore ?? this.cannotLoadMore,
    );
  }
}

class SearchError extends SearchState {
  @override
  List<Object> get props => [];
}
