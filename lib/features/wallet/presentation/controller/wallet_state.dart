part of 'wallet_cubit.dart';

class WalletState extends Equatable {
  const WalletState({
    this.walletDataEntity,
    this.getWalletDataState = RequestState.initial,
    this.getWalletDataErrorMessage = '',
    this.transactions = const [],
    this.getTransactionHistoryDataState = RequestState.initial,
    this.getTransactionHistoryDataErrorMessage = '',
    this.withdrawRequestState = RequestState.initial,
    this.withdrawRequestErrorMessage = '',
  });

  final WalletDataEntity? walletDataEntity;
  final RequestState getWalletDataState;
  final String getWalletDataErrorMessage;

  final List<TransactionHistoryEntity> transactions;
  final RequestState getTransactionHistoryDataState;
  final String getTransactionHistoryDataErrorMessage;

  final RequestState withdrawRequestState;
  final String withdrawRequestErrorMessage;
  WalletState copyWith(
      {WalletDataEntity? walletDataEntity,
      RequestState? getWalletDataState,
      String? getWalletDataErrorMessage,
      List<TransactionHistoryEntity>? transactions,
      RequestState? getTransactionHistoryDataState,
      String? getTransactionHistoryDataErrorMessage,
      RequestState? withdrawRequestState,
      String? withdrawRequestErrorMessage}) {
    return WalletState(
        walletDataEntity: walletDataEntity ?? this.walletDataEntity,
        getWalletDataState: getWalletDataState ?? this.getWalletDataState,
        getWalletDataErrorMessage:
            getWalletDataErrorMessage ?? this.getWalletDataErrorMessage,
        transactions: transactions ?? this.transactions,
        getTransactionHistoryDataState: getTransactionHistoryDataState ??
            this.getTransactionHistoryDataState,
        getTransactionHistoryDataErrorMessage:
            getTransactionHistoryDataErrorMessage ??
                this.getTransactionHistoryDataErrorMessage,
        withdrawRequestState: withdrawRequestState ?? this.withdrawRequestState,
        withdrawRequestErrorMessage:
            withdrawRequestErrorMessage ?? this.withdrawRequestErrorMessage);
  }

  @override
  List<Object?> get props => [
        walletDataEntity,
        getWalletDataState,
        getWalletDataErrorMessage,
        transactions,
        getTransactionHistoryDataState,
        getTransactionHistoryDataErrorMessage,
        withdrawRequestState,
        withdrawRequestErrorMessage,
      ];
}
