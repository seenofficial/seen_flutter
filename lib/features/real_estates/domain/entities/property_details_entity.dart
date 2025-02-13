import 'package:enmaa/core/entites/amenity_entity.dart';
import 'package:enmaa/core/entites/image_entity.dart';
import 'package:equatable/equatable.dart';

class PropertyDetailsEntity extends Equatable {
  final int id;
  final String title;
  final List<ImageEntity> images;
  final String category;
  final String propertyType;
  final String operation;
  final String price;
  final double area;
  final bool furnitureIncluded;
  final int floor;
  final int rooms;
  final int bathrooms;
  final String usageType;
  final List<AmenityEntity> amenities;
  final String description;
  final int yearBuilt;
  final String city;
  final String state;
  final String status;
  final double latitude;
  final double longitude;

  const PropertyDetailsEntity({
    required this.id,
    required this.title,
    required this.images,
    required this.category,
    required this.propertyType,
    required this.operation,
    required this.price,
    required this.area,
    required this.furnitureIncluded,
    required this.floor,
    required this.rooms,
    required this.bathrooms,
    required this.usageType,
    required this.amenities,
    required this.description,
    required this.yearBuilt,
    required this.city,
    required this.state,
    required this.status,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [
    id,
    images,
    category,
    propertyType,
    operation,
    price,
    area,
    furnitureIncluded,
    floor,
    rooms,
    bathrooms,
    usageType,
    amenities,
    description,
    yearBuilt,
    city,
    state,
    status,
    latitude,
    longitude,
  ];
}




