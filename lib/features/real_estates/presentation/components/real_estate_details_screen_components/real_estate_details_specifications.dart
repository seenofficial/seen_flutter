  import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/features/real_estates/domain/entities/apartment_details_entity.dart';
import 'package:enmaa/features/real_estates/domain/entities/builidng_details_entity.dart';
import 'package:enmaa/features/real_estates/domain/entities/land_details_entity.dart';
import 'package:enmaa/features/real_estates/domain/entities/property_details_entity.dart';
import 'package:enmaa/features/real_estates/domain/entities/villa_details_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../configuration/managers/color_manager.dart';
  import '../../../../../configuration/managers/font_manager.dart';
  import '../../../../../configuration/managers/style_manager.dart';
  import '../../../../../core/components/svg_image_component.dart';
  import '../../../../../core/constants/app_assets.dart';


  class RealEstateDetailsSpecifications extends StatelessWidget {
    const RealEstateDetailsSpecifications({
      super.key,
      required this.currentProperty,
    });

    final BasePropertyDetailsEntity currentProperty;

    @override
    Widget build(BuildContext context) {
      // Determine the type of currentProperty
      final isVilla = currentProperty is VillaDetailsEntity;
      final isApartment = currentProperty is ApartmentDetailsEntity;
      final isLand = currentProperty is LandDetailsEntity;
      final isBuilding = currentProperty is BuildingDetailsEntity;

      // Cast to the appropriate type
      final villa = isVilla ? currentProperty as VillaDetailsEntity : null;
      final apartment = isApartment ? currentProperty as ApartmentDetailsEntity : null;
      final land = isLand ? currentProperty as LandDetailsEntity : null;
      final building = isBuilding ? currentProperty as BuildingDetailsEntity : null;

      // Generate the list of specifications based on the property type
      final List<Map<String, String>> specifications = _getSpecifications(
        villa: villa,
        apartment: apartment,
        land: land,
        building: building,
      );

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "بيانات العقار :",
            style: getBoldStyle(
              color: ColorManager.blackColor,
              fontSize: FontSize.s12,
            ),
          ),
          SizedBox(height: context.scale(16)),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: ColorManager.whiteColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: _buildSpecificationsGrid(specifications),
          ),
        ],
      );
    }

    List<Map<String, String>> _getSpecifications({
      VillaDetailsEntity? villa,
      ApartmentDetailsEntity? apartment,
      LandDetailsEntity? land,
      BuildingDetailsEntity? building,
    }) {

      /// todo : i want to add items for rent operation
      if (villa != null) {
        return [
          {'icon': AppAssets.villaIcon, 'text': 'Villa'},
          {'icon': AppAssets.independentPropertyIcon, 'text': villa.propertySubType},
          {'icon': villa.isFurnished ? AppAssets.furnishedIcon : AppAssets.emptyIcon, 'text': villa.isFurnished ? 'مفروش' : 'غير مفروش'},
          {'icon': AppAssets.areaIcon, 'text': villa.area.toString()},
          {'icon': AppAssets.forSellIcon, 'text': villa.operation == 'for_rent' ? 'للايجار' : 'للبيع'},
          {'icon': AppAssets.landIcon, 'text': '${villa.numberOfFloors} طوابق'},
          {'icon': AppAssets.bedIcon, 'text': villa.rooms.toString()},
          {'icon': AppAssets.bathIcon, 'text': villa.bathrooms.toString()},
        ];
      } else if (apartment != null) {
        return [
          {'icon': AppAssets.apartmentIcon, 'text': 'Apartment'},
          {'icon': AppAssets.twinHouseIcon, 'text': apartment.propertySubType},
          {'icon': apartment.isFurnished ? AppAssets.furnishedIcon : AppAssets.emptyIcon, 'text': apartment.isFurnished ? 'مفروش' : 'غير مفروش'},
          {'icon': AppAssets.areaIcon, 'text': apartment.area.toString()},
          {'icon': AppAssets.forSellIcon, 'text': apartment.operation == 'for_rent' ? 'للايجار' : 'للبيع'},
          {'icon': AppAssets.landIcon, 'text': '${apartment.floor} الدور'},
          {'icon': AppAssets.bedIcon, 'text': apartment.rooms.toString()},
          {'icon': AppAssets.bathIcon, 'text': apartment.bathrooms.toString()},
        ];
      } else if (building != null) {
        return [
          {'icon': AppAssets.residentialBuildingIcon, 'text': 'Building'},
          {'icon': AppAssets.twinHouseIcon, 'text': building.propertySubType},
          {'icon': AppAssets.areaIcon, 'text': building.area.toString()},
          {'icon': AppAssets.forSellIcon, 'text': building.operation == 'for_rent' ? 'للايجار' : 'للبيع'},
          {'icon': AppAssets.landIcon, 'text': '${building.numberOfFloors} طوابق'},
          {'icon': AppAssets.apartmentIcon, 'text': building.numberOfFloors.toString()},
        ];
      } else if (land != null) {
        return [
          {'icon': AppAssets.landIcon, 'text': 'أرض'},
          {'icon': AppAssets.independentPropertyIcon, 'text': land.propertySubType},
          {'icon': AppAssets.areaIcon, 'text': land.area.toString()},
          {'icon': AppAssets.forSellIcon, 'text': land.operation == 'for_rent' ? 'للايجار' : 'للبيع'},
          {'icon': AppAssets.readyForBuilding, 'text': land.isLicensed ? 'جاهزة للبناء' : 'غير جاهزة للبناء'},
        ];
      } else {
        return [];
      }
    }

    Widget _buildSpecificationsGrid(List<Map<String, String>> specifications) {
      return GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 0,
          childAspectRatio: 3.5,
        ),
        itemCount: specifications.length,
        itemBuilder: (context, index) {
          final item = specifications[index];
          return _buildItem(
            iconPath: item['icon'],
            text: item['text']!,
          );
        },
      );
    }

    Widget _buildItem({
      String? iconPath,
      Widget? iconWidget,
      required String text,
      Color? iconColor,
      TextStyle? textStyle,
    }) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          iconWidget ??
              SvgImageComponent(
                iconPath: iconPath!,
                width: 16,
                height: 16,
                color: iconColor,
              ),
          SizedBox(width: 8),
          Text(
            text,
            style: textStyle ?? getRegularStyle(
              color: ColorManager.blackColor,
              fontSize: FontSize.s10,
            ),
          ),
        ],
      );
    }
  }