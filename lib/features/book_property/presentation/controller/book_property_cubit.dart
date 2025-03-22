import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:enmaa/core/constants/local_keys.dart';
import 'package:enmaa/core/extensions/buyer_type_extension.dart';
import 'package:enmaa/core/services/shared_preferences_service.dart';
import 'package:enmaa/features/book_property/domain/entities/book_property_response_entity.dart';
import 'package:enmaa/features/book_property/domain/use_cases/get_property_sale_details_use_case.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/services/image_picker_service.dart';
import '../../../../core/utils/enums.dart';
import '../../../home_module/home_imports.dart';
import '../../data/models/book_property_request_model.dart';
import '../../data/models/book_property_response_model.dart';
import '../../domain/entities/property_sale_details_entity.dart';
import '../../domain/use_cases/book_property_use_case.dart';

part 'book_property_state.dart';

class BookPropertyCubit extends Cubit<BookPropertyState> {

  final TextEditingController phoneNumberController = TextEditingController(text: '+20');
  final TextEditingController nameController = TextEditingController();
  final TextEditingController iDNumberController = TextEditingController();

  BookPropertyCubit(
      this._getPropertySaleDetailsUseCase,
      this._bookPropertyUseCase,
      ) : super(BookPropertyState()){

    nameController.text = SharedPreferencesService().userName ;
    phoneNumberController.text = SharedPreferencesService().userPhone ;
    iDNumberController.text = SharedPreferencesService().getValue(LocalKeys.userIdNumber) ;


    emit(state.copyWith(
      userName: SharedPreferencesService().userName,
      phoneNumber: SharedPreferencesService().userPhone,
      userID: SharedPreferencesService().getValue(LocalKeys.userIdNumber) ?? '',
      birthDate: SharedPreferencesService().getValue(LocalKeys.userDateOfBirth) != null ? DateTime.parse(SharedPreferencesService().getValue(LocalKeys.userDateOfBirth)) : null,
      idExpirationDate: SharedPreferencesService().getValue(LocalKeys.userIdExpirationDate) != null ? DateTime.parse(SharedPreferencesService().getValue(LocalKeys.userIdExpirationDate)) : null,
    ));
  }


  Future<void> selectImage(int numberOfImages,  ) async {
    bool replace = state.selectedImages.isNotEmpty ;

    emit(state.copyWith(
      selectImagesState: RequestState.loading,
    ));

    final ImagePickerHelper imagePickerHelper = ImagePickerHelper();

    final result = await imagePickerHelper.pickImages(
      maxImages: numberOfImages,
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

         final List<File> updatedImages = replace
            ? processedFiles
            : [...state.selectedImages, ...processedFiles];

        emit(state.copyWith(
          selectImagesState: RequestState.loaded,
          validateImages: true,
          selectedImages: updatedImages,
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


  void changeBuyerType(BuyerType buyerType) {
    emit(state.copyWith(buyerType: buyerType));
  }

  void setUserName(String userName) {
    emit(state.copyWith(userName: userName));
  }

  void setIDUserNumber(String userID) {
    emit(state.copyWith(userID: userID));
  }

  void setPhoneNumber(String phoneNumber) {
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  void setCountryCode(String countryCode) {
    phoneNumberController.text = countryCode;
    emit(state.copyWith(countryCode: countryCode));
  }



  void changeBirthDatePickerVisibility() {
    emit(state.copyWith(showBirthDatePicker: !state.showBirthDatePicker, showIDExpirationDatePicker: false));
  }

  void selectBirthDate(DateTime date) {
    emit(state.copyWith(birthDate: date, showBirthDatePicker: false));
  }

   void changeIDExpirationDatePickerVisibility() {
    emit(state.copyWith(showIDExpirationDatePicker: !state.showIDExpirationDatePicker, showBirthDatePicker: false));
  }

  void selectIDExpirationDate(DateTime date) {
    emit(state.copyWith(idExpirationDate: date, showIDExpirationDatePicker: false));
  }

  void changePaymentMethod(String method) {
    emit(state.copyWith(currentPaymentMethod: method));
  }





  final GetPropertySaleDetailsUseCase _getPropertySaleDetailsUseCase ;
  final BookPropertyUseCase _bookPropertyUseCase ;
  void getPropertySaleDetails(String propertyID){

    emit(state.copyWith(getPropertySaleDetailsState: RequestState.loading));
    _getPropertySaleDetailsUseCase.call(propertyID).then((result) {
      result.fold(
              (failure) => emit(state.copyWith(getPropertySaleDetailsState: RequestState.error, getPropertySaleDetailsError: failure.message)),
              (propertySaleDetails) => emit(state.copyWith(getPropertySaleDetailsState: RequestState.loaded, propertySaleDetailsEntity: propertySaleDetails))
      );
    });


  }


  Future<void> bookProperty(String propertyId) async {
    emit(state.copyWith(bookPropertyState: RequestState.loading));

    final String dateOfBirth = state.birthDate != null
        ? "${state.birthDate!.year}-${state.birthDate!.month.toString().padLeft(
        2, '0')}-${state.birthDate!.day.toString().padLeft(2, '0')}"
        : "";

    final String idExpiryDate = state.idExpirationDate != null
        ? "${state.idExpirationDate!.year}-${state.idExpirationDate!.month
        .toString().padLeft(2, '0')}-${state.idExpirationDate!.day.toString()
        .padLeft(2, '0')}"
        : "";

    final bookPropertyRequest = BookPropertyRequestModel(
      propertyId: propertyId,
      isUser: state.buyerType.amIABuyer,
      name: state.userName,
      phoneNumber: state.phoneNumber,
      idNumber: state.userID,
      dateOfBirth: dateOfBirth,
      idExpiryDate: idExpiryDate,
      paymentMethod: state.currentPaymentMethod == 'المحفظة'
          ? 'wallet'
          : 'credit',
      idImage: state.selectedImages[0],

    );

    final result = await _bookPropertyUseCase.call(bookPropertyRequest);

    result.fold(
          (failure) => emit(state.copyWith(
          bookPropertyState: RequestState.error,
          bookPropertyError: failure.message)),
          (response) => emit(state.copyWith(
          bookPropertyState: RequestState.loaded,
          bookPropertyResponse: response)),
    );
  }

  @override
  Future<void> close() {
    phoneNumberController.dispose();
    nameController.dispose();
    iDNumberController.dispose();
    return super.close();
  }

}
