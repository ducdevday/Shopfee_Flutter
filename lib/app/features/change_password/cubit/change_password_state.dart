part of 'change_password_cubit.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();
}

class ChangePasswordInitial extends ChangePasswordState {
  @override
  List<Object> get props => [];
}

class ChangePasswordLoaded extends ChangePasswordState {
  final String newPassword;
  final String confirmPassword;

  ChangePasswordLoaded({this.newPassword = "", this.confirmPassword = ""});

  bool isValid() {
    if (newPassword.isEmpty || confirmPassword.isEmpty) {
        return false;
    }
    return true;
  }

  String errorString(){
    if (newPassword.isEmpty) {
      return "Please fill this field";
    }
    else if(newPassword != confirmPassword){
      return "New Password and Confirm Password not match";
    }
    else if(newPassword.length < 6){
      return "Password must have greater or equal 6 characters";
    }
    return "";
  }

  @override
  List<Object> get props => [newPassword, confirmPassword];

  @override
  String toString() {
    return 'ChangePasswordLoaded{' +
        ' newPassword: $newPassword,' +
        ' confirmPassword: $confirmPassword,' +
        '}';
  }

  ChangePasswordLoaded copyWith({
    String? newPassword,
    String? confirmPassword,
  }) {
    return ChangePasswordLoaded(
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'newPassword': this.newPassword,
      'confirmPassword': this.confirmPassword,
    };
  }

  factory ChangePasswordLoaded.fromMap(Map<String, dynamic> map) {
    return ChangePasswordLoaded(
      newPassword: map['newPassword'] as String,
      confirmPassword: map['confirmPassword'] as String,
    );
  }
}

class ChangePasswordSuccess  extends ChangePasswordState {
  @override
  List<Object?> get props => [];

}