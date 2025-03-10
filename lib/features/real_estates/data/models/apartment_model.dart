
 import '../../../../core/services/select_location_service/domain/entities/city_entity.dart';
import '../../../../core/services/select_location_service/domain/entities/country_entity.dart';
import '../../../../core/services/select_location_service/domain/entities/state_entity.dart';
import '../../domain/entities/apartment_entity.dart';

class ApartmentModel extends ApartmentEntity {
  const ApartmentModel({
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
    required super.floor,
    required super.rooms,
    required super.bathrooms,
    required super.state,
    required super.country,
    required super.isFurnished,
  });

  factory ApartmentModel.fromJson(Map<String, dynamic> json) {
    final propertyData = json['apartment'];

    final cityData = propertyData['city'];
    final stateData = cityData['state'];
    final countryData = stateData['country'];

    return ApartmentModel(
      id: propertyData['id'],
      title: propertyData['title'].toString(),
      image: propertyData['image'] ?? '',
      propertyType: json['type'].toString(),
      operation: propertyData['operation'].toString(),
      price: propertyData['price']?.toString() ?? '0.00',
      area: (propertyData['area'] as num?)?.toDouble() ?? 0.0,
      propertySubType: propertyData['property_sub_type'].toString(),
      status: propertyData['status'].toString(),
      city: CityEntity(
        id: cityData['id'].toString(),
        name: cityData['name'].toString(),
      ),
      state: StateEntity(
        id: stateData['id'].toString(),
        name: stateData['name'].toString(),
      ),
      country: CountryEntity(
        id: countryData['id'].toString(),
        name: countryData['name'].toString(),
      ),
      isInWishlist: json['is_in_wishlist'] ?? true,
      floor: propertyData['floor'] is int
          ? propertyData['floor']
          : int.parse(propertyData['floor'].toString()),
      rooms: propertyData['rooms'] is int
          ? propertyData['rooms']
          : int.parse(propertyData['rooms'].toString()),
      bathrooms: propertyData['bathrooms'] is int
          ? propertyData['bathrooms']
          : int.parse(propertyData['bathrooms'].toString()),
      isFurnished: propertyData['is_furnitured'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type':'apartment',
      'apartment':{
        'id': id,
        'title': title,
        'image': image,
        'type': propertyType,
        'operation': operation,
        'price': price,
        'area': area,
        'property_sub_type': propertySubType,
        'status': status,
        'city': {
          'id': city.id,
          'name': city.name,
          'state': {
            'id': state.id,
            'name': state.name,
            'country': {
              'id': country.id,
              'name': country.name,
            },
          },
        },
        'is_in_wishlist': isInWishlist,
        'floor': floor,
        'rooms': rooms,
        'bathrooms': bathrooms,
        'is_furnitured': isFurnished,
      },
    };
  }
}