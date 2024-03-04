import 'package:shopfee/features/store/data/models/store_model.dart';

class StoreEntity {
  final String template;
  const StoreEntity({
    required this.template,
  });

  factory StoreEntity.fromModel(StoreModel templateModel ){
    return StoreEntity(template: templateModel.template);
  }
}