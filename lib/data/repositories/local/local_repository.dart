import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopfee/app/common/data/global_data.dart';
import 'package:shopfee/data/repositories/local/local_repository_base.dart';

class LocalRepository extends LocalRepositoryBase {
  @override
  Future<void> saveUser(
      String userId, String accessToken, String refreshToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    await prefs.setString('accessToken', accessToken);
    await prefs.setString('refreshToken', refreshToken);
    GlobalData.ins.userId = prefs.getString('userId');
    GlobalData.ins.accessToken = prefs.getString('accessToken');
    GlobalData.ins.refreshToken = prefs.getString('refreshToken');
  }

  @override
  Future<void> deleteUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
    GlobalData.ins.userId = null;
    GlobalData.ins.accessToken = null;
    GlobalData.ins.refreshToken = null;
  }
}
