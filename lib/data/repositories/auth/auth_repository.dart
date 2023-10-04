import 'package:shopfee/data/base/base_service.dart';
import 'package:shopfee/data/models/user.dart';
import 'package:shopfee/data/repositories/auth/auth_repository_base.dart';

class AuthRepository extends AuthRepositoryBase{
  @override
  Future<bool> register(User user) async{
    Map<String, dynamic> body = {
      "email": user.email,
      "password": user.password,
      "firstName": user.firstName,
      "lastName": user.lastName
    };
    var response = await dio.post("${BaseService.authPath}/register", data: body);
    print(response.data);
    if(response.statusCode! >= 200 &&  response.statusCode! < 300){
      return true;
    }
    return false;
  }

  @override
  Future<bool> sendCode(String email) async{
    Map<String, dynamic> body = {
      "email": email,
    };
    var response = await dio.post("${BaseService.authPath}/register/send-code", data: body);
    print(response.data);
    if(response.statusCode! >= 200 &&  response.statusCode! < 300){
      return true;
    }
    return false;
  }

  @override
  Future<bool> verifyCode(String email, String code) async{
    Map<String, dynamic> body = {
      "email": email,
      "code": code,
    };
    try{
      var response = await dio.post("${BaseService.authPath}/verify", data: body);
      print(response.data);
      if(response.statusCode! >= 200 &&  response.statusCode! < 300){
        return true;
      }
      return false;
    }
    catch(e){
      return false;
    }
  }
}