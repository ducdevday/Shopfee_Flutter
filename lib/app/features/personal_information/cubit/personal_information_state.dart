part of 'personal_information_cubit.dart';

@immutable
abstract class PersonalInformationState  {
  const PersonalInformationState();
}

class PersonalInformationInitial extends PersonalInformationState {
  // @override
  // List<Object> get props => [];
}

class PersonalInformationLoaded extends PersonalInformationState {
  final User user;

  PersonalInformationLoaded({
    required this.user,
  });

  // @override
  // List<Object?> get props => [user];
}