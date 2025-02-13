import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/bio_metric_service.dart';
import '../../domain/use_cases/login_using_local_authentication.dart';
import 'biometric_event.dart';
import 'biometric_state.dart';

class BiometricBloc extends Bloc<BiometricEvent, BiometricState> {
  final LoginUsingLocalAuthentication loginUsingLocalAuthentication;

  BiometricBloc(this.loginUsingLocalAuthentication)
      : super(BiometricInitial()) {
    on<AuthenticateWithBiometrics>(_onAuthenticate);
  }

  Future<void> _onAuthenticate(
      AuthenticateWithBiometrics event, Emitter<BiometricState> emit) async {
    emit(BiometricLoading());

    final result = await loginUsingLocalAuthentication();

    print("SJSJSJ ${result}");;
    result.fold(
          (failure) {
        if (failure.message == 'No security credentials available.') {
          emit(BiometricNotAvailable());
        } else {
          emit(BiometricFailure());
        }
      },
          (isAuthenticated) {
        if (isAuthenticated) {
          emit(BiometricSuccess());
        } else {
          emit(BiometricFailure());
        }
      },
    );
  }
}