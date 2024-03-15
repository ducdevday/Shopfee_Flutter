import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/features/receipt/domain/entities/event_log_entity.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';
import 'package:shopfee/features/template/domain/repositories/template_repository.dart';
import 'package:shopfee/features/tracking/domain/repositories/tracking_repository.dart';

abstract class TrackingUseCase {
  Future<List<EventLogEntity>> getEventLogsOrder(String orderId);
}

class TrackingUseCaseImpl extends TrackingUseCase {
  final TrackingRepository _trackingRepository;

  TrackingUseCaseImpl(this._trackingRepository);

  @override
  Future<List<EventLogEntity>> getEventLogsOrder(String orderId) async {
    final List<EventLogEntity> eventLogs = await _trackingRepository.getEventLogsOrder(orderId);
    final List<EventLogEntity> reversedEventLogs = eventLogs.reversed.toList();
    return reversedEventLogs;
  }
}
