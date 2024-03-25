

import 'package:shopfee/features/template/domain/entities/template_entity.dart';

abstract class ReviewRepository {
  Future<TemplateEntity> getTemplate(String id);
}