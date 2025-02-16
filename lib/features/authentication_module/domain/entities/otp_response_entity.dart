import 'package:equatable/equatable.dart';

class OTPResponseEntity extends Equatable {
  final String phoneNumber , expiresAt , otpCode;

  const OTPResponseEntity({
    required this.phoneNumber,
    required this.expiresAt,
    required this.otpCode,
  });

  @override
  List<Object?> get props => [
    phoneNumber,
    expiresAt,
    otpCode,
  ];

}