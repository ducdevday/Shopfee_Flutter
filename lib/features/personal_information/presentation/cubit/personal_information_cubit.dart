part of personal_information;

class PersonalInformationCubit extends Cubit<PersonalInformationState> {
  final PersonalInformationUseCase _personalInformationUseCase;

  PersonalInformationCubit(this._personalInformationUseCase)
      : super(PersonalInformationInitial());

  void checkValidField({
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) {
    if (ValidateFieldUtil.validateName(firstName) &&
        ValidateFieldUtil.validateName(lastName) &&
        (phoneNumber.isEmpty || ValidateFieldUtil.validatePhone(phoneNumber))) {
      emit(const PersonalInformationReady());
    } else {
      emit(PersonalInformationInitial());
    }
  }

  Future<void> updateUser(UserEntity user, File? image) async {
    if (state is PersonalInformationReady) {
      try {
        EasyLoading.show(maskType: EasyLoadingMaskType.black);
        await _personalInformationUseCase.updateUserInformation(
            SharedService.getUserId()!, user);
        if(image != null){
          await _personalInformationUseCase.updateUserAvatar(SharedService.getUserId()!, image);
        }
        EasyLoading.dismiss();
        EasyLoading.showInfo("Update Information Successfully",
            duration: const Duration(milliseconds: 2000));
        emit(PersonalInformationFinished());
      } catch (e) {
        ExceptionUtil.handle(e);
      }
    }
  }
}
