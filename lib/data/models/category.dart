import 'package:shopfee/data/models/image.dart';

class Category {
  final String? id;
  final String? name;
  final ImageModel? image;

  Category({this.id, this.name, this.image});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'image': this.image,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as String,
      name: map['name'] as String,
      image: ImageModel.fromMap(map['image']),
    );
  }
}
