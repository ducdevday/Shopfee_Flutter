
import 'package:shopfee/features/template/domain/entities/template_entity.dart';

class TemplateModel extends TemplateEntity {
  const TemplateModel({
    required String template,
  }) : super(
    template: template,
  );

  factory TemplateModel.fromJson({required Map<String, dynamic> json}) {
    return TemplateModel(
      template: json["template"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "template": template,
    };
  }

  factory TemplateModel.fromEntity(TemplateEntity templateEntity) {
    return TemplateModel(
      template: templateEntity.template,
    );
  }
}