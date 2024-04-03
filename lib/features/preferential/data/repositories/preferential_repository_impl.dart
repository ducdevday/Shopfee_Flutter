import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/features/preferential/data/datasources/preferential_service.dart';
import 'package:shopfee/features/preferential/domain/repositories/preferential_repository.dart';
import 'package:shopfee/features/template/data/models/template_model.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';

class PreferentialRepositoryImpl implements PreferentialRepository {
  final PreferentialService _preferentialService;

  PreferentialRepositoryImpl(this._preferentialService);

  @override
  Future<TemplateEntity> getTemplate(String id) async {
    final response = await _preferentialService.doSomeThing(id);
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final templateModel = TemplateModel.fromJson(json: result.data!);
    final templateEntity = TemplateEntity.fromModel(templateModel);
    return templateEntity;
  }
}
