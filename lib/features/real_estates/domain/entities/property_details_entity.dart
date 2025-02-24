import 'package:enmaa/core/entites/amenity_entity.dart';
import 'package:enmaa/core/entites/image_entity.dart';
import 'package:enmaa/features/real_estates/domain/entities/base_property_entity.dart';
import 'package:equatable/equatable.dart';

abstract class BasePropertyDetailsEntity extends Equatable {
  final int id;
  final String title;
  final String operation;
  final String price;
  final double area;
  final String propertySubType;
  final String status;
  final List<ImageEntity> images;
  final List<AmenityEntity> amenities;
  final String description;
  final double latitude;
  final double longitude;
  final String city;
  final String state;
  final String country;
  final bool isInWishlist;

  const BasePropertyDetailsEntity({
    required this.id,
    required this.title,
    required this.operation,
    required this.price,
    required this.area,
    required this.propertySubType,
    required this.status,
    required this.images,
    required this.amenities,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.state,
    required this.country,
    required this.isInWishlist,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    operation,
    price,
    area,
    propertySubType,
    status,
    images,
    amenities,
    description,
    latitude,
    longitude,
    city,
    state,
    country,
    isInWishlist,
  ];
}