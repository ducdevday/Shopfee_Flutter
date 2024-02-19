import 'package:shopfee/features/home/data/models/image_model.dart';

class ImageEntity {
  final String? id;
  final String? url;

  ImageEntity({this.id, this.url});

  factory ImageEntity.fromModel(ImageModel imageModel) {
    return ImageEntity(id: imageModel.id, url: imageModel.url);
  }
}
