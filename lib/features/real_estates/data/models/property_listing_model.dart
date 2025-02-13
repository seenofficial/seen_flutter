
import '../../domain/entities/property_listing_entity.dart';

class PropertyListingModel extends PropertyListingEntity {
  const PropertyListingModel({
    required super.id,
    required super.title,
    required super.price,
    required super.imageUrl,
    required super.operation,
    required super.area,
    required super.rooms,
    required super.bathrooms,
    required super.city,
    required super.state,
    required super.category,
    required super.propertyType,
  });

  factory PropertyListingModel.fromJson(Map<String, dynamic> json) {
    return PropertyListingModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      price: json['price'].toString(),
      imageUrl: json['image'] ?? '',
      operation: json['operation'] ?? '',
      area: (json['area'] as num).toDouble(),
      rooms: json['rooms'] ?? 0,
      bathrooms: json['bathrooms'] ?? 0,
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      category: json['category'] ?? '',
      propertyType: json['property_type'] ?? '',
    );
  }

}
