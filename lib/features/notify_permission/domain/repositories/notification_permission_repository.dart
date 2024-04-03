abstract class NotificationPermissionRepository {
  Future<String> saveFCMTokenToDB(String? userId, String? fcmToken);
}