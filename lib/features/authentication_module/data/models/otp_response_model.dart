import 'package:enmaa/core/constants/json_keys.dart';
import 'package:enmaa/features/authentication_module/domain/entities/otp_response_entity.dart';

class OTPResponseModel extends OTPResponseEntity{
  const OTPResponseModel({
    required super.phoneNumber,
    required super.expiresAt,
    required super.otpCode,
  });

  factory OTPResponseModel.fromJson(Map<String, dynamic> json) {
    return OTPResponseModel(
      phoneNumber: json[JsonKeys.phoneNumber],
      expiresAt: json[JsonKeys.expiresAt],
      otpCode: json[JsonKeys.code],
    );
  }


}