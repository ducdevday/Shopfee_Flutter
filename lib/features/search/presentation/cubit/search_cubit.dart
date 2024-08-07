part of search;

class SearchCubit extends Cubit<SearchState> {
  final SearchUseCase _searchUseCase;

  SearchCubit(this._searchUseCase) : super(SearchInitial());

  void getAutoCompleteProductName(String key) async {
    try {
      emit(SearchLoadInProcess());
      final autocompleteProductEntity =
          await _searchUseCase.getAutocompleteProductName(key);
      await Future.delayed(Duration(seconds: 1));
      emit(SearchLoadAutoCompleteSuccess(
          autocompleteProductEntity: autocompleteProductEntity));
    } catch (e) {
      emit(SearchLoadFailure());
      ExceptionUtil.handle(e);
    }
  }


  void chooseAutoCompleteProductName(String query) {
    try {
      if (state is SearchLoadAutoCompleteSuccess) {
        searchProduct(query);
      }
    } catch (e) {
      emit(SearchLoadFailure());
      ExceptionUtil.handle(e);
    }
  }

  void searchProduct(String query) async {
    try {
      emit(SearchLoadInProcess());
      final products = await _searchUseCase.getSearchProduct(
          searchString: query, page: 1, size: 9);
      print("Search Product");
      await Future.delayed(Duration(seconds: 1));
      emit(SearchLoadProductSuccess(
          query: query, products: products, page: 1, size: 9));
    } catch (e) {
      emit(SearchLoadFailure());
      ExceptionUtil.handle(e);
    }
  }

  void loadMoreProduct() async {
    if (state is SearchLoadProductSuccess) {
      final currentState = state as SearchLoadProductSuccess;
      emit(currentState.copyWith(isLoadMore: true));
      final products = await _searchUseCase.getSearchProduct(
          searchString: currentState.query,
          page: currentState.page + 1,
          size: currentState.size);
      await Future.delayed(Duration(milliseconds: 1000));
      if (products.isNotEmpty) {
        emit(currentState.copyWith(
            products: List.from(currentState.products)..addAll(products),
            page: currentState.page + 1,
            isLoadMore: false));
      } else {
        emit(currentState.copyWith(cannotLoadMore: true));
      }
    }
  }
}
