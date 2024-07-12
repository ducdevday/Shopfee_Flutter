import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/features/blog/domain/entities/blog_information_entity.dart';
import 'package:shopfee/features/blog/domain/repositories/blog_repository.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';
import 'package:shopfee/features/template/domain/repositories/template_repository.dart';

abstract class BlogUseCase {
  Future<List<BlogInformationEntity>> getBlogs(int page, int size);
}

class BlogUseCaseImpl extends BlogUseCase {
  final BlogRepository _blogRepository;

  BlogUseCaseImpl(this._blogRepository);

  @override
  Future<List<BlogInformationEntity>> getBlogs(int page, int size) async {
    print(page);
    print(size);
    return await _blogRepository.getBlogs(page, size);
  }
}
