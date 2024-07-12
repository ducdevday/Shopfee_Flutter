

import 'package:shopfee/features/blog_detail/domain/entities/blog_detail_entity.dart';

abstract class BlogDetailRepository {
  Future<BlogDetailEntity> getBlogDetail(String blogId) ;
}