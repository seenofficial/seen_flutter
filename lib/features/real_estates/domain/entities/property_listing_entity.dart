import 'package:equatable/equatable.dart';

class PropertyListingEntity extends Equatable {
  final String id;
  final String title;
  final String price;
  final String imageUrl;
  final String operation;
  final String city;
  final String state;
  final String usageType;
  final String status;
  final bool isInWishlist;
  final double area;
  final int floor;
  final int rooms;
  final int bathrooms;

  const PropertyListingEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.operation,
    required this.area,
    required this.floor,
    required this.rooms,
    required this.bathrooms,
    required this.city,
    required this.state,
    required this.usageType,
    required this.status,
    required this.isInWishlist,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    price,
    imageUrl,
    operation,
    area,
    floor,
    rooms,
    bathrooms,
    city,
    state,
    usageType,
    status,
    isInWishlist,
  ];
}
