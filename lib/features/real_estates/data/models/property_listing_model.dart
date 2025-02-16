import '../../domain/entities/property_listing_entity.dart';

class PropertyListingModel extends PropertyListingEntity {
  const PropertyListingModel({
    required super.id,
    required super.title,
    required super.price,
    required super.imageUrl,
    required super.operation,
    required super.area,
    required super.floor,
    required super.rooms,
    required super.bathrooms,
    required super.city,
    required super.state,
    required super.usageType,
    required super.status,
    required super.isInWishlist,
  });

  factory PropertyListingModel.fromJson(Map<String, dynamic> json) {
    return PropertyListingModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      price: json['price'].toString(),
      imageUrl: json['image'] ?? '',
      operation: json['operation'] ?? '', // No operation in response, keeping for compatibility
      area: (json['area'] as num).toDouble(),
      floor: json['floor'] ?? 0,
      rooms: json['rooms'] ?? 0,
      bathrooms: json['bathrooms'] ?? 0,
      city: json['city']?['name'] ?? '',
      state: json['city']?['state']?['name'] ?? '',
      usageType: json['usage_type'] ?? '',
      status: json['status'] ?? '',
      isInWishlist: json['is_in_wishlist'] ?? false,
    );
  }
}
