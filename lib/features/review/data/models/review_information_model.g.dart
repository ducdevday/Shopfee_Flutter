// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewInformationModel _$ReviewInformationModelFromJson(
        Map<String, dynamic> json) =>
    ReviewInformationModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      review: json['review'] == null
          ? null
          : ReviewModel.fromJson(json['review'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReviewInformationModelToJson(
        ReviewInformationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbnailUrl': instance.thumbnailUrl,
      'review': instance.review,
    };
