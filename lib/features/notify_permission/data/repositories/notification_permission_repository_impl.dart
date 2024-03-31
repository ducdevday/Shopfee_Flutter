import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/features/notify_permission/data/datasources/notification_permission_service.dart';
import 'package:shopfee/features/notify_permission/domain/repositories/notification_permission_repository.dart';

class NotificationPermissionRepositoryImpl implements NotificationPermissionRepository {
  final NotifyPermissionService _notifyPermissionService;

  NotificationPermissionRepositoryImpl(this._notifyPermissionService);

  @override
  Future<String> saveFCMTokenToDB(String? userId, String? fcmToken) async{
    final response = await _notifyPermissionService.saveFCMTokenToDB(userId, fcmToken);
    final result = Result(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"]);
    final fcmTokenId = result.data!["fcmTokenId"] as String;
    return fcmTokenId;
  }
}
