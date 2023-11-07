part of 'password_cubit.dart';

abstract class PasswordState extends Equatable {
  const PasswordState();
}

class PasswordInitial extends PasswordState {
  @override
  List<Object> get props => [];
}

class PasswordLoaded extends PasswordState {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  @override
  List<Object> get props => [oldPassword, newPassword, confirmPassword];

  const PasswordLoaded({
    this.oldPassword = "",
    this.newPassword = "",
    this.confirmPassword = "",
  });

  bool get oldPasswordValid =>
      oldPassword.isNotEmpty && oldPassword.length >= 6;

  bool get newPasswordValid =>
      newPassword.isNotEmpty && newPassword.length >= 6;

  bool get confirmPasswordValid =>
      confirmPassword.isNotEmpty && confirmPassword.length >= 6;

  bool get changePasswordValid =>
      oldPasswordValid && newPasswordValid && confirmPasswordValid;

  PasswordLoaded copyWith({
    String? oldPassword,
    String? newPassword,
    String? confirmPassword,
  }) {
    return PasswordLoaded(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
}

class PasswordFinished extends PasswordState {
  @override
  List<Object> get props => [];
}