import 'package:enmaa/core/entites/amenity_entity.dart';
import 'package:enmaa/core/entites/image_entity.dart';
import 'package:enmaa/features/real_estates/domain/entities/property_details_entity.dart';
import 'package:equatable/equatable.dart';

class ApartmentDetailsEntity extends BasePropertyDetailsEntity {
  final int floor;
  final int rooms;
  final int bathrooms;
  final bool isFurnished;
  final String usageType;

  const ApartmentDetailsEntity({
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
    required this.floor,
    required this.rooms,
    required this.bathrooms,
    required this.isFurnished,
    required this.usageType,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    floor,
    rooms,
    bathrooms,
    isFurnished,
    usageType,
  ];
}