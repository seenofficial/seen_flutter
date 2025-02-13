import 'package:equatable/equatable.dart';

class PropertyListingEntity extends Equatable {
  final String id;
  final String title;
  final String price;
  final String imageUrl;
  final String operation;

  final String city;
  final String state;
  final String category;
  final String propertyType;


  final double area;
  final int rooms;
  final int bathrooms;

  const PropertyListingEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.operation,
    required this.area,
    required this.rooms,
    required this.bathrooms,
    required this.city,
    required this.state,
    required this.category,
    required this.propertyType,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    price,
    imageUrl,
    operation,
    area,
    rooms,
    bathrooms,
    city,
    state,
    category,
    propertyType,
  ];
}
