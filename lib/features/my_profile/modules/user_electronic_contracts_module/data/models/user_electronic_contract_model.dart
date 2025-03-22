import '../../domain/entity/user_electronic_contract_entity.dart';

class UserElectronicContractModel extends UserElectronicContractEntity {
  const UserElectronicContractModel({
    required super.id,
    required super.contractUrl,
  }) ;

  factory UserElectronicContractModel.fromJson(Map<String, dynamic> json) {
    return UserElectronicContractModel(
      id: json['id'],
      contractUrl: json['contract_url'],
    );
  }

}