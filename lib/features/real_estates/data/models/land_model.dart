   import '../../../../core/services/select_location_service/domain/entities/city_entity.dart';
import '../../../../core/services/select_location_service/domain/entities/country_entity.dart';
import '../../../../core/services/select_location_service/domain/entities/state_entity.dart';
import '../../domain/entities/land_entity.dart';

class LandModel extends LandEntity {
  const LandModel({
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
    required super.isLicensed,
  });

  factory LandModel.fromJson(Map<String, dynamic> json) {
    final propertyType = json['type'];
    final propertyData = json[propertyType];

    final cityData = propertyData['city'];
    final stateData = cityData['state'];
    final countryData = stateData['country'];

    return LandModel(
      id: propertyData['id'],
      title: propertyData['title'],
      image: propertyData['image']??'',
      propertyType: propertyType,
      operation: propertyData['operation'],
      price: propertyData['price']?.toString() ?? '0.00',
      area: (propertyData['area'] as num?)?.toDouble() ?? 0.0,
      propertySubType: propertyData['property_sub_type'].toString(),
      status: propertyData['status'],
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
      isInWishlist: propertyData['is_in_wishlist'] ?? false,
      isLicensed: propertyData['is_licensed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type' : 'land',
      'land':{
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
        'is_licensed': isLicensed,
      }
    };
  }
}