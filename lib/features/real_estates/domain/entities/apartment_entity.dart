import 'package:enmaa/features/real_estates/domain/entities/base_property_entity.dart';

class ApartmentEntity extends PropertyEntity {
  final int floor;
  final int rooms;
  final int bathrooms;
  final bool isFurnished;

  const ApartmentEntity({
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
    required super.isInWishlist,
    required this.floor,
    required this.rooms,
    required this.bathrooms,
    required this.isFurnished,
    required super.state,
    required super.country,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        floor,
        rooms,
        bathrooms,
        isFurnished,
      ];
}
