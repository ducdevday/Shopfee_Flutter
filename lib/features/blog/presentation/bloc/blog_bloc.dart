part of blog;

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogUseCase _blogUseCase;

  BlogBloc(this._blogUseCase) : super(BlogInitial()) {
    on<BlogLoadInformation>(_onBlogLoadInformation);
    on<BlogLoadMoreInformation>(_onBlogLoadMoreInformation);
    on<BlogRefreshInformation>(_onBlogRefreshInformation);
  }

  FutureOr<void> _onBlogLoadInformation(
      BlogLoadInformation event, Emitter<BlogState> emit) async {
    try {
      emit(BlogLoadInProcess());
      final blogs = await _blogUseCase.getBlogs(event.initPage, event.initSize);
      emit(BlogLoadSuccess(
          blogs: blogs, page: event.initPage, size: event.initSize));
    } catch (e) {
      emit(BlogLoadError());
    }
  }

  FutureOr<void> _onBlogLoadMoreInformation(
      BlogLoadMoreInformation event, Emitter<BlogState> emit) async {
    try {
      if (state is BlogLoadSuccess) {
        final currentState = state as BlogLoadSuccess;
        emit(currentState.copyWith(isLoadMore: true));
        final blogs = await _blogUseCase.getBlogs(
            currentState.page + 1, currentState.size);
        await Future.delayed(Duration(milliseconds: 1000));
        if (blogs.isNotEmpty) {
          emit(currentState.copyWith(
              page: currentState.page + 1,
              blogs: List.from(currentState.blogs)..addAll(blogs),
              isLoadMore: false));
        } else {
          emit(currentState.copyWith(cannotLoadMore: true));
        }
      }
    } catch (e) {
      emit(BlogLoadError());
    }
  }

  FutureOr<void> _onBlogRefreshInformation(
      BlogRefreshInformation event, Emitter<BlogState> emit) async {
    try {
      final blogs = await _blogUseCase.getBlogs(event.initPage, event.initSize);
      emit(BlogLoadSuccess(
          blogs: blogs, page: event.initPage, size: event.initSize));
    } catch (e) {
      emit(BlogLoadError());
    }
  }
}
