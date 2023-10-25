abstract class LocalRepositoryBase{
  Future<void> saveUser(String userId, String accessToken, String refreshToken);
  Future<void> deleteUser();
}