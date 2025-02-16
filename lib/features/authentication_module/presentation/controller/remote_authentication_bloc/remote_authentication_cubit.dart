import 'package:bloc/bloc.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dartz/dartz.dart';
import 'package:enmaa/core/utils/enums.dart';
import 'package:enmaa/features/authentication_module/domain/use_cases/remote_login_use_case.dart';
import 'package:enmaa/features/authentication_module/domain/use_cases/send_otp_use_case.dart';
import 'package:enmaa/features/authentication_module/domain/use_cases/verify_otp_use_case.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../domain/entities/login_request_entity.dart';

part 'remote_authencation_state.dart';

class RemoteAuthenticationCubit extends Cubit<RemoteAuthenticationState> {
  final RemoteLoginUseCase _remoteLoginUseCase;
  final SendOtpUseCase _sendOtpUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;

  RemoteAuthenticationCubit(this._remoteLoginUseCase , this._sendOtpUseCase , this._verifyOtpUseCase)
      : super(const RemoteAuthenticationState());


  void changeLoginPasswordVisibility() {
    emit(state.copyWith(loginPasswordVisibility: !state.loginPasswordVisibility));
  }
  void changeCreateNewPasswordVisibility1() {
    emit(state.copyWith(createNewPasswordPasswordVisibility1: !state.createNewPasswordPasswordVisibility1));
  }
  void changeCreateNewPasswordVisibility2() {
    emit(state.copyWith(createNewPasswordPasswordVisibility2: !state.createNewPasswordPasswordVisibility2));
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

  Future<void> sendOtp(String phoneNumber) async {
    emit(state.copyWith(sendOtpRequestState: RequestState.loading));

    final Either<Failure, String> result = await _sendOtpUseCase(phoneNumber);

    result.fold(
          (failure) => emit(state.copyWith(
              sendOtpRequestState: RequestState.error, sendOtpErrorMessage: failure.message)),
          (otp) => emit(state.copyWith(currentOTP: otp,
              sendOtpRequestState: RequestState.loaded, userPhoneNumber: phoneNumber)),
    );
  }
  Future<void> verifyOtp(String otp) async {
    emit(state.copyWith(verifyOtpRequestState: RequestState.loading));

    final Either<Failure, bool> result = await _verifyOtpUseCase(otp);

    result.fold(
          (failure) => emit(state.copyWith(
              verifyOtpRequestState: RequestState.error, sendOtpErrorMessage: failure.message)),
          (isVerified) => emit(state.copyWith(currentOTP: otp,
              verifyOtpRequestState: RequestState.loaded, isOtpVerified: isVerified)),
    );
  }

  Future<void> setCountryCode(String countyCode) async {
    emit(state.copyWith(currentCountryCode: countyCode));
  }
}
