

import 'package:shopfee/features/template/domain/entities/template_entity.dart';

abstract class StoreDetailRepository {
  Future<TemplateEntity> getTemplate(String id);
}