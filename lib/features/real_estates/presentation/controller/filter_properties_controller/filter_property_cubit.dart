import 'package:bloc/bloc.dart';
import 'package:enmaa/core/extensions/operation_type_property_extension.dart';
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

  void changePropertyOperationType(
      PropertyOperationType propertyOperationType) {
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
    List<FurnishingStatus> updatedStatuses = List.from(
        state.selectedFurnishingStatuses);

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

  void toggleLandLicenseStatus(LandLicenseStatus licenseStatus) {
    final updatedStatuses = List<LandLicenseStatus>.from(
        state.selectedLandLicenseStatuses);

    if (updatedStatuses.contains(licenseStatus)) {
      updatedStatuses.remove(licenseStatus);
    } else {
      updatedStatuses.add(licenseStatus);
    }

    emit(state.copyWith(selectedLandLicenseStatuses: updatedStatuses));
  }


  Map<String, dynamic> prepareDataForApi() {
    final locationCubit = ServiceLocator.getIt<SelectLocationServiceCubit>();
    final formController = this.formController;

    final Map<String, dynamic> data = {
      'operation': state.currentPropertyOperationType.isForSale
          ? 'for_sale'
          : 'for_rent',
      'price_min': state.minPriceValue,
      'price_max': state.maxPriceValue,
      'area_min': state.minAreaValue,
      'area_max': state.maxAreaValue,
    };

    // Add monthly rent period if operation is for rent
    if (state.currentPropertyOperationType.isForRent) {
      data['monthly_rent_period_min'] = state.minNumberOfMonths;
      data['monthly_rent_period_max'] = state.maxNumberOfMonths;
    }

    // Add location data if selected
    if (locationCubit.state.selectedCountry != null) {
      data['country'] = locationCubit.state.selectedCountry!.id;
    }
    if (locationCubit.state.selectedState != null) {
      data['state'] = locationCubit.state.selectedState!.id;
    }
    if (locationCubit.state.selectedCity != null) {
      data['city'] = locationCubit.state.selectedCity!.id;
    }

    // Add property type if selected
    if (state.currentPropertyType != null) {
      data['property_type'] = state.currentPropertyType.toString();
    }

    // Add property-specific filters
    if (state.currentPropertyType == PropertyType.apartment) {
      data['apartment_rooms'] =
          formController.getController(LocalKeys.apartmentRoomsController).text;
      data['apartment_bath_rooms'] =
          formController.getController(LocalKeys.apartmentBathRoomsController).text;

      /// todo : floor
      ///
      if(state.selectedFurnishingStatuses.length == 1){
        bool isFurnished = state.selectedFurnishingStatuses.contains(FurnishingStatus.furnished);
        data['apartment_is_furnitured'] = isFurnished;
      }
    } else if (state.currentPropertyType == PropertyType.villa) {
      data['villa_rooms'] =
          formController.getController(LocalKeys.villaRoomsController).text;
      data['villa_bath_rooms'] =
          formController.getController(LocalKeys.villaBathRoomsController).text;
      data['villa_number_of_floors'] =
          formController.getController(LocalKeys.villaFloorsController).text;

      if(state.selectedFurnishingStatuses.length == 1){
        bool isFurnished = state.selectedFurnishingStatuses.contains(FurnishingStatus.furnished);
        data['villa_is_furnitured'] = isFurnished;
      }
    } else if (state.currentPropertyType == PropertyType.building) {
      data['building_number_of_floors'] =
          formController.getController(LocalKeys.buildingFloorsController).text;
      data['number_of_apartments'] =
          formController.getController(LocalKeys.buildingApartmentsPerFloorController).text;
    } else if (state.currentPropertyType == PropertyType.land) {
      if (state.selectedLandLicenseStatuses.length == 1) {
        data['is_licensed'] = state.selectedLandLicenseStatuses.contains(LandLicenseStatus.licensed);
      }
    }
    else {
      // for villa and apartment
      if(state.selectedFurnishingStatuses.isNotEmpty){
        if(state.selectedFurnishingStatuses.length !=2){
          bool isFurnished = state.selectedFurnishingStatuses.contains(FurnishingStatus.furnished);
          data['is_furnitured'] = isFurnished;
        }
      }
    }



    // Add selected sub-types
    if (state.selectedApartmentTypes.isNotEmpty && state.currentPropertyType == PropertyType.apartment) {
      data['apartment_types'] =
          state.selectedApartmentTypes.map((type) => type.toString()).toList();
    }
    if (state.selectedVillaTypes.isNotEmpty && state.currentPropertyType == PropertyType.villa) {
      data['villa_types'] =
          state.selectedVillaTypes.map((type) => type.toString()).toList();
    }
    if (state.selectedBuildingTypes.isNotEmpty && state.currentPropertyType == PropertyType.building) {
      data['building_types'] =
          state.selectedBuildingTypes.map((type) => type.toString()).toList();
    }
    if (state.selectedLandTypes.isNotEmpty && state.currentPropertyType == PropertyType.land) {
      data['land_types'] =
          state.selectedLandTypes.map((type) => type.toString()).toList();
    }

    // Remove null or empty values
    data.removeWhere((key, value) =>
    value == null || value == '' || (value is List && value.isEmpty));

    return data;
  }



    void resetFilters() {
      ServiceLocator.getIt<SelectLocationServiceCubit>().removeSelectedData();
      emit(FilterPropertyState());
    }
  }

