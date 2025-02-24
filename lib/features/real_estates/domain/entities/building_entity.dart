import 'package:enmaa/features/real_estates/domain/entities/base_property_entity.dart';

class BuildingEntity extends PropertyEntity {
  final int totalFloors;
  final int apartmentPerFloor;

  const BuildingEntity({
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
    required this.totalFloors,
    required this.apartmentPerFloor,

  });

  @override
  List<Object?> get props => [
    ...super.props,
    totalFloors,
    apartmentPerFloor,
  ];
}
