import '../../../../core/services/select_location_service/data/models/country_model.dart';
import '../../domain/entities/withdraw_request_entity.dart';

class WithDrawRequestModel extends WithdrawRequestEntity{
  const WithDrawRequestModel({
    required super.userName,
    required super.IBANNumber,
    required super.bankName,
    required super.country,
  });

  factory WithDrawRequestModel.fromJson(Map<String, dynamic> json) {
    return WithDrawRequestModel(
      userName: json['userName'],
      IBANNumber: json['IBANNumber'],
      bankName: json['bankName'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'IBANNumber': IBANNumber,
      'bankName': bankName,
      'country': country ,
    };
  }
}