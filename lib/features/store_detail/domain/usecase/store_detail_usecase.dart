
import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/features/store_detail/domain/repositories/store_detail_repository.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';
import 'package:shopfee/features/template/domain/repositories/template_repository.dart';

abstract class StoreDetailUseCase{
  Future<TemplateEntity> doSomething(String id);
}

class StoreDetailUseCaseImpl extends StoreDetailUseCase{
  final StoreDetailRepository _storeDetailRepository;

  StoreDetailUseCaseImpl(this._storeDetailRepository);

  @override
  Future<TemplateEntity> doSomething(String id) async{
    return await _storeDetailRepository.getTemplate(id);
  }

}