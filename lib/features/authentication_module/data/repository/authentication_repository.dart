
import 'package:dartz/dartz.dart';
import 'package:enmaa/features/authentication_module/data/data_source/local_data/authentication_local_data_source.dart';
import 'package:enmaa/features/authentication_module/data/data_source/remote_data/authentication_remote_data_source.dart';
import 'package:enmaa/features/authentication_module/domain/entities/login_request_entity.dart';
import 'package:enmaa/features/authentication_module/domain/repository/base_authentication_repository.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/services/handle_api_request_service.dart';



class AuthenticationRepository extends BaseAuthenticationRepository {
  final BaseAuthenticationRemoteDataSource baseAuthenticationRemoteDataSource;
  final BaseAuthenticationLocalDataSource baseAuthenticationLocalDataSource;

  AuthenticationRepository({ required this.baseAuthenticationRemoteDataSource , required this.baseAuthenticationLocalDataSource});


  @override
  Future<Either<Failure, bool>> loginUsingLocalAuthentication() async{
    return await HandleRequestService.handleLocalCall<bool>(() async {
      final result = await baseAuthenticationLocalDataSource.loginUsingLocalAuthentication();
      return result;
    });
  }

  @override
  Future<Either<Failure, String>> remoteLogin(LoginRequestEntity loginBody) async{
    return await HandleRequestService.handleApiCall<String>(() async {
      final result = await baseAuthenticationRemoteDataSource.remoteLogin(loginBody);
      return result;
    });
  }

  @override
  Future<Either<Failure, String>> sendOtp(String phoneNumber)async {
    return await HandleRequestService.handleApiCall<String>(() async {
      final result = await baseAuthenticationRemoteDataSource.sendOtp(phoneNumber);
      return result;
    });
  }

  @override
  Future<Either<Failure, bool>> verifyOtp(String otp)async {
    return await HandleRequestService.handleApiCall<bool>(() async {
      final result = await baseAuthenticationRemoteDataSource.verifyOtp(otp);
      return result;
    });
  }




}