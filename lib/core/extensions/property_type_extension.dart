import '../utils/enums.dart';

extension PropertyTypeExtension on PropertyType {
  // Get Property Type in English
  String get toEnglish {
    switch (this) {
      case PropertyType.apartment:
        return 'apartment';
      case PropertyType.villa:
        return 'villa';
      case PropertyType.building:
        return 'building';
      case PropertyType.land:
        return 'land';
    }
  }

  // Get Property Type in Arabic
  String get toArabic {
    switch (this) {
      case PropertyType.apartment:
        return 'شقة';
      case PropertyType.villa:
        return 'فيلا';
      case PropertyType.building:
        return 'عمارة';
      case PropertyType.land:
        return 'أرض';
    }
  }

  bool get isApartment => this == PropertyType.apartment;
  bool get isVilla => this == PropertyType.villa;
  bool get isBuilding => this == PropertyType.building;
  bool get isLand => this == PropertyType.land;

  // Convert PropertyType to its corresponding ID for JSON
  int get toJsonId {
    switch (this) {
      case PropertyType.apartment:
        return 2;
      case PropertyType.villa:
        return 3;
      case PropertyType.building:
        return 1;
      case PropertyType.land:
        return 4;
    }
  }
}
