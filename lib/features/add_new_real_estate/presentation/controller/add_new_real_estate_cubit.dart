import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:enmaa/core/constants/local_keys.dart';
import 'package:enmaa/core/entites/amenity_entity.dart';
import 'package:enmaa/core/extensions/furnished_status_extension.dart';
import 'package:enmaa/core/extensions/land_license_status_extension.dart';
import 'package:enmaa/core/extensions/operation_type_property_extension.dart';
import 'package:enmaa/core/extensions/property_sub_types/apartment_type_extension.dart';
import 'package:enmaa/core/extensions/property_sub_types/building_type_extension.dart';
import 'package:enmaa/core/extensions/property_sub_types/land_type_extension.dart';
import 'package:enmaa/core/extensions/property_sub_types/villa_type_extension.dart';
import 'package:enmaa/core/extensions/property_type_extension.dart';
import 'package:enmaa/core/services/select_location_service/presentation/controller/select_location_service_cubit.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/apartment_request_model.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/building_request_model.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/land_request_model.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/villa_request_model.dart';
import 'package:enmaa/features/add_new_real_estate/domain/use_cases/add_new_apartment_use_case.dart';
import 'package:enmaa/features/add_new_real_estate/domain/use_cases/add_new_building_use_case.dart';
import 'package:enmaa/features/add_new_real_estate/domain/use_cases/add_new_land_use_case.dart';
import 'package:enmaa/features/add_new_real_estate/domain/use_cases/get_property_amenities_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/components/property_form_controller.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/image_picker_service.dart';
import '../../../../core/utils/enums.dart';
import '../../../home_module/home_imports.dart';
import '../../data/models/property_request_model.dart';
import '../../domain/use_cases/add_villa_use_case.dart';

part 'add_new_real_estate_state.dart';

class AddNewRealEstateCubit extends Cubit<AddNewRealEstateState> {
  AddNewRealEstateCubit(
      this._addNewApartmentUseCase ,
      this._addVillaUseCase,
      this._addNewBuildingUseCase,
      this._addNewLandUseCase ,
      this._getPropertyAmenitiesUseCase ,
      ) : super(AddNewRealEstateState());

  final PropertyFormController formController = PropertyFormController();
  final formKey = GlobalKey<FormState>();
  final priceForm = GlobalKey<FormState>();
  final locationForm = GlobalKey<FormState>();


  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController rentController = TextEditingController();
  final TextEditingController rentDurationController = TextEditingController();

  Future<void> selectImages() async {
     emit(state.copyWith(
      selectImagesState: RequestState.loading,
    ));

    final ImagePickerHelper imagePickerHelper = ImagePickerHelper();

    final result = await imagePickerHelper.pickImages(
      maxImages: 5 - state.selectedImages.length,
     );

    result.fold(
          (failure) {
         emit(state.copyWith(
          selectImagesState: RequestState.loaded,
        ));
      },
          (xFiles) async {
        if (xFiles.isEmpty) {
          emit(state.copyWith(
            selectImagesState: RequestState.loaded,
            validateImages: true,
          ));
          return;
        }

        final processedFiles = await imagePickerHelper.processImagesWithResiliency(xFiles);

        emit(state.copyWith(
          selectImagesState: RequestState.loaded,
          validateImages: true,
          selectedImages: [...state.selectedImages, ...processedFiles],
        ));
      },
    );
  }

  void removeImage(int index) {
    emit(state.copyWith(selectImagesState: RequestState.loading));

    final List<File> newImages = state.selectedImages;
    newImages.removeAt(index);
    emit(state.copyWith(selectedImages: newImages , selectImagesState: RequestState.loaded));
  }

  bool validateImages() {
    if(state.selectedImages.isEmpty) {
      emit(state.copyWith(validateImages: false));
    }
    else {
      emit(state.copyWith(validateImages: true));
    }

    return state.selectedImages.isNotEmpty;
  }

  void changePropertyOperationType(PropertyOperationType propertyOperationType) {
    emit(state.copyWith(currentPropertyOperationType: propertyOperationType));
  }

  void changeSelectedLocation (LatLng location){

    emit(state.copyWith(selectedLocation: location));

  }

  void changePropertyType(PropertyType propertyType) {
    getAmenities(propertyType.toJsonId.toString());
    emit(state.copyWith(currentPropertyType: propertyType));
  }

  /// change subtypes
  void changeApartmentType(ApartmentType apartmentType) {
    emit(state.copyWith(currentApartmentType: apartmentType));
  }

  void changeVillaType(VillaType villaType) {
    emit(state.copyWith(currentVillaType: villaType));
  }

  void changeBuildingType(BuildingType buildingType) {
    emit(state.copyWith(currentBuildingType: buildingType));
  }

  void changeLandType(LandType landType) {
    emit(state.copyWith(currentLandType: landType));
  }
  void changeAvailabilityForRenewal() {
    emit(state.copyWith(availableForRenewal: !state.availableForRenewal));
  }
  void changeFurnishingStatus (FurnishingStatus furnishingStatus) {
    emit(state.copyWith(currentFurnishingStatus: furnishingStatus));
  }

