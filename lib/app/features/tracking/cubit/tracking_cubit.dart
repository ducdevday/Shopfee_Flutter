import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/data/models/event_log.dart';
import 'package:shopfee/data/repositories/order/order_repository.dart';

part 'tracking_state.dart';

class TrackingCubit extends Cubit<TrackingState> {
  final OrderRepository orderRepository;
  TrackingCubit({required this.orderRepository}) : super(TrackingInitial());

  void loadTracking(String orderId) async{
    emit(TrackingLoading());
    try{
      EasyLoading.show();
      var response = await orderRepository.getStatusOrder(orderId);
      EasyLoading.dismiss();
      if(response.success){
        List<EventLog> eventLogs = response.data!.map((log) => EventLog.fromJson(log)).toList();
        emit(TrackingLoaded(eventlogs: eventLogs));
      }
      else{
        emit(TrackingError());
      }
    }
    catch(e){
      print(e);
      emit(TrackingError());
    }
  }
}
