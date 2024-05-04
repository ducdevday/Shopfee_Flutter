class AutoCompleteResultModel{
  final String placeId;
  final String description;

  const AutoCompleteResultModel({
    required this.placeId,
    required this.description,
  });

  factory AutoCompleteResultModel.fromJson(Map<String, dynamic> json) {
    return AutoCompleteResultModel(
      placeId: json["place_id"],
      description: json["structured_formatting"]["main_text"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "placeId": this.placeId,
      "description": this.description,
    };
  }
}