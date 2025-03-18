import 'package:enmaa/features/wallet/domain/entities/wallet_data_entity.dart';

class WalletDataModel extends WalletDataEntity {
  const WalletDataModel({
    required super.currentBalance,
    required super.totalBalance,
    required super.pendingBalance,
  });

  factory WalletDataModel.fromJson(Map<String, dynamic> json) {
    return WalletDataModel(
      currentBalance: json['available_balance']??'',
      totalBalance: json['totalBalance']??'',
      pendingBalance: json['frozen_balance']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentBalance': currentBalance,
      'totalBalance': totalBalance,
      'pendingBalance': pendingBalance,
    };
  }
}