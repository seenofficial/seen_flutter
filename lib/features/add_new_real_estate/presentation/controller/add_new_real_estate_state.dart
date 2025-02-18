part of 'add_new_real_estate_cubit.dart';

class AddNewRealEstateState extends Equatable {
  const AddNewRealEstateState({
    this.currentPropertyOperationType = PropertyOperationType.forSale,
    this.currentPropertyType = PropertyType.apartment,
    this.currentApartmentType = ApartmentType.studio,
    this.currentVillaType = VillaType.standalone,
    this.currentBuildingType = BuildingType.residential,
    this.currentLandType = LandType.freehold,
  });

  final PropertyOperationType currentPropertyOperationType;

  final PropertyType currentPropertyType;

  /// current states for sub types
  final ApartmentType currentApartmentType ;
  final VillaType currentVillaType ;
  final BuildingType currentBuildingType ;
  final LandType currentLandType ;

  AddNewRealEstateState copyWith({
    PropertyOperationType? currentPropertyOperationType,
    PropertyType? currentPropertyType,
    ApartmentType? currentApartmentType,
    VillaType? currentVillaType,
    BuildingType? currentBuildingType,
    LandType? currentLandType,
  }) {
    return AddNewRealEstateState(
      currentPropertyOperationType:
          currentPropertyOperationType ?? this.currentPropertyOperationType,
      currentPropertyType: currentPropertyType ?? this.currentPropertyType,
      currentApartmentType: currentApartmentType ?? this.currentApartmentType,
      currentVillaType: currentVillaType ?? this.currentVillaType,
      currentBuildingType: currentBuildingType ?? this.currentBuildingType,
      currentLandType: currentLandType ?? this.currentLandType,
    );
  }

  @override
  List<Object?> get props => [
        currentPropertyOperationType,
        currentPropertyType,
        currentApartmentType,
        currentVillaType,
        currentBuildingType,
        currentLandType,
      ];
}
