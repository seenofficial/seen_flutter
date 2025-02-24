// file: lib/features/real_estates/data/models/property_model.dart
import 'package:enmaa/features/real_estates/data/models/apartment_model.dart';
import 'package:enmaa/features/real_estates/data/models/villa_model.dart';
import 'package:enmaa/features/real_estates/data/models/land_model.dart';
import 'package:enmaa/features/real_estates/data/models/building_model.dart';

import '../../domain/entities/base_property_entity.dart';

class PropertyModel {
  static PropertyEntity fromJson(Map<String, dynamic> json) {
    final String propertyType = json['type'];
    print("propertyType: $propertyType");
    switch (propertyType) {
      case 'apartment':
        return ApartmentModel.fromJson(json);
      case 'villa':
        print("villa isisi ${json}");
        return VillaModel.fromJson(json);
      case 'land':
        print("land isisi");
        return LandModel.fromJson(json);
      case 'building':
        return BuildingModel.fromJson(json);
      default:
        throw Exception('Unknown property type: $propertyType');
    }
  }
}
