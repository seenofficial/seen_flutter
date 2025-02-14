import 'package:dartz/dartz.dart';
import 'package:enmaa/features/authentication_module/domain/entities/login_request_entity.dart';
import '../../../../core/errors/failure.dart';


abstract class BaseAuthenticationRepository {
  // use biometric authentication to open app
  Future<Either<Failure, bool>> loginUsingLocalAuthentication();

  Future<Either<Failure, String>> remoteLogin(LoginRequestEntity loginBody);
  Future<Either<Failure, String>> sendOtp(String phoneNumber);
  Future<Either<Failure, bool>> verifyOtp(String otp);
}