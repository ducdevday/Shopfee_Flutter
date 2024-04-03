

class NewPasswordEntity {
  final String userId;
  final String oldPassword;
  final String newPassword;

  const NewPasswordEntity({
    required this.userId,
    required this.oldPassword,
    required this.newPassword,
  });
}