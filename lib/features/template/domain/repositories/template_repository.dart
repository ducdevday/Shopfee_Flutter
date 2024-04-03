

import 'package:shopfee/features/template/domain/entities/template_entity.dart';

abstract class TemplateRepository {
  Future<TemplateEntity> getTemplate(String id);
}