part of personal_information;

abstract class PersonalInformationState extends Equatable {
  const PersonalInformationState();
}

class PersonalInformationInitial extends PersonalInformationState {
  @override
  List<Object> get props => [];
}

class PersonalInformationReady extends PersonalInformationState {

  const PersonalInformationReady();

  @override
  List<Object> get props => [];
}

class PersonalInformationFinished extends PersonalInformationState {
  @override
  List<Object> get props => [];
}
