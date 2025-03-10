part of 'add_new_real_estate_cubit.dart';

class AddNewRealEstateState extends Equatable {
  const AddNewRealEstateState({
    this.currentPropertyOperationType = PropertyOperationType.forSale,
    this.currentPropertyType = PropertyType.apartment,
    this.currentApartmentType = ApartmentType.studio,
    this.currentVillaType = VillaType.standalone,
    this.currentBuildingType = BuildingType.residential,
    this.currentLandType = LandType.freehold,
    this.availableForRenewal = true,
    this.currentFurnishingStatus = FurnishingStatus.furnished,
    this.addNewApartmentErrorMessage = '',
    this.addNewApartmentState = RequestState.initial,
    this.selectedImages = const [],
    this.selectImagesState = RequestState.initial,
    this.validateImages = true,
    this.currentAmenities = const [],
    this.getAmenitiesState = RequestState.initial,
    this.selectedAmenities = const [],
    this.selectedLocation,

    this.currentPaymentMethod = PaymentMethod.cash,
    this.landLicenseStatus = LandLicenseStatus.licensed,
  });

  final PropertyOperationType currentPropertyOperationType;

  final PropertyType currentPropertyType;

  final LatLng? selectedLocation;

  /// current states for sub types
  final ApartmentType currentApartmentType;
  final VillaType currentVillaType;
  final BuildingType currentBuildingType;
  final LandType currentLandType;

  final bool availableForRenewal;
  final FurnishingStatus currentFurnishingStatus;

  /// property
  final RequestState addNewApartmentState;
  final String addNewApartmentErrorMessage;

  final List<File> selectedImages;
  final RequestState selectImagesState;
  final bool validateImages;

  /// amenities

  final List<AmenityEntity> currentAmenities;
  final RequestState getAmenitiesState;
  final List<String> selectedAmenities;



  final PaymentMethod currentPaymentMethod;

  final LandLicenseStatus landLicenseStatus;

  AddNewRealEstateState copyWith({
    PropertyOperationType? currentPropertyOperationType,
    PropertyType? currentPropertyType,
    ApartmentType? currentApartmentType,
    VillaType? currentVillaType,
    BuildingType? currentBuildingType,
    LandType? currentLandType,
    bool? availableForRenewal,
    FurnishingStatus? currentFurnishingStatus,
    RequestState? addNewApartmentState,
    String? addNewApartmentErrorMessage,
    List<File>? selectedImages,
    RequestState? selectImagesState,
    bool? validateImages,
    List<AmenityEntity>? currentAmenities,
    RequestState? getAmenitiesState,
    List<String>? selectedAmenities,
    LatLng? selectedLocation,
    String? selectedCityId,
    String? selectedCityName,
    PaymentMethod? currentPaymentMethod,
    LandLicenseStatus? landLicenseStatus,
  }) {
    return AddNewRealEstateState(
       currentPropertyOperationType:
          currentPropertyOperationType ?? this.currentPropertyOperationType,
      currentPropertyType: currentPropertyType ?? this.currentPropertyType,
      currentApartmentType: currentApartmentType ?? this.currentApartmentType,
      currentVillaType: currentVillaType ?? this.currentVillaType,
      currentBuildingType: currentBuildingType ?? this.currentBuildingType,
      currentLandType: currentLandType ?? this.currentLandType,
      availableForRenewal: availableForRenewal ?? this.availableForRenewal,
      currentFurnishingStatus:
          currentFurnishingStatus ?? this.currentFurnishingStatus,
      addNewApartmentState: addNewApartmentState ?? this.addNewApartmentState,
      addNewApartmentErrorMessage:
          addNewApartmentErrorMessage ?? this.addNewApartmentErrorMessage,
      selectedImages: selectedImages ?? this.selectedImages,
      selectImagesState: selectImagesState ?? this.selectImagesState,
      validateImages: validateImages ?? this.validateImages,
      currentAmenities: currentAmenities ?? this.currentAmenities,
      getAmenitiesState: getAmenitiesState ?? this.getAmenitiesState,
      selectedAmenities: selectedAmenities ?? this.selectedAmenities,
      selectedLocation: selectedLocation ?? this.selectedLocation,
       currentPaymentMethod: currentPaymentMethod ?? this.currentPaymentMethod,
      landLicenseStatus: landLicenseStatus ?? this.landLicenseStatus,
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
        availableForRenewal,
        currentFurnishingStatus,
        addNewApartmentState,
        addNewApartmentErrorMessage,
        selectedImages,
        selectImagesState,
        validateImages,
        currentAmenities,
        getAmenitiesState,
        selectedAmenities,
        selectedLocation,

        currentPaymentMethod,
        landLicenseStatus,
      ];
}
