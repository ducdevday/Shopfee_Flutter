part of 'blog_detail_cubit.dart';

@immutable
sealed class BlogDetailState {}

final class BlogDetailInitial extends BlogDetailState {}

final class BlogDetailLoadInProcess extends BlogDetailState {}

final class BlogDetailLoadSuccess extends BlogDetailState {
  final BlogDetailEntity blog;

  BlogDetailLoadSuccess({
    required this.blog,
  });
}

final class BlogDetailLoadError extends BlogDetailState {}
