import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopfee/data/models/product_information.dart';
import 'package:shopfee/data/repositories/product/product_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final ProductRepository productRepository;

  SearchCubit({required this.productRepository}) : super(SearchInitial());

  void searchProduct(String query) async {
    emit(SearchLoading());
    try {
      var response = await productRepository.getSearchProduct(
          searchString: query, page: 1, size: 9);
      if (response.success) {
        List<ProductInformation> products =
        response.data!.map((p) => ProductInformation.fromMap(p)).toList();
        emit(SearchLoaded(query: query, products: products, page: 1, size: 5));
      }
    }
    catch (e) {
      print(e);
      emit(SearchError());
    }
  }

  void loadMoreProduct() async {
    if (state is SearchLoaded) {
      final currentState = state as SearchLoaded;
      emit(currentState.copyWith(isLoadMore: true));
      await Future.delayed(Duration(milliseconds: 1000));
      final response = await productRepository.getSearchProduct(
          searchString: currentState.query,
          page: currentState.page + 1,
          size: currentState.size);

      if (response.success) {
        final moreList = response.data!.map((e) =>
            ProductInformation.fromMap(e)).toList();
        if (moreList.isNotEmpty) {
          emit(currentState.copyWith(products: List.from(currentState.products)
            ..addAll(moreList),
              page: currentState.page + 1,
              isLoadMore: false));
        }
        else {
          emit(currentState.copyWith(cannotLoadMore: true));
        }
      }
    }
  }
}
