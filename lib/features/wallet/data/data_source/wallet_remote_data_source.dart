import 'dart:async';
 import 'package:enmaa/core/services/dio_service.dart';
import 'package:enmaa/features/wallet/data/models/transaction_history_model.dart';
import 'package:enmaa/features/wallet/data/models/wallet_data_model.dart';

import '../../../../core/constants/api_constants.dart';
import '../models/withdraw_request_model.dart';




abstract class BaseWalletRemoteDataSource {



  Future<WalletDataModel> getWalletData( );
  Future<List<TransactionHistoryModel>> getTransactionHistoryData( );

  Future<void> withdrawRequest(WithDrawRequestModel withDrawRequestModel );

}

class WalletRemoteDataSource extends BaseWalletRemoteDataSource {
  DioService dioService;

  WalletRemoteDataSource({required this.dioService});



  @override
  Future<WalletDataModel> getWalletData() async{
    final response = await dioService.get(
      url: ApiConstants.user,
    );

    return WalletDataModel.fromJson(response.data);


  }

  @override
  Future<List<TransactionHistoryModel>> getTransactionHistoryData() async {

    final response = await dioService.get(
      url: '${ApiConstants.transactions}history/',
    );
    final List<dynamic> results = response.data['results'] ?? [];
    List<TransactionHistoryModel> transactions = results.map((json) {
      return TransactionHistoryModel.fromJson(json);
    }).toList();
    return transactions;
  }

  @override
  Future<void> withdrawRequest(WithDrawRequestModel withDrawRequestModel) async{

    await Future.delayed(Duration(seconds: 2));

  }





}
