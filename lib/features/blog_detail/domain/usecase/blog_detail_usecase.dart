import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/features/blog/domain/repositories/blog_repository.dart';
import 'package:shopfee/features/blog_detail/domain/entities/blog_detail_entity.dart';
import 'package:shopfee/features/blog_detail/domain/repositories/blog_detail_repository.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';
import 'package:shopfee/features/template/domain/repositories/template_repository.dart';

abstract class BlogDetailUseCase {
  Future<BlogDetailEntity> getBlogDetail(String blogId);
}

class BlogDetailUseCaseImpl extends BlogDetailUseCase {
  final BlogDetailRepository _blogDetailRepository;

  BlogDetailUseCaseImpl(this._blogDetailRepository);

  @override
  Future<BlogDetailEntity> getBlogDetail(String blogId) async {
    return await _blogDetailRepository.getBlogDetail(blogId);
  }
}
