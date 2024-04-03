
import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';
import 'package:shopfee/features/template/domain/repositories/template_repository.dart';

abstract class PreferentialUseCase{
  Future<TemplateEntity> doSomething(String id);
}

class PreferentialUseCaseImpl extends PreferentialUseCase{
  final TemplateRepository _templateRepository;

  PreferentialUseCaseImpl(this._templateRepository);

  @override
  Future<TemplateEntity> doSomething(String id) async{
    return await _templateRepository.getTemplate(id);
  }

}