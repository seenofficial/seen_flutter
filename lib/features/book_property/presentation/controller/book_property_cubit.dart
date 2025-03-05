import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:enmaa/features/book_property/domain/use_cases/get_property_sale_details_use_case.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/services/image_picker_service.dart';
import '../../../../core/utils/enums.dart';
import '../../domain/entities/property_sale_details_entity.dart';

part 'book_property_state.dart';

class BookPropertyCubit extends Cubit<BookPropertyState> {
  BookPropertyCubit(
      this._getPropertySaleDetailsUseCase
      ) : super(BookPropertyState());


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


  final GetPropertySaleDetailsUseCase _getPropertySaleDetailsUseCase ;
  void getPropertySaleDetails(String propertyID){

    emit(state.copyWith(getPropertySaleDetailsState: RequestState.loading));
    _getPropertySaleDetailsUseCase.call(propertyID).then((result) {
      print("rerer ${result}");
      result.fold(
              (failure) => emit(state.copyWith(getPropertySaleDetailsState: RequestState.error, getPropertySaleDetailsError: failure.message)),
              (propertySaleDetails) => emit(state.copyWith(getPropertySaleDetailsState: RequestState.loaded, propertySaleDetailsEntity: propertySaleDetails))
      );
    });


  }

}
