import 'dart:async';
import 'package:enmaa/core/services/dio_service.dart';
import 'package:enmaa/features/authentication_module/data/models/otp_response_model.dart';
import 'package:enmaa/features/authentication_module/domain/entities/login_request_entity.dart';
import 'package:enmaa/features/authentication_module/domain/entities/sign_up_request_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/constants/json_keys.dart';
import '../../models/login_request_model.dart';
import '../../models/sign_up_request_model.dart';

abstract class BaseAuthenticationRemoteDataSource {
  Future<String> remoteLogin(LoginRequestModel loginBody);
  Future<String> signUp(SignUpRequestModel signUpBody);
  Future<OTPResponseModel> sendOtp(String phoneNumber);
  Future<bool> verifyOtp(String otp, String phoneNumber);
}

class AuthenticationRemoteDataSource extends BaseAuthenticationRemoteDataSource {
  DioService dioService;

  AuthenticationRemoteDataSource({required this.dioService});


  @override
  Future<String> remoteLogin(LoginRequestModel loginBody) async {
    final response = await dioService.post(
      url: ApiConstants.login,
      data: loginBody.toJson(),
    );

    final token = response.data['access'];


    // Store token in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);

    return token;
  }


  @override
  Future<OTPResponseModel> sendOtp(String phoneNumber) async{
    final response = await dioService.post(
      url: ApiConstants.sendOTP,
      data: {
        JsonKeys.phoneNumber: phoneNumber,
      }
    );

    print('otpppp ${response.data}');

    return OTPResponseModel.fromJson(response.data);

  }

  @override
  Future<bool> verifyOtp(String otp , String phoneNumber) async{
    final response = await dioService.post(
        url: ApiConstants.verifyOTP,
        data: {
          JsonKeys.phoneNumber: phoneNumber,
          JsonKeys.code: otp,
        }
    );

    /// todo change it
    if('OTP verified successfully' == response.data['message']){
      return true;
    }

    return false;
  }

  @override
  Future<String> signUp(SignUpRequestModel signUpBody) async{
    final response = await dioService.post(
        url: ApiConstants.signUp,
        data: signUpBody.toJson()
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', response.data['access_token']);

    return response.data['access_token'];
  }
}
