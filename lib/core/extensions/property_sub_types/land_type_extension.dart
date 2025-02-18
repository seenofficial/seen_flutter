import '../../utils/enums.dart';

extension LandTypeExtension on LandType {
  /// Get the Arabic translation of the land type
  String get toArabic {
    switch (this) {
      case LandType.freehold:
        return 'حر';
      case LandType.agricultural:
        return 'زراعي';
      case LandType.industrial:
        return 'صناعي';
    }
  }

  /// Get the English translation of the land type
  String get toEnglish {
    switch (this) {
      case LandType.freehold:
        return 'Freehold';
      case LandType.agricultural:
        return 'Agricultural';
      case LandType.industrial:
        return 'Industrial';
    }
  }

  bool get isFreehold => this == LandType.freehold;
  bool get isAgricultural => this == LandType.agricultural;
  bool get isIndustrial => this == LandType.industrial;
}
