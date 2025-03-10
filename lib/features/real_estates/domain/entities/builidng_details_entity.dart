import 'package:enmaa/core/entites/amenity_entity.dart';
import 'package:enmaa/core/entites/image_entity.dart';
 import 'package:enmaa/features/real_estates/domain/entities/property_details_entity.dart';
import 'package:equatable/equatable.dart';

class BuildingDetailsEntity extends BasePropertyDetailsEntity {
  final int numberOfFloors;
  final String usageType;

  const BuildingDetailsEntity({
    required super.id,
    required super.title,
    required super.operation,
    required super.price,
    required super.area,
    required super.propertySubType,
    required super.status,
    required super.images,
    required super.amenities,
    required super.description,
    required super.latitude,
    required super.longitude,
    required super.city,
    required super.state,
    required super.country,
    required super.isInWishlist,
    required super.rentIsRenewable, required super.monthlyRentPeriod,
    required this.numberOfFloors,
    required this.usageType,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    numberOfFloors,
    usageType,
  ];
}