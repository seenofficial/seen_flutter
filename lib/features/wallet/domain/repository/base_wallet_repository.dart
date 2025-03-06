import 'package:dartz/dartz.dart';
import 'package:enmaa/features/wallet/domain/entities/transaction_history_entity.dart';
import 'package:enmaa/features/wallet/domain/entities/wallet_data_entity.dart';
import '../../../../core/errors/failure.dart';



abstract class BaseWalletRepository {

  Future<Either<Failure,WalletDataEntity>> getWalletData();
  Future<Either<Failure,List<TransactionHistoryEntity>>> getTransactionHistoryData();



}