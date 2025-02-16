import 'package:enmaa/core/models/amenity_model.dart';
import 'package:enmaa/core/models/image_model.dart';
import 'package:enmaa/features/real_estates/domain/entities/property_details_entity.dart';

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
      id: json["id"] ?? 0,
      title: json["title"] ?? '',
      price: json["price"] ?? '0.0',
      operation: json["operation"] ?? '',
      area: (json["area"] as num?)?.toDouble() ?? 0.0,
      rooms: json["rooms"] ?? 0,
      bathrooms: json["bathrooms"] ?? 0,
      city: json["city"]?["name"] ?? '',
      state: json["city"]?["state"]?["name"] ?? '',
      category: json["property_sub_type"]?["name"] ?? '',
      propertyType: json["property_sub_type"]?["property_type"]?["name"] ?? '',
      images: (json["images"] as List?)
          ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      furnitureIncluded: json["is_furnitured"] ?? false,
      floor: json["floor"] ?? 0,
      usageType: json["usage_type"] ?? '',
      amenities: (json["amenities"] as List?)
          ?.map((e) => AmenityModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      description: json["description"] ?? '',
      yearBuilt: json["year_built"] ?? 0,
      status: json["status"] ?? '',
      latitude: (json["latitude"] as num?)?.toDouble() ?? 0.0,
      longitude: (json["longitude"] as num?)?.toDouble() ?? 0.0,
    );
  }
}
