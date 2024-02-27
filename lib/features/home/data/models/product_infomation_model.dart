import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/core/common/enum/product_status.dart';
import 'package:shopfee/features/home/data/models/rating_summary_model.dart';

part 'product_infomation_model.g.dart';

@JsonSerializable()
class ProductInformationModel  {
  final String? id;
  final String? name;
  final String? description;
  final double? price;
  @JsonKey(name: "thumbnailUrl")
  final String? imageUrl;
  final ProductStatus? status;
  final RatingSummaryModel? ratingSummary;

  const ProductInformationModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.imageUrl,
    this.status,
    this.ratingSummary,
  });

  factory ProductInformationModel.fromJson(Map<String, dynamic> json) {
    return _$ProductInformationModelFromJson(json);
  }


}