  void changeLandLicence (LandLicenseStatus landLicenseStatus) {
    emit(state.copyWith(landLicenseStatus: landLicenseStatus));
  }


  void changeSelectedCity(String cityId, String cityName) {
    emit(state.copyWith(selectedCityId: cityId , selectedCityName: cityName));
  }

  void changePaymentMethod ( PaymentMethod paymentMethod){
    emit(state.copyWith(currentPaymentMethod: paymentMethod));

  }


  final AddNewApartmentUseCase _addNewApartmentUseCase;
  final AddVillaUseCase _addVillaUseCase;
  final AddNewBuildingUseCase _addNewBuildingUseCase;
  final AddNewLandUseCase _addNewLandUseCase;
  final GetPropertyAmenitiesUseCase _getPropertyAmenitiesUseCase ;


  Future<List<PropertyImage>> _processImages() async {
    return await Future.wait(
      state.selectedImages.asMap().entries.map((entry) async {
        final index = entry.key;
        final img = entry.value;
        return PropertyImage(
          filePath: img.path,
          isMain: index == 0,
        );
      }),
    );
  }

  Map<String, dynamic> _extractCommonFields({required String areaControllerKey}) {
    final String title = addressController.text.trim();
    final String description = descriptionController.text.trim();
    final double price = double.tryParse(priceController.text.trim()) ?? 0;
    final String area = formController.getController(areaControllerKey).text.trim();
      String city = state.selectedCityId;
      String latitude = state.selectedLocation!.latitude.toString();
      String longitude = state.selectedLocation!.longitude.toString();

    final List<String> amenities = state.selectedAmenities;

    return {
      'title': title,
      'description': description,
      'price':state.currentPropertyOperationType.isForSale? price :double.tryParse(rentController.text.trim()) ?? 0 ,
      'area': area,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
      'amenities': amenities,
    };
  }

  //
  // REQUEST MODEL FACTORIES
  //
  Future<ApartmentRequestModel> _getApartmentRequestModel() async {
    final common = _extractCommonFields(areaControllerKey: LocalKeys.apartmentAreaController);
    final bool isFurnitured = state.currentFurnishingStatus.isFurnished;
    final String floor = formController.getController(LocalKeys.apartmentFloorsController).text.trim();
    final String rooms = formController.getController(LocalKeys.apartmentRoomsController).text.trim();
    final String bathrooms = formController.getController(LocalKeys.apartmentBathRoomsController).text.trim();
    final List<PropertyImage> images = await _processImages();

    return ApartmentRequestModel(
      propertySubType: state.currentApartmentType.toId.toString(),
      title: common['title'],
      description: common['description'],
      price: common['price'],
      area: common['area'],
      latitude: common['latitude'],
      longitude: common['longitude'],
      city: common['city'],
      amenities: common['amenities'],
      isFurnitured: isFurnitured,
      floor: floor,
      rooms: rooms,
      bathrooms: bathrooms,
      images: images,
      currentPropertyOperationType: state.currentPropertyOperationType.toRequest,
      monthlyRentPeriod: state.currentPropertyOperationType.isForRent? int.parse(rentDurationController.text) : 0 ,
      isRenewable: state.availableForRenewal,
    );
  }

  Future<VillaRequestModel> _getVillaRequestModel() async {
    final common = _extractCommonFields(areaControllerKey: LocalKeys.villaAreaController);
    final bool isFurnitured = state.currentFurnishingStatus.isFurnished;
    final String numberOfFloors = formController.getController(LocalKeys.villaFloorsController).text.trim();
    final String rooms = formController.getController(LocalKeys.villaRoomsController).text.trim();
    final String bathrooms = formController.getController(LocalKeys.villaBathRoomsController).text.trim();
    final List<PropertyImage> images = await _processImages();
    final String villaSubType = state.currentVillaType.toId.toString();

    return VillaRequestModel(
      propertySubType: villaSubType,
      currentPropertyOperationType: state.currentPropertyOperationType.toRequest,
      title: common['title'],
      description: common['description'],
      price: common['price'],
      images: images,
      city: common['city'],
      latitude: common['latitude'],
      longitude: common['longitude'],
      amenities: common['amenities'],
      area: common['area'],
      isFurnitured: isFurnitured,
      numberOfFloors: int.parse(numberOfFloors),
      rooms: int.parse(rooms),
      bathrooms: int.parse(bathrooms),
      monthlyRentPeriod: state.currentPropertyOperationType.isForRent? int.parse(rentDurationController.text) : 0 ,
      isRenewable: state.availableForRenewal,
    );
  }

