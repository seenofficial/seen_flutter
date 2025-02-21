import '../../utils/enums.dart';

extension VillaTypeExtension on VillaType {
  /// Get the Arabic translation of the villa type
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

  /// Get the English translation of the villa type
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

  bool get isStandalone => this == VillaType.standalone;
  bool get isTwinHouse => this == VillaType.twinHouse;
  bool get isTownHouse => this == VillaType.townHouse;
}
