 import 'package:enmaa/features/real_estates/domain/entities/property_details_entity.dart';

class VillaDetailsEntity extends BasePropertyDetailsEntity {
  final bool isFurnished;
  final int numberOfFloors;
  final int rooms;
  final int bathrooms;

  const VillaDetailsEntity({
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

    required this.isFurnished,
    required this.numberOfFloors,
    required this.rooms,
    required this.bathrooms,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    isFurnished,
    numberOfFloors,
    rooms,
    bathrooms,
  ];
}