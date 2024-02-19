import 'package:shopfee/features/template/data/models/template_model.dart';

class TemplateEntity {
  final String template;
  const TemplateEntity({
    required this.template,
  });

  factory TemplateEntity.fromModel(TemplateModel templateModel ){
    return TemplateEntity(template: templateModel.template);
  }
}