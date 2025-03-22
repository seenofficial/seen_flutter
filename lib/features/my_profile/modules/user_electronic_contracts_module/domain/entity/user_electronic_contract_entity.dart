import 'package:equatable/equatable.dart';

class UserElectronicContractEntity extends Equatable {
  final int id;
  final String contractUrl;

  const UserElectronicContractEntity({
    required this.id,
     required this.contractUrl,
  });

  @override
  List<Object> get props => [id, contractUrl];
}
