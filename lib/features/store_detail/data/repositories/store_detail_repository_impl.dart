import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/features/store_detail/data/datasources/store_detail_service.dart';
import 'package:shopfee/features/store_detail/domain/repositories/store_detail_repository.dart';
import 'package:shopfee/features/template/data/models/template_model.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';

class StoreDetailRepositoryImpl implements StoreDetailRepository {
  final StoreDetailService _storeDetailService;

  StoreDetailRepositoryImpl(this._storeDetailService);

  @override
  Future<TemplateEntity> getTemplate(String id) async {
    final response = await _storeDetailService.doSomeThing(id);
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
