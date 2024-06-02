part of blog;

sealed class BlogEvent extends Equatable {
  const BlogEvent();
}

class BlogLoadInformation extends BlogEvent {
  final int initPage;
  final int initSize;

  const BlogLoadInformation({
    required this.initPage,
    required this.initSize,
  });

  @override
  List<Object> get props => [initPage, initSize];
}

class BlogLoadMoreInformation extends BlogEvent {
  @override
  List<Object> get props => [];
}

class BlogRefreshInformation extends BlogEvent {
  final int initPage;
  final int initSize;

  const BlogRefreshInformation({
    required this.initPage,
    required this.initSize,
  });

  @override
  List<Object> get props => [initPage, initSize];
}
