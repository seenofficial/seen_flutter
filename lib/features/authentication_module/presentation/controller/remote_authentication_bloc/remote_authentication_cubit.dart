import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:enmaa/core/utils/enums.dart';
import 'package:enmaa/features/authentication_module/domain/use_cases/remote_login_use_case.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../domain/entities/login_request_entity.dart';

part 'remote_authencation_state.dart';

class RemoteAuthenticationCubit extends Cubit<RemoteAuthenticationState> {
  final RemoteLoginUseCase _remoteLoginUseCase;

  RemoteAuthenticationCubit(this._remoteLoginUseCase)
      : super(const RemoteAuthenticationState());


  void changeLoginPasswordVisibility() {
    emit(state.copyWith(loginPasswordVisibility: !state.loginPasswordVisibility));
  }

  Future<void> remoteLogin(LoginRequestEntity loginBody) async {
    emit(state.copyWith(loginRequestState: RequestState.loading));

    final Either<Failure, String> result = await _remoteLoginUseCase(loginBody);

    result.fold(
          (failure) => emit(state.copyWith(
              loginRequestState: RequestState.error, loginErrorMessage: failure.message)),
          (token) => emit(state.copyWith(
              loginRequestState: RequestState.loaded, loginToken: token)),
    );
  }
}
