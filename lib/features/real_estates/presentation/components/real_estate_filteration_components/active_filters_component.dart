import 'package:enmaa/core/components/loading_overlay_component.dart';
import 'package:enmaa/core/extensions/request_states_extension.dart';
import 'package:enmaa/core/services/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/services/select_location_service/presentation/controller/select_location_service_cubit.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../home_module/home_imports.dart';
import '../../controller/filter_properties_controller/filter_property_cubit.dart';
import 'package:enmaa/core/extensions/property_sub_types/apartment_type_extension.dart';
import 'package:enmaa/core/extensions/property_sub_types/building_type_extension.dart';
import 'package:enmaa/core/extensions/property_sub_types/land_type_extension.dart';
import 'package:enmaa/core/extensions/property_sub_types/villa_type_extension.dart';
import 'package:enmaa/core/extensions/property_type_extension.dart';
import 'package:flutter/material.dart';
import 'filter_chip_component.dart';


class ActiveFiltersComponent extends StatelessWidget {
  const ActiveFiltersComponent({super.key , required this.selectLocationServiceCubit});

  final SelectLocationServiceCubit selectLocationServiceCubit ;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
  value: selectLocationServiceCubit,
  child: BlocBuilder<SelectLocationServiceCubit, SelectLocationServiceState>(
      builder: (context, locationState) {
        return BlocBuilder<FilterPropertyCubit, FilterPropertyState>(
          builder: (context, filterState) {
            List<String> activeFilters = [];
            bool isForSale = filterState.currentPropertyOperationType == PropertyOperationType.forSale;

            PropertyType? currentPropertyType = isForSale ? filterState.salePropertyType : filterState.rentPropertyType;
            if (currentPropertyType != null) {
              activeFilters.add(currentPropertyType.toArabic);
            }

            // Add furnishing status filters
            List<FurnishingStatus> furnishingStatuses = isForSale
                ? filterState.saleFurnishingStatuses
                : filterState.rentFurnishingStatuses;

            if (furnishingStatuses.isNotEmpty &&
                (currentPropertyType == PropertyType.apartment ||
                    currentPropertyType == PropertyType.villa ||
                    currentPropertyType == null)) {
              for (var status in furnishingStatuses) {
                activeFilters.add(status == FurnishingStatus.furnished ? 'مفروش' : 'غير مفروش');
              }
            }

            // Add land license status filters
            List<LandLicenseStatus> landLicenseStatuses = isForSale
                ? filterState.saleLandLicenseStatuses
                : filterState.rentLandLicenseStatuses;

            if (landLicenseStatuses.isNotEmpty &&
                currentPropertyType == PropertyType.land) {
              for (var status in landLicenseStatuses) {
                activeFilters.add(status == LandLicenseStatus.licensed ? 'جاهزة للبناء' : 'تحتاج إلى تصريح');
              }
            }

            // Add price range filter
            String minPrice = isForSale ? filterState.saleMinPriceValue : filterState.rentMinPriceValue;
            String maxPrice = isForSale ? filterState.saleMaxPriceValue : filterState.rentMaxPriceValue;
            if (minPrice != AppConstants.minPrice || maxPrice != AppConstants.maxPrice) {
              activeFilters.add('$minPrice - $maxPrice جنية');
            }

            // Add area range filter
            String minArea = isForSale ? filterState.saleMinAreaValue : filterState.rentMinAreaValue;
            String maxArea = isForSale ? filterState.saleMaxAreaValue : filterState.rentMaxAreaValue;
            if (minArea != AppConstants.minArea || maxArea != AppConstants.maxArea) {
              activeFilters.add('$minArea - $maxArea م');
            }

            // Add rent-specific filters
            if (!isForSale) {
              if (filterState.rentMinNumberOfMonths != AppConstants.minNumberOfMonths || filterState.rentMaxNumberOfMonths != AppConstants.maxNumberOfMonths) {
                activeFilters.add('${filterState.rentMinNumberOfMonths} - ${filterState.rentMaxNumberOfMonths} شهر');
              }

              if (filterState.rentAvailableForRenewal) {
                activeFilters.add('متاح للتجديد');
              }
            }

            // Add property sub-type filters
            if (currentPropertyType == PropertyType.apartment) {
              List<ApartmentType> apartmentTypes = isForSale
                  ? filterState.saleApartmentTypes
                  : filterState.rentApartmentTypes;

              for (var type in apartmentTypes) {
                activeFilters.add(type.toArabic);
              }
            } else if (currentPropertyType == PropertyType.villa) {
              List<VillaType> villaTypes = isForSale
                  ? filterState.saleVillaTypes
                  : filterState.rentVillaTypes;

              for (var type in villaTypes) {
                activeFilters.add(type.toArabic);
              }
            } else if (currentPropertyType == PropertyType.building) {
              List<BuildingType> buildingTypes = isForSale
                  ? filterState.saleBuildingTypes
                  : filterState.rentBuildingTypes;

              for (var type in buildingTypes) {
                activeFilters.add(type.toArabic);
              }
            } else if (currentPropertyType == PropertyType.land) {
              List<LandType> landTypes = isForSale
                  ? filterState.saleLandTypes
                  : filterState.rentLandTypes;

              for (var type in landTypes) {
                activeFilters.add(type.toArabic);
              }
            }

            // Add location filters (city, country, state)
            if (locationState.selectedCountry != null) {
              activeFilters.add(locationState.selectedCountry!.name);
            }
            if (locationState.selectedState != null) {
              activeFilters.add(locationState.selectedState!.name);
            }
            if (locationState.selectedCity != null) {
              activeFilters.add(locationState.selectedCity!.name);
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: Visibility(
                  visible: activeFilters.isNotEmpty,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: activeFilters.map((filter) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: FilterChipComponent(label: filter),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    ),
);
  }
}