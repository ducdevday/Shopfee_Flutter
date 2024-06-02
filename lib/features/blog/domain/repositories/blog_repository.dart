import 'package:shopfee/features/blog/domain/entities/blog_information_entity.dart';

abstract class BlogRepository {
  Future<List<BlogInformationEntity>> getBlogs(int page, int size);
}
