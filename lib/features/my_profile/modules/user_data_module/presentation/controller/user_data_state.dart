part of 'user_data_cubit.dart';

class UserDataState extends Equatable {
  const UserDataState({
    this.getUserDataState = RequestState.initial,
    this.userDataEntity,
    this.getUserDataErrorMessage = '',
  });

  final RequestState getUserDataState;
  final UserDataEntity? userDataEntity;
  final String getUserDataErrorMessage;

  UserDataState copyWith({
    RequestState? getUserDataState,
    UserDataEntity? userDataEntity,
    String? getUserDataErrorMessage,
  }) {
    return UserDataState(
      getUserDataState: getUserDataState ?? this.getUserDataState,
      userDataEntity: userDataEntity ?? this.userDataEntity,
      getUserDataErrorMessage:
          getUserDataErrorMessage ?? this.getUserDataErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
        getUserDataState,
        userDataEntity,
        getUserDataErrorMessage,
      ];
}
