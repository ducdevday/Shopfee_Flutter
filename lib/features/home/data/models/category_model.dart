import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/home/data/models/image_model.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  final String? id;
  final String? name;
  @JsonKey(name: "imageUrl")
  final ImageModel? image;

  CategoryModel({this.id, this.name, this.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return _$CategoryModelFromJson(json);
  }

}
