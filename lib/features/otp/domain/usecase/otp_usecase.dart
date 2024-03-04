import 'package:shopfee/core/common/models/my_token.dart';
import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/features/otp/domain/repositories/otp_repository.dart';
import 'package:shopfee/features/register/domain/entities/register_entity.dart';

abstract class OtpUseCase {
  Future<void> verifyOtp(String email, String otpString);

  Future<void> sendOtp(String email,String fromRoute);

  Future<MyToken> register(RegisterEntity registerEntity);
}

class OtpUseCaseImpl extends OtpUseCase {
  final OtpRepository _otpRepository;

  OtpUseCaseImpl(this._otpRepository);

  @override
  Future<void> sendOtp(String email, String fromRoute) async {
    _otpRepository.sendOtp(email, fromRoute);
  }

  @override
  Future<void> verifyOtp(String email, String otpString) async {
    _otpRepository.verifyOtp(email, otpString);
  }

  @override
  Future<MyToken> register(RegisterEntity registerEntity) async {
    return _otpRepository.register(registerEntity);
  }
}
