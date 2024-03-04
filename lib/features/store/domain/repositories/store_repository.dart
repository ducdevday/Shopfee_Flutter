

import 'package:shopfee/features/template/domain/entities/template_entity.dart';

abstract class StoreRepository {
  Future<TemplateEntity> getTemplate(String id);
}