import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_constants.dart';
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
  const ActiveFiltersComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterPropertyCubit, FilterPropertyState>(
      builder: (context, state) {
        List<String> activeFilters = [];
        bool isForSale = state.currentPropertyOperationType == PropertyOperationType.forSale;

        PropertyType? currentPropertyType = isForSale ? state.salePropertyType : state.rentPropertyType;
        if (currentPropertyType != null) {
          activeFilters.add(currentPropertyType.toArabic);
        }

        List<FurnishingStatus> furnishingStatuses = isForSale
            ? state.saleFurnishingStatuses
            : state.rentFurnishingStatuses;

        if (furnishingStatuses.isNotEmpty &&
            (currentPropertyType == PropertyType.apartment ||
                currentPropertyType == PropertyType.villa ||
                currentPropertyType == null)) {
          for (var status in furnishingStatuses) {
            activeFilters.add(status == FurnishingStatus.furnished ? 'مفروش' : 'غير مفروش');
          }
        }

        List<LandLicenseStatus> landLicenseStatuses = isForSale
            ? state.saleLandLicenseStatuses
            : state.rentLandLicenseStatuses;

        if (landLicenseStatuses.isNotEmpty &&
            currentPropertyType == PropertyType.land) {
          for (var status in landLicenseStatuses) {
            activeFilters.add(status == LandLicenseStatus.licensed ? 'جاهزة للبناء' : 'تحتاج إلى تصريح');
          }
        }

        String minPrice = isForSale ? state.saleMinPriceValue : state.rentMinPriceValue;
        String maxPrice = isForSale ? state.saleMaxPriceValue : state.rentMaxPriceValue;
        if (minPrice != AppConstants.minPrice || maxPrice != AppConstants.maxPrice) {
          activeFilters.add('$minPrice - $maxPrice جنية');
        }

        String minArea = isForSale ? state.saleMinAreaValue : state.rentMinAreaValue;
        String maxArea = isForSale ? state.saleMaxAreaValue : state.rentMaxAreaValue;
        if (minArea != AppConstants.minArea || maxArea != AppConstants.maxArea) {
          activeFilters.add('$minArea - $maxArea م');
        }

        if (!isForSale) {
          if (state.rentMinNumberOfMonths != AppConstants.minNumberOfMonths || state.rentMaxNumberOfMonths != AppConstants.maxNumberOfMonths) {
            activeFilters.add('${state.rentMinNumberOfMonths} - ${state.rentMaxNumberOfMonths} شهر');
          }

          if (state.rentAvailableForRenewal) {
            activeFilters.add('متاح للتجديد');
          }
        }

        if (currentPropertyType == PropertyType.apartment) {
          List<ApartmentType> apartmentTypes = isForSale
              ? state.saleApartmentTypes
              : state.rentApartmentTypes;

          for (var type in apartmentTypes) {
            activeFilters.add(type.toArabic);
          }
        } else if (currentPropertyType == PropertyType.villa) {
          List<VillaType> villaTypes = isForSale
              ? state.saleVillaTypes
              : state.rentVillaTypes;

          for (var type in villaTypes) {
            activeFilters.add(type.toArabic);
          }
        } else if (currentPropertyType == PropertyType.building) {
          List<BuildingType> buildingTypes = isForSale
              ? state.saleBuildingTypes
              : state.rentBuildingTypes;

          for (var type in buildingTypes) {
            activeFilters.add(type.toArabic);
          }
        } else if (currentPropertyType == PropertyType.land) {
          List<LandType> landTypes = isForSale
              ? state.saleLandTypes
              : state.rentLandTypes;

          for (var type in landTypes) {
            activeFilters.add(type.toArabic);
          }
        }



        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: double.infinity,
            child: Visibility(
              visible: activeFilters.isNotEmpty,
              child: SingleChildScrollView(
                padding: EdgeInsets.zero ,
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
  }
}