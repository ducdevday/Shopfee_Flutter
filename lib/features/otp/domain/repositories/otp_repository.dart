import 'package:shopfee/core/common/models/my_token.dart';
import 'package:shopfee/features/register/domain/entities/register_entity.dart';

abstract class OtpRepository {
  Future<void> verifyOtp(String email, String otpString);
  Future<void> sendOtp(String email, String fromRoute);
  Future<MyToken> register(RegisterEntity registerEntity);
}