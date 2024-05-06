import 'package:shopfee/features/google_map/data/models/auto_complete_result_model.dart';

class AutoCompleteResultEntity{
  final String placeId;
  final String description;

  const AutoCompleteResultEntity({
    required this.placeId,
    required this.description,
  });

  factory AutoCompleteResultEntity.fromModel(AutoCompleteResultModel model) {
    return AutoCompleteResultEntity(
      placeId: model.placeId,
      description: model.description,
    );
  }
}