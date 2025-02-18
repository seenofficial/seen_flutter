import '../utils/enums.dart';

extension PropertyTypeExtension on PropertyType {
  // Get Property Type in English
  String get toEnglish {
    switch (this) {
      case PropertyType.apartment:
        return 'Apartment';
      case PropertyType.villa:
        return 'Villa';
      case PropertyType.building:
        return 'Building';
      case PropertyType.land:
        return 'Land';
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


}