  Future<BuildingRequestModel> _getBuildingRequestModel() async {
    final common = _extractCommonFields(areaControllerKey: LocalKeys.buildingAreaController);
    final String numberOfFloorsStr = formController.getController(LocalKeys.buildingFloorsController).text.trim();
    final String numberOfApartmentsStr = formController.getController(LocalKeys.buildingApartmentsPerFloorController).text.trim();
    final List<PropertyImage> images = await _processImages();

    return BuildingRequestModel(
      currentPropertyOperationType: state.currentPropertyOperationType.toRequest,
      title: common['title'],
      description: common['description'],
      price: common['price'],
      images: images,
      city: common['city'],
      latitude: common['latitude'],
      longitude: common['longitude'],
      amenities: common['amenities'],
      area: common['area'],
      numberOfFloors: int.parse(numberOfFloorsStr),
      numberOfApartments: int.parse(numberOfApartmentsStr),
      monthlyRentPeriod: state.currentPropertyOperationType.isForRent? int.parse(rentDurationController.text) : 0 ,
      isRenewable: state.availableForRenewal,
      propertySubType: state.currentBuildingType.toId.toString(),
    );
  }

  Future<LandRequestModel> _getLandRequestModel() async {
    final common = _extractCommonFields(areaControllerKey: LocalKeys.landAreaController);
    final List<PropertyImage> images = await _processImages();
    final bool isLicensed = state.landLicenseStatus.isLicensed;

    return LandRequestModel(
      currentPropertyOperationType: state.currentPropertyOperationType.toRequest,
      title: common['title'],
      description: common['description'],
      price: common['price'],
      images: images,
      city: common['city'],
      latitude: common['latitude'],
      longitude: common['longitude'],
      amenities: common['amenities'],
      area: common['area'],
      isLicensed: isLicensed,
      monthlyRentPeriod: state.currentPropertyOperationType.isForRent? int.parse(rentDurationController.text) : 0 ,
      isRenewable: state.availableForRenewal,
      propertySubType:  state.currentLandType.toId.toString(),
    );
  }


  void addNewApartment(SelectLocationServiceState location) async {
    emit(state.copyWith(addNewApartmentState: RequestState.loading));

    final ApartmentRequestModel requestModel = await _getApartmentRequestModel();
    final Either<Failure, void> result = await _addNewApartmentUseCase(requestModel);

    result.fold(
          (failure) => emit(state.copyWith(
        addNewApartmentState: RequestState.error,
        addNewApartmentErrorMessage: failure.message,
      )),
          (_) => emit(state.copyWith(addNewApartmentState: RequestState.loaded)),
    );
  }

  void addNewVilla(SelectLocationServiceState location) async {
    emit(state.copyWith(addNewApartmentState: RequestState.loading));

    final VillaRequestModel requestModel = await _getVillaRequestModel();
    final Either<Failure, void> result = await _addVillaUseCase(requestModel);

    result.fold(
          (failure) => emit(state.copyWith(
        addNewApartmentState: RequestState.error,
        addNewApartmentErrorMessage: failure.message,
      )),
          (_) => emit(state.copyWith(addNewApartmentState: RequestState.loaded)),
    );
  }

  void addNewBuilding(SelectLocationServiceState location) async {
    emit(state.copyWith(addNewApartmentState: RequestState.loading));

    final BuildingRequestModel requestModel = await _getBuildingRequestModel();
    final Either<Failure, void> result = await _addNewBuildingUseCase(requestModel);

    result.fold(
          (failure) => emit(state.copyWith(
        addNewApartmentState: RequestState.error,
        addNewApartmentErrorMessage: failure.message,
      )),
          (_) => emit(state.copyWith(addNewApartmentState: RequestState.loaded)),
    );
  }

  void addNewLand(SelectLocationServiceState location) async {

    final LandRequestModel requestModel = await _getLandRequestModel();
    emit(state.copyWith(addNewApartmentState: RequestState.loading));
    final Either<Failure, void> result = await _addNewLandUseCase(requestModel);

    result.fold(
          (failure) => emit(state.copyWith(
        addNewApartmentState: RequestState.error,
        addNewApartmentErrorMessage: failure.message,
      )),
          (_) => emit(state.copyWith(addNewApartmentState: RequestState.loaded)),
    );
  }


  /// get amenities


  void getAmenities(String propertyType)async {
    emit(state.copyWith(getAmenitiesState: RequestState.loading , selectedAmenities: []));

    final Either<Failure, List<AmenityEntity>> result = await _getPropertyAmenitiesUseCase(propertyType);

    result.fold(
          (failure) => emit(state.copyWith(getAmenitiesState: RequestState.error)),
          (amenities) {
        emit(state.copyWith(
          getAmenitiesState: RequestState.loaded,
          currentAmenities: amenities,
        ));
      },
    );
  }

  void selectAmenity(String amenityId) {
    final updatedSelectedAmenities = List<String>.from(state.selectedAmenities);
    updatedSelectedAmenities.add(amenityId);
    emit(state.copyWith(selectedAmenities: updatedSelectedAmenities));
  }

  void unSelectAmenity(String amenityId) {
    final updatedSelectedAmenities = List<String>.from(state.selectedAmenities)
      ..remove(amenityId);
    emit(state.copyWith(selectedAmenities: updatedSelectedAmenities));
  }

  @override
  Future<void> close() {
    formController.dispose();
    return super.close();
  }

}
