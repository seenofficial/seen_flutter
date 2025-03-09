import '../../utils/enums.dart';

extension VillaTypeExtension on VillaType {
  /// Get the Arabic translation of the villa type.
  String get toArabic {
    switch (this) {
      case VillaType.standalone:
        return 'مستقلة';
      case VillaType.twinHouse:
        return 'توين هاوس';
      case VillaType.townHouse:
        return 'تاون هاوس';
    }
  }

  /// Get the English translation of the villa type.
  String get toEnglish {
    switch (this) {
      case VillaType.standalone:
        return 'Standalone';
      case VillaType.twinHouse:
        return 'Twin House';
      case VillaType.townHouse:
        return 'Town House';
    }
  }

  /// Check if the villa type is standalone.
  bool get isStandalone => this == VillaType.standalone;

  /// Check if the villa type is twin house.
  bool get isTwinHouse => this == VillaType.twinHouse;

  /// Check if the villa type is town house.
  bool get isTownHouse => this == VillaType.townHouse;

  /// Convert the villa type to an ID to be used in the backend.
  int get toId {
    switch (this) {
      case VillaType.standalone:
        return 10;
      case VillaType.twinHouse:
        return 4;
      case VillaType.townHouse:
        return 9;
    }
  }

  /// Convert an ID from the backend to the corresponding villa type.
  static VillaType fromId(int id) {
    switch (id) {
      case 1:
        return VillaType.standalone;
      case 2:
        return VillaType.twinHouse;
      case 3:
        return VillaType.townHouse;
      default:
        throw ArgumentError('Invalid VillaType ID: $id');
    }
  }
}
