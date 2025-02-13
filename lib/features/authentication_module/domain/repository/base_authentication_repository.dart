import 'package:dartz/dartz.dart';
import 'package:enmaa/features/authentication_module/domain/entities/login_request_entity.dart';
import '../../../../core/errors/failure.dart';


abstract class BaseAuthenticationRepository {
  Future<Either<Failure, bool>> loginUsingLocalAuthentication();
  Future<Either<Failure, String>> remoteLogin(LoginRequestEntity loginBody);
}