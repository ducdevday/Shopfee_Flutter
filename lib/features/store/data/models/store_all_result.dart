import 'package:json_annotation/json_annotation.dart';

import '../models/store_information_model.dart';

part 'store_all_result.g.dart';

@JsonSerializable()
class StoreAllResult {
  final List<StoreInformationModel>? branchList;
  final int? totalPage;

  const StoreAllResult({
    this.branchList,
    this.totalPage,
  });

  factory StoreAllResult.fromJson(Map<String, dynamic> json) {
    return _$StoreAllResultFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StoreAllResultToJson(this);
  }
}
