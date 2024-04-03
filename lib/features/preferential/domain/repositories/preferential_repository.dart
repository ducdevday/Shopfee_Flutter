

import 'package:shopfee/features/template/domain/entities/template_entity.dart';

abstract class PreferentialRepository {
  Future<TemplateEntity> getTemplate(String id);
}