import 'package:shopfee/features/notify_permission/domain/repositories/notification_permission_repository.dart';

abstract class NotificationPermissionUseCase {
  Future<String> saveFCMTokenToDB(String? userId, String? fcmToken);
}

class NotificationPermissionUseCaseImpl extends NotificationPermissionUseCase {
  final NotificationPermissionRepository _notificationPermissionRepository;

  NotificationPermissionUseCaseImpl(this._notificationPermissionRepository);

  @override
  Future<String> saveFCMTokenToDB(String? userId, String? fcmToken) async {
    return await _notificationPermissionRepository.saveFCMTokenToDB(userId, fcmToken);
  }
}
