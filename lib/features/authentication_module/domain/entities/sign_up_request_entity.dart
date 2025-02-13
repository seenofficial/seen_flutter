import 'package:equatable/equatable.dart';

class SignUpRequestEntity extends Equatable{
  final String phone;
  final String name;

  const SignUpRequestEntity({
    required this.phone,
    required this.name,
  });

  @override
  List<Object?> get props => [phone, name];
}