import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:shopfee/features/no_network/presentation/no_network.dart';

class ExceptionUtil {
  static void handle(e) {
    print(e.toString());
    EasyLoading.dismiss();
    if(e is DioException){
      if (e.type == DioExceptionType.connectionError) {
        NavigationUtil.push(const NoNetWorkPage());
      }
      else{
        EasyLoading.showError("Something went wrong. Please try again!");
      }
    }
    else if(e is AppException){
      EasyLoading.showError(e.message ?? "Something went wrong. Please try again!");
    }
    else{
      EasyLoading.showError("Something went wrong. Please try again!");
    }
  }
}