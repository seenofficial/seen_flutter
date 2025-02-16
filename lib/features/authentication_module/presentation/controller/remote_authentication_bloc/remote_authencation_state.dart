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
    currentCountryCode, // Add currentCountryCode to props
  ];
}