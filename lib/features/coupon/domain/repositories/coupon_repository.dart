

import 'package:shopfee/features/template/domain/entities/template_entity.dart';

abstract class CouponRepository {
  Future<TemplateEntity> getTemplate(String id);
}