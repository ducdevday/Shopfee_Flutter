part of user;

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUseCase _userUseCase;

  UserBloc(this._userUseCase) : super(UserInitial()) {
    on<UserLoadInformation>(_onUserLoadInformation);
    on<UserUpdateInformation>(_onUserUpdateInformation);
    on<UserUpdatePhoneNumber>(_onUserUpdatePhoneNumber);
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

  FutureOr<void> _onUserUpdateInformation(
      UserUpdateInformation event, Emitter<UserState> emit) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      await _userUseCase.updateUser(event.user);
      EasyLoading.dismiss();
      EasyLoading.showInfo("Update Information Successfully",
          duration: const Duration(milliseconds: 2000));
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onUserUpdatePhoneNumber(
      UserUpdatePhoneNumber event, Emitter<UserState> emit) async {
    try {
      if (state is UserLoadSuccess) {
        final currentState = state as UserLoadSuccess;
        EasyLoading.show(maskType: EasyLoadingMaskType.black);
        await _userUseCase.updatePhoneNumber(
            SharedService.getUserId()!, event.phoneNumber);
        EasyLoading.dismiss();
        EasyLoading.showInfo("Update Phone Number Successfully",
            duration: const Duration(milliseconds: 2000));
        emit(UserLoadSuccess(
            user: currentState.user.copyWith(phoneNumber: event.phoneNumber)));
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onUserLogout(
      UserLogout event, Emitter<UserState> emit) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      await _userUseCase.logoutUser(
          SharedService.getUserId()!, SharedService.getFCMTokenId()!);
      SharedService.clearToken();
      emit(UserInitial());
      EasyLoading.dismiss();
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }
}
