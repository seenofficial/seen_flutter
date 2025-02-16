import 'package:equatable/equatable.dart';

class SignUpRequestEntity extends Equatable{
  final String phone,name,password;


  const SignUpRequestEntity({
    required this.phone,
    required this.name,
    required this.password,
  });

  @override
  List<Object?> get props => [phone, name , password];
}