import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/features/store/data/datasources/store_service.dart';
import 'package:shopfee/features/store/domain/repositories/store_repository.dart';
import 'package:shopfee/features/template/data/models/template_model.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';

class StoreRepositoryImpl implements StoreRepository {
  final StoreService _storeService;

  StoreRepositoryImpl(this._storeService);

  @override
  Future<TemplateEntity> getTemplate(String id) async {
    final response = await _storeService.doSomeThing(id);
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
