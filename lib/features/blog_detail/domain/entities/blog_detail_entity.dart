import 'package:shopfee/features/blog_detail/data/models/blog_detail_model.dart';
import 'package:shopfee/features/template/data/models/template_model.dart';

class BlogDetailEntity {
  final String title;
  final String summary;
  final String content;
  final String imageUrl;
  final DateTime createdAt;

  const BlogDetailEntity({
    required this.title,
    required this.summary,
    required this.content,
    required this.imageUrl,
    required this.createdAt,
  });

  factory BlogDetailEntity.fromModel(BlogDetailModel model) {
    return BlogDetailEntity(
      title: model.title,
      summary: model.summary,
      content: model.content,
      imageUrl: model.imageUrl,
      createdAt: model.createdAt,
    );
  }
}
