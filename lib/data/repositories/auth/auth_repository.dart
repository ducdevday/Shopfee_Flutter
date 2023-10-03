import 'package:shopfee/data/base/base_service.dart';
import 'package:shopfee/data/models/user.dart';
import 'package:shopfee/data/repositories/auth/base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository{
  @override
  Future<bool> register(User user) async{
    Map<String, dynamic> body = {
      "email": user.email,
      "password": user.password,
      "firstName": user.firstName,
      "lastName": user.lastName
    };
    print(body);
    var response = await dio.post("${BaseService.authPath}/register", data: body);
    print(response.data);
    if(response.statusCode! >= 200 &&  response.statusCode! < 300){
      return true;
    }
    return false;
  }
}