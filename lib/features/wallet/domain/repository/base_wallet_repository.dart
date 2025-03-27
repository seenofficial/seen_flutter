import 'package:dartz/dartz.dart';
import 'package:enmaa/features/wallet/domain/entities/transaction_history_entity.dart';
import 'package:enmaa/features/wallet/domain/entities/wallet_data_entity.dart';
import '../../../../core/errors/failure.dart';
import '../../data/models/withdraw_request_model.dart';



abstract class BaseWalletRepository {

  Future<Either<Failure,WalletDataEntity>> getWalletData();
  Future<Either<Failure,List<TransactionHistoryEntity>>> getTransactionHistoryData();


  Future<Either<Failure,void>> withdrawRequest(WithDrawRequestModel withDrawRequestModel);





}