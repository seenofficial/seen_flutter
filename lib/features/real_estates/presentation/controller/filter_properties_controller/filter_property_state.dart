part of 'filter_property_cubit.dart';

class FilterPropertyState extends Equatable {
  const FilterPropertyState({
    this.currentPropertyOperationType = PropertyOperationType.forSale,
    this.currentPropertyType,
    this.selectedApartmentTypes = const [],
    this.selectedVillaTypes = const [],
    this.selectedBuildingTypes = const [],
    this.selectedLandTypes = const [],
    this.availableForRenewal = true,
    this.selectedFurnishingStatuses = const [],
    this.minPriceValue = '0',
    this.maxPriceValue = '1000000',
    this.minAreaValue = '0',
    this.maxAreaValue = '1000',
    this.minNumberOfMonths = '0',
    this.maxNumberOfMonths = '12',
    this.selectedLandLicenseStatuses = const [],
  });

  final PropertyOperationType currentPropertyOperationType;
  final PropertyType? currentPropertyType;

  /// Lists of selected sub types
  final List<ApartmentType> selectedApartmentTypes;
  final List<VillaType> selectedVillaTypes;
  final List<BuildingType> selectedBuildingTypes;
  final List<LandType> selectedLandTypes;

  final bool availableForRenewal;
  final String minNumberOfMonths, maxNumberOfMonths;
  final List<FurnishingStatus> selectedFurnishingStatuses;

  final String minPriceValue, maxPriceValue;
  final String minAreaValue, maxAreaValue;

  final List<LandLicenseStatus> selectedLandLicenseStatuses; // New property

  FilterPropertyState copyWith({
    PropertyOperationType? currentPropertyOperationType,
    PropertyType? currentPropertyType,
    bool? removeCurrentPropertyType,
    List<ApartmentType>? selectedApartmentTypes,
    List<VillaType>? selectedVillaTypes,
    List<BuildingType>? selectedBuildingTypes,
    List<LandType>? selectedLandTypes,
    bool? availableForRenewal,
    List<FurnishingStatus>? selectedFurnishingStatuses,
    String? minPriceValue,
    String? maxPriceValue,
    String? minAreaValue,
    String? maxAreaValue,
    String? minNumberOfMonths,
    String? maxNumberOfMonths,
    List<LandLicenseStatus>? selectedLandLicenseStatuses, // Updated property
  }) {
    return FilterPropertyState(
      currentPropertyOperationType:
      currentPropertyOperationType ?? this.currentPropertyOperationType,
      currentPropertyType: removeCurrentPropertyType == true
          ? null
          : currentPropertyType ?? this.currentPropertyType,
      selectedApartmentTypes: selectedApartmentTypes ?? this.selectedApartmentTypes,
      selectedVillaTypes: selectedVillaTypes ?? this.selectedVillaTypes,
      selectedBuildingTypes: selectedBuildingTypes ?? this.selectedBuildingTypes,
      selectedLandTypes: selectedLandTypes ?? this.selectedLandTypes,
      availableForRenewal: availableForRenewal ?? this.availableForRenewal,
      selectedFurnishingStatuses:
      selectedFurnishingStatuses ?? this.selectedFurnishingStatuses,
      minPriceValue: minPriceValue ?? this.minPriceValue,
      maxPriceValue: maxPriceValue ?? this.maxPriceValue,
      minAreaValue: minAreaValue ?? this.minAreaValue,
      maxAreaValue: maxAreaValue ?? this.maxAreaValue,
      minNumberOfMonths: minNumberOfMonths ?? this.minNumberOfMonths,
      maxNumberOfMonths: maxNumberOfMonths ?? this.maxNumberOfMonths,
      selectedLandLicenseStatuses: selectedLandLicenseStatuses ?? this.selectedLandLicenseStatuses, // Updated property
    );
  }

  @override
  List<Object?> get props => [
    currentPropertyOperationType,
    currentPropertyType,
    selectedApartmentTypes,
    selectedVillaTypes,
    selectedBuildingTypes,
    selectedLandTypes,
    availableForRenewal,
    selectedFurnishingStatuses,
    minPriceValue,
    maxPriceValue,
    minAreaValue,
    maxAreaValue,
    minNumberOfMonths,
    maxNumberOfMonths,
    selectedLandLicenseStatuses,
  ];
}