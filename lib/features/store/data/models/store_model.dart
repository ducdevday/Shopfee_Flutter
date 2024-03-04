

class StoreModel {
  final String template;

  const StoreModel({
    required this.template,
  });

  factory StoreModel.fromJson({required Map<String, dynamic> json}) {
    return StoreModel(
      template: json["template"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "template": template,
    };
  }


}
