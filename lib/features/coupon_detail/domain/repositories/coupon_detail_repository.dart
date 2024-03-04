

import 'package:shopfee/features/template/domain/entities/template_entity.dart';

abstract class CouponDetailRepository {
  Future<TemplateEntity> getTemplate(String id);
}