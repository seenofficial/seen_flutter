import 'package:enmaa/features/wallet/domain/entities/wallet_data_entity.dart';

class WalletDataModel extends WalletDataEntity {
  const WalletDataModel({
    required String currentBalance,
    required String totalBalance,
    required String pendingBalance,
  }) : super(
          currentBalance: currentBalance,
          totalBalance: totalBalance,
          pendingBalance: pendingBalance,
        );

  factory WalletDataModel.fromJson(Map<String, dynamic> json) {
    return WalletDataModel(
      currentBalance: json['currentBalance'],
      totalBalance: json['totalBalance'],
      pendingBalance: json['pendingBalance'],
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