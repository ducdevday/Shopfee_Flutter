import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/product_detail/domain/entities/size_entity.dart';

part 'size_model.g.dart';

@JsonSerializable()
class SizeModel {
  final String? size;
  final double? price;

  SizeModel({required this.size, required this.price});

  factory SizeModel.fromJson(Map<String, dynamic> json) {
    return _$SizeModelFromJson(json);
  }


  Map<String, dynamic> toJson() {
    return _$SizeModelToJson(this);
  }

  factory SizeModel.fromEntity(SizeEntity entity) {
    return SizeModel(size: entity.size, price: entity.price);
  }
}
