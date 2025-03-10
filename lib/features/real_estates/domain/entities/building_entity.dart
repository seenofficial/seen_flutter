import 'package:enmaa/features/real_estates/domain/entities/base_property_entity.dart';

import '../../../../core/services/select_location_service/domain/entities/city_entity.dart';
import '../../../../core/services/select_location_service/domain/entities/country_entity.dart';
import '../../../../core/services/select_location_service/domain/entities/state_entity.dart';

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

  BuildingEntity copyWith({
    int? id,
    String? title,
    String? image,
    String? propertyType,
    String? operation,
    String? price,
    double? area,
    String? propertySubType,
    String? status,
    CityEntity? city,
    StateEntity? state,
    CountryEntity? country,
    bool? isInWishlist,
    int? totalFloors,
    int? apartmentPerFloor,
  }) {
    return BuildingEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      propertyType: propertyType ?? this.propertyType,
      operation: operation ?? this.operation,
      price: price ?? this.price,
      area: area ?? this.area,
      propertySubType: propertySubType ?? this.propertySubType,
      status: status ?? this.status,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      isInWishlist: isInWishlist ?? this.isInWishlist,
      totalFloors: totalFloors ?? this.totalFloors,
      apartmentPerFloor: apartmentPerFloor ?? this.apartmentPerFloor,
    );
  }
}
