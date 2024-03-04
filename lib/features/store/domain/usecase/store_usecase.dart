
import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/features/store/domain/repositories/store_repository.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';
import 'package:shopfee/features/template/domain/repositories/template_repository.dart';

abstract class StoreUseCase{
  Future<TemplateEntity> doSomething(String id);
}

class StoreUseCaseImpl extends StoreUseCase{
  final StoreRepository _storeRepository;

  StoreUseCaseImpl(this._storeRepository);

  @override
  Future<TemplateEntity> doSomething(String id) async{
    return await _storeRepository.getTemplate(id);
  }

}