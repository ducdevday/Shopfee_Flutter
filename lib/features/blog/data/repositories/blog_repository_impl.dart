import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/features/blog/data/datasources/blog_service.dart';
import 'package:shopfee/features/blog/data/models/blog_information_model.dart';
import 'package:shopfee/features/blog/domain/entities/blog_information_entity.dart';
import 'package:shopfee/features/blog/domain/repositories/blog_repository.dart';
import 'package:shopfee/features/template/data/datasources/template_service.dart';
import 'package:shopfee/features/template/data/models/template_model.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogService _blogService;

  BlogRepositoryImpl(this._blogService);

  @override
  Future<List<BlogInformationEntity>> getBlogs(int page, int size) async {
    final response = await _blogService.getBlogs(page, size);
    final result = Result(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"]);
    final List<dynamic> blogList = result.data!["blogList"] as List<dynamic>;
    List<BlogInformationModel> blogsModel =
        blogList.map((p) => BlogInformationModel.fromJson(p)).toList();
    List<BlogInformationEntity> blogsEntity =
        blogsModel.map((p) => BlogInformationEntity.fromModel(p)).toList();
    return blogsEntity;
  }
}
