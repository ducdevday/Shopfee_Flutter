import 'package:shopfee/features/blog/data/models/blog_information_model.dart';

class BlogInformationEntity {
  final String id;
  final String title;
  final String summary;
  final String thumbnailUrl;
  final DateTime createdAt;

  const BlogInformationEntity({
    required this.id,
    required this.title,
    required this.summary,
    required this.thumbnailUrl,
    required this.createdAt,
  });

  factory BlogInformationEntity.fromModel(BlogInformationModel model) {
    return BlogInformationEntity(
      id: model.id,
      title: model.title,
      summary: model.summary,
      thumbnailUrl: model.thumbnailUrl,
      createdAt: model.createdAt,
    );
  }
}
