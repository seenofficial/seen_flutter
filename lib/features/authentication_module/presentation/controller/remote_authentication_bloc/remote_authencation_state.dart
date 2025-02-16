part of 'remote_authentication_cubit.dart';

class RemoteAuthenticationState extends Equatable {
  const RemoteAuthenticationState({
    this.loginRequestState = RequestState.initial,
    this.loginErrorMessage = '',
    this.loginToken = '',
    this.loginPasswordVisibility = false,
    this.userPhoneNumber = '',
    this.sendOtpRequestState = RequestState.initial,
    this.sendOtpErrorMessage = '',
    this.currentOTP = '',
    this.verifyOtpRequestState = RequestState.initial,
    this.isOtpVerified = false,
    this.verifyOtpErrorMessage = '',
    this.currentCountryCode =  '+20',
    this.createNewPasswordPasswordVisibility1 =  false,
    this.createNewPasswordPasswordVisibility2 =  false,
  });

  final RequestState loginRequestState;
  final String loginErrorMessage;
  final String loginToken;

  final String userPhoneNumber;
  final String currentOTP;
  final RequestState sendOtpRequestState;
  final String sendOtpErrorMessage;

  final RequestState verifyOtpRequestState;
  final bool isOtpVerified;
  final String verifyOtpErrorMessage;

  final bool loginPasswordVisibility;
  final bool createNewPasswordPasswordVisibility1;
  final bool createNewPasswordPasswordVisibility2;

  final String currentCountryCode;

  RemoteAuthenticationState copyWith({
    RequestState? loginRequestState,
    String? loginErrorMessage,
    String? loginToken,
    bool? loginPasswordVisibility,
    String? userPhoneNumber,
    RequestState? sendOtpRequestState,
    String? sendOtpErrorMessage,
    String? currentOTP,
    RequestState? verifyOtpRequestState,
    bool? isOtpVerified,
    String? verifyOtpErrorMessage,
    String? currentCountryCode,
    bool? createNewPasswordPasswordVisibility1,
    bool? createNewPasswordPasswordVisibility2,
  }) {
    return RemoteAuthenticationState(
      loginRequestState: loginRequestState ?? this.loginRequestState,
      loginErrorMessage: loginErrorMessage ?? this.loginErrorMessage,
      loginToken: loginToken ?? this.loginToken,
      loginPasswordVisibility:
      loginPasswordVisibility ?? this.loginPasswordVisibility,
      userPhoneNumber: userPhoneNumber ?? this.userPhoneNumber,
      sendOtpRequestState: sendOtpRequestState ?? this.sendOtpRequestState,
      sendOtpErrorMessage: sendOtpErrorMessage ?? this.sendOtpErrorMessage,
      currentOTP: currentOTP ?? this.currentOTP,
      verifyOtpRequestState: verifyOtpRequestState ?? this.verifyOtpRequestState,
      isOtpVerified: isOtpVerified ?? this.isOtpVerified,
      verifyOtpErrorMessage: verifyOtpErrorMessage ?? this.verifyOtpErrorMessage,
      currentCountryCode: currentCountryCode ?? this.currentCountryCode,
      createNewPasswordPasswordVisibility1: createNewPasswordPasswordVisibility1 ?? this.createNewPasswordPasswordVisibility1,
      createNewPasswordPasswordVisibility2: createNewPasswordPasswordVisibility2 ?? this.createNewPasswordPasswordVisibility2,
    );
  }

  @override
  List<Object?> get props => [
    loginRequestState,
    loginErrorMessage,
    loginToken,
    loginPasswordVisibility,
    userPhoneNumber,
    sendOtpRequestState,
    sendOtpErrorMessage,
    currentOTP,
    verifyOtpRequestState,
    isOtpVerified,
    verifyOtpErrorMessage,
    currentCountryCode,
    createNewPasswordPasswordVisibility1,
    createNewPasswordPasswordVisibility2,
  ];
}