abstract class ForgotPasswordRepository {
  Future<bool> checkEmailExist(String email);
}