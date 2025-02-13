part of 'remote_authentication_cubit.dart';

class RemoteAuthenticationState extends Equatable {
  const RemoteAuthenticationState({
    this.loginRequestState = RequestState.initial,
    this.loginErrorMessage = '',
    this.loginToken = '',
    this.loginPasswordVisibility = false,
  });


  final RequestState loginRequestState;
  final String loginErrorMessage;
  final String loginToken;


  final bool loginPasswordVisibility;


  RemoteAuthenticationState copyWith({
    RequestState? loginRequestState,
    String? loginErrorMessage,
    String? loginToken,
    bool? loginPasswordVisibility,
  }) {
    return RemoteAuthenticationState(
      loginRequestState: loginRequestState ?? this.loginRequestState,
      loginErrorMessage: loginErrorMessage ?? this.loginErrorMessage,
      loginToken: loginToken ?? this.loginToken,
      loginPasswordVisibility: loginPasswordVisibility ?? this.loginPasswordVisibility,
    );
  }

  @override
  List<Object?> get props => [loginRequestState, loginErrorMessage, loginToken ,loginPasswordVisibility];
}
