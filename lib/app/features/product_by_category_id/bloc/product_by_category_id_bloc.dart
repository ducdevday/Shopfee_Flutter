import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopfee/data/models/product_information.dart';
import 'package:shopfee/data/repositories/product/product_repository.dart';

part 'product_by_category_id_event.dart';
part 'product_by_category_id_state.dart';

class ProductByCategoryIdBloc
    extends Bloc<ProductByCategoryIdEvent, ProductByCategoryIdState> {
  final ProductRepository productRepository;

  ProductByCategoryIdBloc({required this.productRepository})
      : super(ProductByCategoryIdInitial()) {
    on<LoadProduct>(_onLoadProduct);
    on<ChangeViewTypeProduct>(_onChangeViewTypeProduct);
  }

  FutureOr<void> _onLoadProduct(
      LoadProduct event, Emitter<ProductByCategoryIdState> emit) async {
    emit(ProductByCategoryLoading());
    try {
      var response =
          await productRepository.getProductsByCategoryId(event.categoryId);
      if (response.success) {
        List<ProductInformation> products = response.data!
            .map((e) => ProductInformation.fromMap(e))
            .toList();
        emit(ProductByCategoryLoaded(products: products));
      } else {
        emit(ProductByCategoryError());
      }
    } catch (e) {
      print(e);
      emit(ProductByCategoryError());
    }
  }

  FutureOr<void> _onChangeViewTypeProduct(ChangeViewTypeProduct event, Emitter<ProductByCategoryIdState> emit) {
    try{
      if(state is ProductByCategoryLoaded ){
        final successState = state as ProductByCategoryLoaded;
        emit(successState.copyWith(viewType: event.viewType));
      }
    }
    catch(e){
      print(e);
      emit(ProductByCategoryError());
    }
  }
}
