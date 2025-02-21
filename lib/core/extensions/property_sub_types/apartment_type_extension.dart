import '../../utils/enums.dart';

extension ApartmentTypeExtension on ApartmentType {
  /// Get the Arabic translation of the apartment type
  String get toArabic {
    switch (this) {
      case ApartmentType.studio:
        return 'ستوديو';
      case ApartmentType.duplex:
        return 'دوبلكس';
      case ApartmentType.penthouse:
        return 'بنتهاوس';
    }
  }

  /// Get the English translation of the apartment type
  String get toEnglish {
    switch (this) {
      case ApartmentType.studio:
        return 'Studio';
      case ApartmentType.duplex:
        return 'Duplex';
      case ApartmentType.penthouse:
        return 'Penthouse';
    }
  }

  bool get isStudio => this == ApartmentType.studio;
  bool get isDuplex => this == ApartmentType.duplex;
  bool get isPenthouse => this == ApartmentType.penthouse;
}