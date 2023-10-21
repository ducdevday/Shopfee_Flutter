import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopfee/app/utils/my_converter.dart';
import 'package:shopfee/data/models/product_information.dart';
import 'package:shopfee/data/repositories/product/product_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final ProductRepository productRepository;

  SearchCubit({required this.productRepository}) : super(SearchInitial());

  void initSearch() async {
    var response = await productRepository.getAllProduct();
    if (response.success) {
      List<ProductInformation> products =
          response.data!.map((p) => ProductInformation.fromMap(p)).toList();
      emit(SearchLoaded(products: products));
    }
  }

  void searchProduct(String query) {
    if (state is SearchLoaded) {
      final currentState = state as SearchLoaded;
      List<ProductInformation> productsFiltered = currentState._products
          .where((p) => MyConverter.formattedQueryString(p.name)
              .contains(MyConverter.formattedQueryString(query)))
          .toList();
      emit(currentState.copyWith(
          query: query, productsFiltered: productsFiltered));
    }
  }
}
