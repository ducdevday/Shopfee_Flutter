part of user;

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUseCase _userUseCase;

  UserBloc(this._userUseCase) : super(UserInitial()) {
    on<UserLoadInformation>(_onUserLoadInformation);
    on<UserLogout>(_onUserLogout);
  }

  FutureOr<void> _onUserLoadInformation(
      UserLoadInformation event, Emitter<UserState> emit) async {
    if (SharedService.getUserId() == null) {
      emit(UserInitial());
      return;
    }
    try {
      emit(UserLoadInProcess());
      final user = await _userUseCase.getUser(SharedService.getUserId()!);
      emit(UserLoadSuccess(user: user));
    } catch (e) {
      emit(UserLoadFailure());
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onUserLogout(
      UserLogout event, Emitter<UserState> emit) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      await _userUseCase.logoutUser(SharedService.getUserId()!);
      SharedService.clearToken();
      emit(UserInitial());
      EasyLoading.dismiss();
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }
}
