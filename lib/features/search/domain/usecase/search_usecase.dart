
import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/features/home/domain/entities/product_infomation_entity.dart';
import 'package:shopfee/features/search/domain/entities/autocomplete_product_entity.dart';
import 'package:shopfee/features/search/domain/repositories/search_repository.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';
import 'package:shopfee/features/template/domain/repositories/template_repository.dart';

abstract class SearchUseCase{
  Future<List<ProductInformationEntity>> getSearchProduct(
      {required String searchString,required int page,required int size});

  Future<AutocompleteProductEntity> getAutocompleteProductName(String key);
}

class SearchUseCaseImpl extends SearchUseCase{
  final SearchRepository _searchRepository;

  SearchUseCaseImpl(this._searchRepository);

  @override
  Future<List<ProductInformationEntity>> getSearchProduct({required String searchString,required int page,required int size}) async{
    return await _searchRepository.getSearchProduct(searchString, page, size);
  }

  @override
  Future<AutocompleteProductEntity> getAutocompleteProductName(String key) async{
    return await _searchRepository.getAutocompleteProductName(key);
  }


}