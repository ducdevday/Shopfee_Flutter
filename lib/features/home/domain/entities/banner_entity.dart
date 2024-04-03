import 'package:shopfee/features/home/data/models/banner_model.dart';

class BannerEntity{
  final String imageUrl;

  const BannerEntity({
    required this.imageUrl,
  });

  factory BannerEntity.fromModel(BannerModel model) {
    return BannerEntity(
      imageUrl: model.imageUrl,
    );
  }
//
}