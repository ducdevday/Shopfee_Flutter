part of search;

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoadInProcess extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoadSuccess extends SearchState {
  final String query;
  final int page;
  final int size;
  final List<ProductInformationEntity> products;
  final bool isLoadMore;
  final bool cannotLoadMore;

  const SearchLoadSuccess({
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

  SearchLoadSuccess copyWith({
    String? query,
    int? page,
    int? size,
    List<ProductInformationEntity>? products,
    bool? isLoadMore,
    bool? cannotLoadMore,
  }) {
    return SearchLoadSuccess(
      query: query ?? this.query,
      page: page ?? this.page,
      size: size ?? this.size,
      products: products ?? this.products,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      cannotLoadMore: cannotLoadMore ?? this.cannotLoadMore,
    );
  }
}

class SearchLoadFailure extends SearchState {
  @override
  List<Object> get props => [];
}