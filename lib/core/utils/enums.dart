enum RequestState { initial, loading, loaded, error }

/// Enum for property operation type
enum PropertyOperationType { forSale, forRent }

/// Enum for property type
enum PropertyType { apartment, villa , building, land }

/// Enum for apartment types
enum ApartmentType { studio, duplex, penthouse }

/// Enum for villa types
enum VillaType {
  standalone,
  twinHouse,
  townHouse
}
/// Enum for Building types
enum BuildingType {
  residential, // سكنية
  commercial,  // تجارية
  mixedUse,    // مختلطة
}

/// Enum for Land types
enum LandType {
  freehold,    // حر
  agricultural, // زراعي
  industrial,  // صناعي
}

/// Enum for Furnishing Status
enum FurnishingStatus {
  furnished,
  notFurnished,
}

