import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/features/blog_detail/data/datasources/blog_detail_service.dart';
import 'package:shopfee/features/blog_detail/data/models/blog_detail_model.dart';
import 'package:shopfee/features/blog_detail/domain/entities/blog_detail_entity.dart';
import 'package:shopfee/features/blog_detail/domain/repositories/blog_detail_repository.dart';
import 'package:shopfee/features/template/data/models/template_model.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';

class BlogDetailRepositoryImpl implements BlogDetailRepository {
  final BlogDetailService _blogDetailService;

  BlogDetailRepositoryImpl(this._blogDetailService);

  @override
  Future<BlogDetailEntity> getBlogDetail(String blogId) async {
    final response = await _blogDetailService.getBlogDetail(blogId);
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final blogModel = BlogDetailModel.fromJson(result.data!);
    final blogEntity = BlogDetailEntity.fromModel(blogModel);
    return blogEntity;
  }
}
