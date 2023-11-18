import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopfee/data/models/category.dart';
import 'package:shopfee/data/models/product.dart';
import 'package:shopfee/data/models/product_information.dart';
import 'package:shopfee/data/repositories/category/category_repository.dart';
import 'package:shopfee/data/repositories/product/product_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CategoryRepository categoryRepository;
  final ProductRepository productRepository;

  HomeBloc({required this.categoryRepository, required this.productRepository})
      : super(HomeInitial()) {
    on<LoadHome>(_onLoadHome);
    on<ChooseCategoryHome>(_onChooseCategoryHome);
  }

  FutureOr<void> _onLoadHome(LoadHome event, Emitter<HomeState> emit) async {
    print("_onLoadHome");
    emit(HomeLoading());
    try {
      var responseCategory = await categoryRepository.getAllCategory();
      var responseProduct = await productRepository.getOutStandingProduct(quantity: 8);
      if (responseCategory.success && responseProduct.success) {
        List<Category> categories =
            responseCategory.data!.map((c) => Category.fromMap(c)).toList();
        List<ProductInformation> products = responseProduct.data!
            .map((p) => ProductInformation.fromMap(p))
            .toList();
        List<ProductInformation> outStandingProduct =
            products.sublist(0, 8);

        emit(HomeLoaded(categories: categories, products: outStandingProduct));
      } else {
        emit(HomeError());
      }
    } catch (e) {
      print(e);
      emit(HomeError());
    }
  }

  FutureOr<void> _onChooseCategoryHome(
      ChooseCategoryHome event, Emitter<HomeState> emit) {
    // print("_onChooseCategoryHome");
    // if(state is HomeLoaded){
    //   final currentSate = state as HomeLoaded;
    //   try{
    //     emit(currentSate.copyWith(categoryChosenId: event.id));
    //   }
    //   catch (e) {
    //     print(e);
    //     emit(HomeError());
    //   }
    // }
  }
}
