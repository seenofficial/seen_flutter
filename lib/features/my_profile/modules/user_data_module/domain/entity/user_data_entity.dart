import 'package:enmaa/core/services/select_location_service/domain/entities/city_entity.dart';
import 'package:enmaa/core/services/select_location_service/domain/entities/country_entity.dart';
import 'package:enmaa/core/services/select_location_service/domain/entities/state_entity.dart';
import 'package:equatable/equatable.dart';

class UserDataEntity extends Equatable {
  final String phoneNumber;
  final String userName;
  final CityEntity? city;
  final StateEntity? state;
  final CountryEntity? country ;
  final bool notificationEnabled;
  final String availableBalance;
  final String frozenBalance;
  final String? idNumber;
  final String? dateOfBirth;
  final String? idExpirationDate;


  const UserDataEntity({
    required this.phoneNumber,
    required this.userName,
    this.city,
    this.state,
    this.country,
    required this.notificationEnabled,
    required this.availableBalance,
    required this.frozenBalance,
    this.idNumber,
    this.dateOfBirth,
    this.idExpirationDate,

  });

  @override
  List<Object?> get props => [
    phoneNumber,
    userName,
    city,
    state,
    notificationEnabled,
    availableBalance,
    frozenBalance,
    idNumber,
    dateOfBirth,
    idExpirationDate,

  ];
}