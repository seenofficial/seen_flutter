import 'package:dartz/dartz.dart';
import 'package:enmaa/features/wallet/data/data_source/wallet_remote_data_source.dart';
import 'package:enmaa/features/wallet/domain/entities/transaction_history_entity.dart';
import 'package:enmaa/features/wallet/domain/entities/wallet_data_entity.dart';
import 'package:enmaa/features/wallet/domain/repository/base_wallet_repository.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/services/handle_api_request_service.dart';


class WalletRepository extends BaseWalletRepository {
  final BaseWalletRemoteDataSource baseWalletRemoteDataSource;

  WalletRepository({required this.baseWalletRemoteDataSource});





  @override
  Future<Either<Failure, WalletDataEntity>> getWalletData() async{
    return  await HandleRequestService.handleApiCall<WalletDataEntity>(() async {
      return await baseWalletRemoteDataSource.getWalletData(  );
    });
  }

  @override
  Future<Either<Failure, List<TransactionHistoryEntity>>> getTransactionHistoryData()async {
    return  await HandleRequestService.handleApiCall<List<TransactionHistoryEntity>>(() async {
      return await baseWalletRemoteDataSource.getTransactionHistoryData(  );
    });
  }
}
