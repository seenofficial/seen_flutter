import 'package:enmaa/core/models/amenity_model.dart';
import 'package:enmaa/core/models/image_model.dart';
import 'package:enmaa/features/real_estates/domain/entities/villa_details_entity.dart';

class VillaDetailsModel extends VillaDetailsEntity {
  const VillaDetailsModel({
    required super.id,
    required super.title,
    required super.operation,
    required super.price,
    required super.area,
    required super.propertySubType,
    required super.status,
    required super.images,
    required super.amenities,
    required super.description,
    required super.latitude,
    required super.longitude,
    required super.city,
    required super.state,
    required super.country,
    required super.isInWishlist,
    required super.isFurnished,
    required super.numberOfFloors,
    required super.rooms,
    required super.bathrooms, required super.rentIsRenewable, required super.monthlyRentPeriod,
  });

  factory VillaDetailsModel.fromJson(Map<String, dynamic> json) {
    final propertyType = json['type'];
    final propertyData = json[propertyType];

    final cityData = propertyData['city'];
    final stateData = cityData['state'];
    final countryData = stateData['country'];

    return VillaDetailsModel(
      id: propertyData['id'],
      title: propertyData['title'],
      operation: propertyData['operation'],
      price: propertyData['price']?.toString() ?? '0.00',
      area: (propertyData['area'] as num?)?.toDouble() ?? 0.0,
      propertySubType: propertyData['property_sub_type']['name'].toString(),
      status: propertyData['status'],
      images: (propertyData['images'] as List)
          .map((image) => ImageModel.fromJson(image))
          .toList(),
      amenities: (propertyData['amenities'] as List)
          .map((amenity) => AmenityModel.fromJson(amenity))
          .toList(),
      description: propertyData['description'] ?? '',
      latitude: propertyData['latitude'] ?? 0.0,
      longitude: propertyData['longitude'] ?? 0.0,
      city: cityData['name'].toString(),
      state: stateData['name'].toString(),
      country: countryData['name'].toString(),
      isInWishlist: json['is_in_wishlist'] ?? false,
      isFurnished: propertyData['is_furnitured'] ?? false,
      numberOfFloors: propertyData['number_of_floors'] ?? 0,
      rooms: propertyData['rooms'] ?? 0,
      bathrooms: propertyData['bathrooms'] ?? 0,
      rentIsRenewable: propertyData['is_renewable'] ?? '', monthlyRentPeriod: propertyData['monthly_rent_period'].toString() ?? '',

    );
  }
}