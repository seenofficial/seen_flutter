import 'dart:async';
import 'package:enmaa/core/services/dio_service.dart';
import 'package:enmaa/features/authentication_module/domain/entities/login_request_entity.dart';

abstract class BaseAuthenticationRemoteDataSource {
  Future<String> remoteLogin(LoginRequestEntity loginBody);
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
}
