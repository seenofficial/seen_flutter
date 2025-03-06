import 'dart:async';
 import 'package:enmaa/core/services/dio_service.dart';
import 'package:enmaa/features/wallet/data/models/transaction_history_model.dart';
import 'package:enmaa/features/wallet/data/models/wallet_data_model.dart';




abstract class BaseWalletRemoteDataSource {



  Future<WalletDataModel> getWalletData( );
  Future<List<TransactionHistoryModel>> getTransactionHistoryData( );

}

class WalletRemoteDataSource extends BaseWalletRemoteDataSource {
  DioService dioService;

  WalletRemoteDataSource({required this.dioService});



  @override
  Future<WalletDataModel> getWalletData() async{


    await Future.delayed(Duration(seconds: 2));
    return  WalletDataModel(currentBalance: '10000', totalBalance: '20000', pendingBalance: '10000');
  }

  @override
  Future<List<TransactionHistoryModel>> getTransactionHistoryData() async {
    await Future.delayed(Duration(seconds: 4));

    List<TransactionHistoryModel> fakeData = [
      TransactionHistoryModel(
        id: "1",
        title: "Salary Deposit",
        amount: "5000.00",
        date: "2025-03-01",
      ),
      TransactionHistoryModel(
        id: "2",
        title: "Online Purchase",
        amount: "-150.00",
        date: "2025-03-02",
      ),
      TransactionHistoryModel(
        id: "3",
        title: "Utility Bill Payment",
        amount: "-200.00",
        date: "2025-03-03",
      ),
    ];

    return fakeData;
  }





}
