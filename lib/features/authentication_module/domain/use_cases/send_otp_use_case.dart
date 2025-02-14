import 'package:dartz/dartz.dart';
import 'package:enmaa/features/authentication_module/domain/entities/login_request_entity.dart';
import 'package:enmaa/features/authentication_module/domain/repository/base_authentication_repository.dart';
import '../../../../core/errors/failure.dart';

class SendOtpUseCase {
  final BaseAuthenticationRepository _baseAuthenticationRepository ;

  SendOtpUseCase(this._baseAuthenticationRepository);

  Future<Either<Failure, String>> call(String phoneNumber) =>
      _baseAuthenticationRepository.sendOtp(phoneNumber);
}