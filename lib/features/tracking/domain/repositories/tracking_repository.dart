import 'package:shopfee/features/receipt/domain/entities/event_log_entity.dart';

abstract class TrackingRepository {
  Future<List<EventLogEntity>> getEventLogsOrder(String orderId);
}