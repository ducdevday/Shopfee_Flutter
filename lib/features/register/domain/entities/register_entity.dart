class RegisterEntity{
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? code;
  final String fcmTokenId;

  const RegisterEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.code,
    required this.fcmTokenId
  });

  RegisterEntity copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? code,
    String? fcmTokenId,
  }) {
    return RegisterEntity(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      code: code ?? this.code,
      fcmTokenId: fcmTokenId ?? this.fcmTokenId,
    );
  }
}