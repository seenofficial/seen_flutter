import 'package:enmaa/features/real_estates/domain/entities/base_property_entity.dart';

class VillaEntity extends PropertyEntity {
  final int floors;
  final int rooms;
  final int bathrooms;
  final bool hasPool;
  final bool isFurnished;

  const VillaEntity({
    required super.id,
    required super.title,
    required super.image,
    required super.propertyType,
    required super.operation,
    required super.price,
    required super.area,
    required super.propertySubType,
    required super.status,
    required super.city,
    required super.state,
    required super.country,
    required super.isInWishlist,
    required this.floors,
    required this.rooms,
    required this.bathrooms,
    required this.hasPool,
    required this.isFurnished,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    floors,
    rooms,
    bathrooms,
    hasPool,
    isFurnished,
  ];
}