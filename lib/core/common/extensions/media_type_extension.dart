import 'package:shopfee/core/common/enum/media_type.dart';

extension MediaTypeExtension on MediaType {
  static MediaType? determineMediaTypeFromPath(String path) {
    String fileName = path.split('/').last;
    String typeString = fileName.split('.')[1];
    switch (typeString) {
      case "mp4":
        return MediaType.VIDEO;
      case "jpg":
      case "jpeg":
      case "png":
        return MediaType.IMAGE;
      default:
        return null;
    }
  }
}
