import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/features/review/data/datasources/review_service.dart';
import 'package:shopfee/features/review/domain/repositories/review_repository.dart';
import 'package:shopfee/features/template/data/models/template_model.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewService _reviewService;

  ReviewRepositoryImpl(this._reviewService);

  @override
  Future<TemplateEntity> getTemplate(String id) async {
    final response = await _reviewService.doSomeThing(id);
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
