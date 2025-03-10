import 'package:easy_localization/easy_localization.dart';
import '../../translation/locale_keys.dart';
import '../../utils/enums.dart';

extension LandTypeExtension on LandType {
  /// Get the Arabic translation of the land type.
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

  /// Get the English translation of the land type.
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

  /// Get the localized name of the land type.
  String get toName {
    switch (this) {
      case LandType.freehold:
        return LocaleKeys.freehold.tr();
      case LandType.agricultural:
        return LocaleKeys.agricultural.tr();
      case LandType.industrial:
        return LocaleKeys.industrial.tr();
    }
  }

  /// Check if the land type is freehold.
  bool get isFreehold => this == LandType.freehold;

  /// Check if the land type is agricultural.
  bool get isAgricultural => this == LandType.agricultural;

  /// Check if the land type is industrial.
  bool get isIndustrial => this == LandType.industrial;

  /// Convert the land type to an ID to be used in the backend.
  int get toId {
    switch (this) {
      case LandType.freehold:
        return 6;
      case LandType.agricultural:
        return 5;
      case LandType.industrial:
        return 7;
    }
  }

  /// Convert an ID from the backend to the corresponding land type.
  static LandType fromId(int id) {
    switch (id) {
      case 6:
        return LandType.freehold;
      case 5:
        return LandType.agricultural;
      case 7:
        return LandType.industrial;
      default:
        throw ArgumentError('Invalid LandType ID: $id');
    }
  }
}
