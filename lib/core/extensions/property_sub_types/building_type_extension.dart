import '../../utils/enums.dart';

extension BuildingTypeExtension on BuildingType {
  /// Get the Arabic translation of the building type.
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

  /// Get the English translation of the building type.
  String get toEnglish {
    switch (this) {
      case BuildingType.residential:
        return 'Residential';
      case BuildingType.commercial:
        return 'Commercial';
      case BuildingType.mixedUse:
        return 'Mixed';
    }
  }

  /// Check if the building type is residential.
  bool get isResidential => this == BuildingType.residential;

  /// Check if the building type is commercial.
  bool get isCommercial => this == BuildingType.commercial;

  /// Check if the building type is mixed-use.
  bool get isMixedUse => this == BuildingType.mixedUse;

  /// Convert the building type to an ID to be used in the backend.
  int get toId {
    switch (this) {
      case BuildingType.residential:
        return 11;
      case BuildingType.commercial:
        return 12;
      case BuildingType.mixedUse:
        return 3;
    }
  }

  /// Convert an ID from the backend to the corresponding building type.
  static BuildingType fromId(int id) {
    switch (id) {
      case 11:
        return BuildingType.residential;
      case 12:
        return BuildingType.commercial;
      case 3:
        return BuildingType.mixedUse;
      default:
        throw ArgumentError('Invalid BuildingType ID: $id');
    }
  }
}
