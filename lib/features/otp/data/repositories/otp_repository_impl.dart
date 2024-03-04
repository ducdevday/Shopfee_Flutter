import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shopfee/core/common/models/my_token.dart';
import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/features/otp/data/datasources/otp_service.dart';
import 'package:shopfee/features/otp/domain/repositories/otp_repository.dart';
import 'package:shopfee/features/register/data/models/register_model.dart';
import 'package:shopfee/features/register/domain/entities/register_entity.dart';
import 'package:shopfee/features/register/presentation/register.dart';

class OtpRepositoryImpl implements OtpRepository {
  final OtpService _otpService;

  OtpRepositoryImpl(this._otpService);

  @override
  Future<void> sendOtp(String email, String fromRoute) async {
    if (fromRoute == RegisterPage.route) {
      await _otpService.sendOtpToRegister(email);
    } else {
      await _otpService.sendOtpToChangePassword(email);
    }
  }

  @override
  Future<void> verifyOtp(String email, String otpString) async {
    final response = await _otpService.verifyOtp(email, otpString);
    if (response.statusCode! < 200 || response.statusCode! >= 300) {
      throw InvalidInputFailure(message: "OTP incorrect");
    }
  }

  @override
  Future<MyToken> register(RegisterEntity registerEntity) async {
    try {
      final response =
          await _otpService.register(RegisterModel.fromEntity(registerEntity));
      final result = Result(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"],
      );
      final token = MyToken.fromJson(result.data!);
      await _otpService.saveFCMToken(token.userId);
      return token;
    } catch (e) {
      throw ServerFailure(message: "Register Account Fail! Please try again");
    }
  }

}
