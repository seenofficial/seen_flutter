import 'package:enmaa/features/real_estates/data/models/apartment_details_model.dart';
import 'package:enmaa/features/real_estates/data/models/villa_details_model.dart';

import '../../domain/entities/property_details_entity.dart';
import 'building_drtails_model.dart';
import 'land_details_model.dart';

class PropertyDetailsModel {
  static BasePropertyDetailsEntity fromJson(Map<String, dynamic> json) {
    final String propertyType = json['type'];

    switch (propertyType) {
      case 'villa':
        return VillaDetailsModel.fromJson(json);
      case 'apartment':
        return ApartmentDetailsModel.fromJson(json);
      case 'building':
        return BuildingDetailsModel.fromJson(json);
      case 'land':
        return LandDetailsModel.fromJson(json);
      default:
        throw Exception('Unknown property type: $propertyType');
    }
  }
}
