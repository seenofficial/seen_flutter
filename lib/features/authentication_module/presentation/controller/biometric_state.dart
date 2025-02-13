import 'package:equatable/equatable.dart';

abstract class BiometricState extends Equatable {
  @override
  List<Object> get props => [];
}

class BiometricInitial extends BiometricState {}

class BiometricLoading extends BiometricState {}

class BiometricSuccess extends BiometricState {}

class BiometricFailure extends BiometricState {}
class BiometricNotAvailable extends BiometricState {}
