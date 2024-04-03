import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/features/notify_permission/domain/repositories/notification_permission_repository.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';
import 'package:shopfee/features/template/domain/repositories/template_repository.dart';

abstract class NotificationPermissionUseCase {
  Future<String> saveFCMTokenToDB(String? userId, String? fcmToken);
}

class NotificationPermissionUseCaseImpl extends NotificationPermissionUseCase {
  final NotificationPermissionRepository _notificationPermissionRepository;

  NotificationPermissionUseCaseImpl(this._notificationPermissionRepository);

  @override
  Future<String> saveFCMTokenToDB(String? userId, String? fcmToken) {
    return _notificationPermissionRepository.saveFCMTokenToDB(userId, fcmToken);
  }
}
