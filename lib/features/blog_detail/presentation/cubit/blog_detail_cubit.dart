import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopfee/features/blog_detail/domain/entities/blog_detail_entity.dart';
import 'package:shopfee/features/blog_detail/domain/usecase/blog_detail_usecase.dart';

part 'blog_detail_state.dart';

class BlogDetailCubit extends Cubit<BlogDetailState> {
  final BlogDetailUseCase _useCase;

  BlogDetailCubit(this._useCase) : super(BlogDetailInitial());

  Future<void> loadBlogDetail(String blogId) async {
    try {
      emit(BlogDetailLoadInProcess());
      final blog = await _useCase.getBlogDetail(blogId);
      emit(BlogDetailLoadSuccess(blog: blog));
    } catch (e) {
      emit(BlogDetailLoadError());
    }
  }
}
