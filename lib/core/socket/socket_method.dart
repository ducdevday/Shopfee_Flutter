import 'package:socket_io_client/socket_io_client.dart';

import 'socket_client.dart';

class SocketMethod {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;

  //! emitter
  void joinUser({required String userId}) {
    _socketClient.emit(
      'joinUser',
      userId,
    );
  }

  void createOrder({required String branchId,required String orderId}){
    _socketClient.emit(
      'user_create_order',
      {
        "branchId": branchId,
        "orderId": orderId
      }
    );
  }

  void updateOrder({required String branchId,required String orderId}){
    _socketClient.emit(
        'user_update_order',
        {
          "branchId": branchId,
          "orderId": orderId
        }
    );
  }

  //! listeners
  void employeeUpdateOrderListener(Function(dynamic) callback) {
    _socketClient.on('employee_update_order', (data) {
      callback(data);
    });
  }
}
