import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/components/property_form_controller.dart';
import '../../../../core/utils/enums.dart';
import '../../../home_module/home_imports.dart';

part 'add_new_real_estate_state.dart';

class AddNewRealEstateCubit extends Cubit<AddNewRealEstateState> {
  AddNewRealEstateCubit() : super(AddNewRealEstateState());

  final PropertyFormController formController = PropertyFormController();
  final formKey = GlobalKey<FormState>();
  final priceForm = GlobalKey<FormState>();
  final locationForm = GlobalKey<FormState>();

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


  @override
  Future<void> close() {
    formController.dispose();
    return super.close();
  }

}
