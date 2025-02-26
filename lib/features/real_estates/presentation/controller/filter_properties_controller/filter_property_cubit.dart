import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/components/property_form_controller.dart';
import '../../../../../core/constants/local_keys.dart';
import '../../../../../core/services/select_location_service/presentation/controller/select_location_service_cubit.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../home_module/home_imports.dart';

part 'filter_property_state.dart';

class FilterPropertyCubit extends Cubit<FilterPropertyState> {
  FilterPropertyCubit() : super(FilterPropertyState());

  final PropertyFormController formController = PropertyFormController();
  final formKey = GlobalKey<FormState>();

  void changePropertyOperationType(PropertyOperationType propertyOperationType) {
    emit(state.copyWith(currentPropertyOperationType: propertyOperationType));
  }



  void changePropertyType(PropertyType propertyType) {
    if (state.currentPropertyType == propertyType) {
      emit(state.copyWith(removeCurrentPropertyType: true));
    } else {
      emit(state.copyWith(currentPropertyType: propertyType));
    }
  }

   void toggleApartmentType(ApartmentType apartmentType) {
    List<ApartmentType> updatedTypes = List.from(state.selectedApartmentTypes);

    if (updatedTypes.contains(apartmentType)) {
      updatedTypes.remove(apartmentType);
    } else {
      updatedTypes.add(apartmentType);
    }

    emit(state.copyWith(selectedApartmentTypes: updatedTypes));
  }

   void toggleVillaType(VillaType villaType) {
    List<VillaType> updatedTypes = List.from(state.selectedVillaTypes);

    if (updatedTypes.contains(villaType)) {
      updatedTypes.remove(villaType);
    } else {
      updatedTypes.add(villaType);
    }

    emit(state.copyWith(selectedVillaTypes: updatedTypes));
  }

   void toggleBuildingType(BuildingType buildingType) {
    List<BuildingType> updatedTypes = List.from(state.selectedBuildingTypes);

    if (updatedTypes.contains(buildingType)) {
      updatedTypes.remove(buildingType);
    } else {
      updatedTypes.add(buildingType);
    }

    emit(state.copyWith(selectedBuildingTypes: updatedTypes));
  }

   void toggleLandType(LandType landType) {
    List<LandType> updatedTypes = List.from(state.selectedLandTypes);

    if (updatedTypes.contains(landType)) {
      updatedTypes.remove(landType);
    } else {
      updatedTypes.add(landType);
    }

    emit(state.copyWith(selectedLandTypes: updatedTypes));
  }

  void changeAvailabilityForRenewal() {
    emit(state.copyWith(availableForRenewal: !state.availableForRenewal));
  }

   void toggleFurnishingStatus(FurnishingStatus furnishingStatus) {
    List<FurnishingStatus> updatedStatuses = List.from(state.selectedFurnishingStatuses);

    if (updatedStatuses.contains(furnishingStatus)) {
      updatedStatuses.remove(furnishingStatus);
    } else {
      updatedStatuses.add(furnishingStatus);
    }

    emit(state.copyWith(selectedFurnishingStatuses: updatedStatuses));
  }

  void updatePriceRange(double min, double max) {
    emit(state.copyWith(
      minPriceValue: min.toString(),
      maxPriceValue: max.toString(),
    ));
  }

  void updateAreaRange(double min, double max) {
    emit(state.copyWith(
      minAreaValue: min.toString(),
      maxAreaValue: max.toString(),
    ));
  }


  void updateMinNumberOfMonths(String value) {
    emit(state.copyWith(minNumberOfMonths: value));
  }

  void updateMaxNumberOfMonths(String value) {
    emit(state.copyWith(maxNumberOfMonths: value));
  }


  void printAllData() {
    print('===== Selected Filters =====');
    print('Current Property Operation Type: ${state.currentPropertyOperationType}');
    print('Current Property Type: ${state.currentPropertyType ?? "None"}');

    print('Selected Apartment Types: ${state.selectedApartmentTypes.isEmpty ? "None" : state.selectedApartmentTypes}');
    print('Selected Villa Types: ${state.selectedVillaTypes.isEmpty ? "None" : state.selectedVillaTypes}');
    print('Selected Building Types: ${state.selectedBuildingTypes.isEmpty ? "None" : state.selectedBuildingTypes}');
    print('Selected Land Types: ${state.selectedLandTypes.isEmpty ? "None" : state.selectedLandTypes}');

    print('Available for Renewal: ${state.availableForRenewal}');
    print("min number of months is ${state.minNumberOfMonths}");
    print("max number of months is ${state.maxNumberOfMonths}");

    print ("area is ${state.minAreaValue} to ${state.maxAreaValue}");
    print ("price is ${state.minPriceValue} to ${state.maxPriceValue}");


    print("=======location =====");
    print('Selected Furnishing Statuses: ${state.selectedFurnishingStatuses.isEmpty ? "None" : state.selectedFurnishingStatuses}');
    print("selecte country is ${ServiceLocator.getIt<SelectLocationServiceCubit>().state.selectedCountry}");
    print("selecte state is ${ServiceLocator.getIt<SelectLocationServiceCubit>().state.selectedState}");
    print("selecte city is ${ServiceLocator.getIt<SelectLocationServiceCubit>().state.selectedCity}");



    print('===== Form Controller Values for apartment =====');
    print('apartmentBathRoomsController: ${formController.getController(LocalKeys.apartmentBathRoomsController).text}');
    print('apartmentRoomsController ${formController.getController(LocalKeys.apartmentRoomsController).text}');
    print('apartmentFloorsController ${formController.getController(LocalKeys.apartmentFloorsController).text}');


    print('===== Form Controller Values for villa =====');
    print('villaBathRoomsController: ${formController.getController(LocalKeys.villaBathRoomsController).text}');
    print('villaRoomsController: ${formController.getController(LocalKeys.villaRoomsController).text}');
    print('villaFloorsController: ${formController.getController(LocalKeys.villaFloorsController).text}');

    print('===== Form Controller Values for building =====');
    print('buildingFloorsController: ${formController.getController(LocalKeys.buildingFloorsController).text}');
    print('buildingApartmentsPerFloorController: ${formController.getController(LocalKeys.buildingApartmentsPerFloorController).text}');


  }



  void resetFilters () {
    emit(FilterPropertyState());
  }
}
