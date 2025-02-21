import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:enmaa/core/constants/local_keys.dart';
import 'package:enmaa/core/extensions/furnished_status_extension.dart';
import 'package:enmaa/core/extensions/operation_type_property_extension.dart';
import 'package:enmaa/core/extensions/property_type_extension.dart';
import 'package:enmaa/core/services/select_location_service/presentation/controller/select_location_service_cubit.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/apartment_request_model.dart';
import 'package:enmaa/features/add_new_real_estate/domain/use_cases/add_new_apartment_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/components/property_form_controller.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/image_picker_service.dart';
import '../../../../core/utils/enums.dart';
import '../../../home_module/home_imports.dart';
import '../../data/models/property_request_model.dart';

part 'add_new_real_estate_state.dart';

class AddNewRealEstateCubit extends Cubit<AddNewRealEstateState> {
  AddNewRealEstateCubit(
      this._addNewApartmentUseCase ,
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

  void changePropertyType(PropertyType propertyType) {
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


  final AddNewApartmentUseCase _addNewApartmentUseCase ;


  Future<ApartmentRequestModel> _getApartmentRequestModel() async{
    final String title = addressController.text.trim();
    final String description = descriptionController.text.trim();
    final String priceStr = priceController.text.trim();
    final double price = double.tryParse(priceStr) ?? 0;
    final String area = formController.getController(LocalKeys.apartmentAreaController).text.trim();
    /// todo : not here
    final String usageType = 'residential';
    /// todo : how can i gt this
    final String status = "available";


    /// todo get id from back
    final String city = '1';

    ///todo get amenities from back
    final List<String> amenities = <String>['1', '2'];


    final bool isFurnitured = state.currentFurnishingStatus.isFurnished ;

    final String floor = formController.getController(LocalKeys.apartmentFloorsController).text.trim();
    final String rooms = formController.getController(LocalKeys.apartmentRoomsController).text.trim();
    final String bathrooms = formController.getController(LocalKeys.apartmentBathRoomsController).text.trim();

    final List<PropertyImage> images = await Future.wait(
      state.selectedImages.asMap().entries.map((entry) async {
        final index = entry.key;
        final img = entry.value;
        return PropertyImage(
          filePath: img.path,
          isMain: index == 0,
        );
      }),
    );


    ApartmentRequestModel apartmentRequestModel = ApartmentRequestModel(

      title: title,
      description: description,
      price: price,
      area: area,
      usageType: usageType,
      status: status,
      latitude: '12',
      longitude: '32',
      city: city,
      amenities: amenities,
      isFurnitured: isFurnitured,
      floor: floor,
      rooms: rooms,
      bathrooms: bathrooms,
      yearBuilt: 2023,
      images: images,


      currentPropertyOperationType: state.currentPropertyOperationType.toRequest,
      country: '1',
      state: '2',
      apartmentType: 1,
    );

    return apartmentRequestModel;
  }


  void addNewApartment(SelectLocationServiceState location) async {

    emit(state.copyWith(addNewApartmentState: RequestState.loading));


    final ApartmentRequestModel apartmentRequestModel = await _getApartmentRequestModel();
    final Either<Failure, void> result = await _addNewApartmentUseCase(apartmentRequestModel);

    result.fold(
          (failure) => emit(state.copyWith(
        addNewApartmentState: RequestState.error,
        addNewApartmentErrorMessage: failure.message,
      )),
          (__) => emit(state.copyWith(
        addNewApartmentState: RequestState.loaded,
      )),
    );
  }




  @override
  Future<void> close() {
    formController.dispose();
    return super.close();
  }

}
