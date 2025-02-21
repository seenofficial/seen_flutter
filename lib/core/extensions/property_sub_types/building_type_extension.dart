import '../../utils/enums.dart';

extension BuildingTypeExtension on BuildingType {
  /// Get the Arabic translation of the building type
  String get toArabic {
    switch (this) {
      case BuildingType.residential:
        return 'سكنية';
      case BuildingType.commercial:
        return 'تجارية';
      case BuildingType.mixedUse:
        return 'مختلطة';
    }
  }

  /// Get the English translation of the building type
  String get toEnglish {
    switch (this) {
      case BuildingType.residential:
        return 'Residential';
      case BuildingType.commercial:
        return 'Commercial';
      case BuildingType.mixedUse:
        return 'Mixed Use';
    }
  }

  bool get isResidential => this == BuildingType.residential;
  bool get isCommercial => this == BuildingType.commercial;
  bool get isMixedUse => this == BuildingType.mixedUse;
}
