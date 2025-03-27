import 'package:bloc/bloc.dart';
import 'package:enmaa/core/utils/enums.dart';
import 'package:enmaa/features/wallet/data/models/withdraw_request_model.dart';
import 'package:enmaa/features/wallet/domain/entities/transaction_history_entity.dart';
import 'package:enmaa/features/wallet/domain/use_cases/get_transaction_history_data_use_case.dart';
import 'package:enmaa/features/wallet/domain/use_cases/get_wallet_data_use_case.dart';
import 'package:enmaa/features/wallet/domain/use_cases/withdraw_request_use_case.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/wallet_data_entity.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit(
      this._withdrawRequestUseCase ,
      this._getWalletDataUseCase ,
      this._getTransactionHistoryDataUseCase) : super(WalletState());

  final GetWalletDataUseCase _getWalletDataUseCase;
  final GetTransactionHistoryDataUseCase _getTransactionHistoryDataUseCase;
  final WithdrawRequestUseCase _withdrawRequestUseCase ;

  void getWalletData() async {
    emit(state.copyWith(getWalletDataState: RequestState.loading));
    final result = await _getWalletDataUseCase();
    result.fold(
          (failure) =>
          emit(state.copyWith(getWalletDataState: RequestState.error,
              getWalletDataErrorMessage: failure.message)),
          (data) =>
          emit(state.copyWith(
              getWalletDataState: RequestState.loaded, walletDataEntity: data)),
    );
  }

  void getTransactionHistoryData() async {
    emit(state.copyWith(getTransactionHistoryDataState: RequestState.loading));
    final result = await _getTransactionHistoryDataUseCase();
    result.fold(
          (failure) =>
          emit(state.copyWith(getTransactionHistoryDataState: RequestState.error,
              getTransactionHistoryDataErrorMessage: failure.message)),
          (data) =>
          emit(state.copyWith(
              getTransactionHistoryDataState: RequestState.loaded, transactions: data)),
    );
  }


  void withdrawRequest(WithDrawRequestModel withDrawRequestModel) async {
    emit(state.copyWith(withdrawRequestState: RequestState.loading));
    final result = await _withdrawRequestUseCase(withDrawRequestModel);
    result.fold(
          (failure) =>
          emit(state.copyWith(getTransactionHistoryDataState: RequestState.error,
              withdrawRequestErrorMessage: failure.message)),
          (data) =>
          emit(state.copyWith(
              withdrawRequestState: RequestState.loaded)),
    );
  }

}
