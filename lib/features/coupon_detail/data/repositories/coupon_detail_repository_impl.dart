import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/features/coupon_detail/data/datasources/coupon_detail_service.dart';
import 'package:shopfee/features/template/data/datasources/template_service.dart';
import 'package:shopfee/features/template/data/models/template_model.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';

import 'package:shopfee/features/template/domain/repositories/template_repository.dart';

class CouponDetailRepositoryImpl implements TemplateRepository {
  final CouponDetailService _templateService;

  CouponDetailRepositoryImpl(this._templateService);

  @override
  Future<TemplateEntity> getTemplate(String id) async {
    final response = await _templateService.doSomeThing(id);
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
