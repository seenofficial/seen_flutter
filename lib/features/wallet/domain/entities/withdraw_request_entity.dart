import 'package:equatable/equatable.dart';
import '../../../../core/services/select_location_service/domain/entities/country_entity.dart';

class WithdrawRequestEntity extends Equatable{
 final String userName , IBANNumber , bankName ;
 final String country ;

  const WithdrawRequestEntity({
    required this.userName,
    required this.IBANNumber,
    required this.bankName,
    required this.country,
  });

  @override
  List<Object?> get props => [
    userName,
    IBANNumber,
    bankName,
    country,
  ];



}