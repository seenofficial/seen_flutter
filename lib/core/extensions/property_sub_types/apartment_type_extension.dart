import '../../utils/enums.dart';

extension ApartmentTypeExtension on ApartmentType {
  /// Get the Arabic translation of the apartment type.
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

  /// Get the English translation of the apartment type.
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

  /// Check if the apartment type is a studio.
  bool get isStudio => this == ApartmentType.studio;

  /// Check if the apartment type is a duplex.
  bool get isDuplex => this == ApartmentType.duplex;

  /// Check if the apartment type is a penthouse.
  bool get isPenthouse => this == ApartmentType.penthouse;

  /// Convert the apartment type to an ID to be used in the backend.
  int get toId {
    switch (this) {
      case ApartmentType.studio:
        return 2;
      case ApartmentType.duplex:
        return 1;
      case ApartmentType.penthouse:
        return 8;
    }
  }

  /// Convert an ID from the backend to the corresponding apartment type.
  static ApartmentType fromId(int id) {
    switch (id) {
      case 2:
        return ApartmentType.studio;
      case 1:
        return ApartmentType.duplex;
      case 8:
        return ApartmentType.penthouse;
      default:
        throw ArgumentError('Invalid ApartmentType ID: $id');
    }
  }
}
