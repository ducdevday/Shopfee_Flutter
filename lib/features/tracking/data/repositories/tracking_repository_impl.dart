import 'package:shopfee/core/common/models/result_list.dart';
import 'package:shopfee/features/receipt/data/models/event_log_model.dart';
import 'package:shopfee/features/receipt/domain/entities/event_log_entity.dart';
import 'package:shopfee/features/tracking/data/datasources/tracking_service.dart';
import 'package:shopfee/features/tracking/domain/repositories/tracking_repository.dart';

class TrackingRepositoryImpl implements TrackingRepository {
  final TrackingService _trackingService;

  TrackingRepositoryImpl(this._trackingService);

  @override
  Future<List<EventLogEntity>> getEventLogsOrder(String orderId) async{
    final response = await _trackingService.getEventLogsOrder(orderId);
    final resultList = ResultList(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final eventListModel =
    resultList.data!.map((e) => EventLogModel.fromJson(e)).toList();
    List<EventLogEntity> eventListEntity =
    eventListModel.map((e) => EventLogEntity.fromModel(e)).toList();
    return eventListEntity;
  }
}
