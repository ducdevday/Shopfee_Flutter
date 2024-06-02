part of blog;

sealed class BlogState extends Equatable {
  const BlogState();
}

final class BlogInitial extends BlogState {
  @override
  List<Object> get props => [];
}

final class BlogLoadInProcess extends BlogState {
  @override
  List<Object> get props => [];
}

final class BlogLoadSuccess extends BlogState {
  final List<BlogInformationEntity> blogs;
  final int page;
  final int size;
  final bool isLoadMore;
  final bool cannotLoadMore;

  const BlogLoadSuccess({
    required this.blogs,
    required this.page,
    required this.size,
    this.isLoadMore = false,
    this.cannotLoadMore = false,
  });

  @override
  List<Object> get props => [blogs, page, size, isLoadMore, cannotLoadMore];

  BlogLoadSuccess copyWith({
    List<BlogInformationEntity>? blogs,
    int? page,
    int? size,
    bool? isLoadMore,
    bool? cannotLoadMore,
  }) {
    return BlogLoadSuccess(
      blogs: blogs ?? this.blogs,
      page: page ?? this.page,
      size: size ?? this.size,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      cannotLoadMore: cannotLoadMore ?? this.cannotLoadMore,
    );
  }
}

final class BlogLoadError extends BlogState {
  @override
  List<Object> get props => [];
}
