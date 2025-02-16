import 'package:enmaa/features/authentication_module/domain/entities/sign_up_request_entity.dart';

import '../../../../core/constants/json_keys.dart';

class SignUpRequestModel extends SignUpRequestEntity{


  const SignUpRequestModel({
    required super.password,
    required super.name,
    required super.phone,
  }) ;

  Map<String, dynamic> toJson() {
    return {
      JsonKeys.password: password,
      JsonKeys.passwordConfirm: password,
      JsonKeys.fullName: name,
      JsonKeys.phoneNumber: phone,
    };
  }
}