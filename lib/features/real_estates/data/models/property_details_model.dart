import 'package:enmaa/core/models/amenity_model.dart';
import 'package:enmaa/core/models/image_model.dart';
import 'package:enmaa/features/real_estates/domain/entities/property_details_entity.dart';
import '../../../../core/constants/json_keys.dart';

class PropertyDetailsModel extends PropertyDetailsEntity {
  const PropertyDetailsModel({
    required super.id,
    required super.title,
    required super.price,
    required super.operation,
    required super.area,
    required super.rooms,
    required super.bathrooms,
    required super.city,
    required super.state,
    required super.category,
    required super.propertyType,
    required super.images,
    required super.furnitureIncluded,
    required super.floor,
    required super.usageType,
    required super.amenities,
    required super.description,
    required super.yearBuilt,
    required super.status,
    required super.latitude,
    required super.longitude,
  });

  factory PropertyDetailsModel.fromJson(Map<String, dynamic> json) {
    return PropertyDetailsModel(
      id: json[JsonKeys.id] ?? 0,
      title: json[JsonKeys.title] ?? '',
      price: json[JsonKeys.price] ?? '0.0',
      operation: json[JsonKeys.operation] ?? '',
      area: (json[JsonKeys.area] as num?)?.toDouble() ?? 0.0,
      rooms: json[JsonKeys.rooms] ?? 0,
      bathrooms: json[JsonKeys.bathrooms] ?? 0,
      city: json[JsonKeys.city] ?? '',
      state: json[JsonKeys.state] ?? '',
      category: json[JsonKeys.category] ?? '',
      propertyType: json[JsonKeys.propertyType] ?? '',
      images: (json[JsonKeys.images] as List?)
          ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      furnitureIncluded: json[JsonKeys.furnitureIncluded] ?? false,
      floor: json[JsonKeys.floor] ?? 0,
      usageType: json[JsonKeys.usageType] ?? '',
      amenities: (json[JsonKeys.amenities] as List?)
          ?.map((e) => AmenityModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      description: json[JsonKeys.description] ?? '',
      yearBuilt: json[JsonKeys.yearBuilt] ?? '',
      status: json[JsonKeys.status] ?? '',
      latitude: (json[JsonKeys.latitude] as num?)?.toDouble() ?? 0.0,
      longitude: (json[JsonKeys.longitude] as num?)?.toDouble() ?? 0.0,
    );
  }
}
