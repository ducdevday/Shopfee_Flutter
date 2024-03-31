class LoginEntity {
  final String email;
  final String password;
  final String fcmTokenId;

  const LoginEntity({
    required this.email,
    required this.password,
    required this.fcmTokenId
  });
}