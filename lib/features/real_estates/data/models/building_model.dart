import '../../../../core/services/select_location_service/domain/entities/city_entity.dart';
import '../../../../core/services/select_location_service/domain/entities/country_entity.dart';
import '../../../../core/services/select_location_service/domain/entities/state_entity.dart';
import '../../domain/entities/building_entity.dart';

class BuildingModel extends BuildingEntity {
  const BuildingModel({
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
     required super.apartmentPerFloor,
    required super.totalFloors,
  });

  factory BuildingModel.fromJson(Map<String, dynamic> json) {
    final propertyType = json['type'];
    final propertyData = json['building'];

    if (propertyData == null) {
      throw FormatException('Invalid building data');
    }

    final cityData = propertyData['city'];
    final stateData = cityData['state'];
    final countryData = stateData['country'];

    return BuildingModel(
      id: propertyData['id'],
      title: propertyData['title'],
      image: propertyData['image'] ?? '',
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
      totalFloors: propertyData['number_of_floors'],
      apartmentPerFloor: propertyData['number_of_apartments'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type':'building',
      'building':{
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
        'number_of_floors': totalFloors,
        'number_of_apartments': apartmentPerFloor,
      },
    };
  }

}