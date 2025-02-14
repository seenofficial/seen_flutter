import 'dart:async';
import 'package:enmaa/core/services/dio_service.dart';
import 'package:enmaa/features/authentication_module/domain/entities/login_request_entity.dart';

abstract class BaseAuthenticationRemoteDataSource {
  Future<String> remoteLogin(LoginRequestEntity loginBody);
  Future<String> sendOtp(String phoneNumber);
  Future<bool> verifyOtp(String otp);
}

class AuthenticationRemoteDataSource extends BaseAuthenticationRemoteDataSource {
  DioService dioService;

  AuthenticationRemoteDataSource({required this.dioService});

  @override
  Future<String> remoteLogin(LoginRequestEntity loginBody) async {
    await Future.delayed(const Duration(seconds: 2));

    if(loginBody.password != '1212'){
      throw Exception('Invalid password');
    }

    return '{"token": "fake_jwt_token_123456"}';
  }

  @override
  Future<String> sendOtp(String phoneNumber) async{
    await Future.delayed(const Duration(seconds: 2));

    //throw Exception('Invalid phone number');


    return '123456';
  }

  @override
  Future<bool> verifyOtp(String otp) async{
    await Future.delayed(const Duration(seconds: 2));

    if(otp != '123456'){
      throw Exception('Invalid OTP');
    }

    return true;
  }
}
