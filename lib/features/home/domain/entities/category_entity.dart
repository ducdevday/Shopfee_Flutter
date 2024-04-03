import 'package:shopfee/features/home/data/models/category_model.dart';
import 'package:shopfee/features/home/domain/entities/image_entity.dart';

class CategoryEntity {
  final String? id;
  final String? name;
  final String? image;

  CategoryEntity({this.id, this.name, this.image});

  factory CategoryEntity.fromModel(CategoryModel categoryModel){
    return CategoryEntity(id: categoryModel.id,
        name: categoryModel.name,
        image: categoryModel.image);
  }

}
