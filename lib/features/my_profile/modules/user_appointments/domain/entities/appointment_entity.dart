import 'package:equatable/equatable.dart';

class AppointmentEntity extends Equatable {
  final String id;
  final String date;
  final String time;
  final String propertyId;
  final String propertyType;
  final String propertyArea;
  final String propertyCity;
  final String propertyState;
  final String propertyCountry;
  final String orderStatus;

  const AppointmentEntity({
    required this.id,
    required this.date,
    required this.time,
    required this.propertyId,
    required this.propertyType,
    required this.propertyArea,
    required this.propertyCity,
    required this.propertyState,
    required this.propertyCountry,
    required this.orderStatus,
  });

  @override
  List<Object> get props => [
    id,
    date,
    time,
    propertyId,
    propertyType,
    propertyArea,
    propertyCity,
    propertyState,
    propertyCountry,
    orderStatus,
  ];
}
