import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../configuration/managers/color_manager.dart';
import '../../../../../configuration/managers/font_manager.dart';
import '../../../../../configuration/managers/style_manager.dart';
import '../../../../../core/components/svg_image_component.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../home_module/home_imports.dart';
import '../../../domain/entities/property_details_entity.dart';

class RealEstateDetailsSpecifications extends StatelessWidget {
  const RealEstateDetailsSpecifications({
    super.key,
    required this.currentProperty,
  });

  final PropertyDetailsEntity currentProperty;

  @override
  Widget build(BuildContext context) {
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
          height: context.scale(106),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // First Row of Icons and Text
                _buildRow(
                  children: [
                    _buildItem(
                      iconPath: AppAssets.villaIcon,
                      text: currentProperty.category,
                    ),
                    _buildItem(
                      iconPath: AppAssets.independentPropertyIcon,
                      text: currentProperty.propertyType,
                    ),
                    _buildItem(
                      iconWidget: Container(
                        width: 10,
                        height: 10,
                        decoration: ShapeDecoration(
                          color: ColorManager.greenColor,
                          shape: OvalBorder(),
                        ),
                      ),
                      text: currentProperty.usageType,
                      textStyle: TextStyle(color: ColorManager.greenColor),
                    ),
                  ],
                ),
                SizedBox(height: context.scale(8)),

                // Second Row of Icons and Text
                _buildRow(
                  children: [
                    _buildItem(
                      iconPath: AppAssets.landIcon,
                      text: '${currentProperty.floor} أدوار',
                    ),
                    _buildItem(
                      iconPath: AppAssets.rentIcon,
                      text:currentProperty.operation == 'for_sale'?'للبيع':'للايجار',
                      iconColor: ColorManager.primaryColor,
                    ),
                    _buildItem(
                      iconPath: AppAssets.furnishedIcon,
                      text: currentProperty.furnitureIncluded ? 'مفروشة' : 'غير مفروشة',
                    ),
                  ],
                ),
                SizedBox(height: context.scale(8)),

                // Third Row of Icons and Text
                _buildRow(
                  children: [
                    _buildItem(
                      iconPath: AppAssets.areaIcon,
                      text: '${currentProperty.area} م',
                    ),
                    _buildItem(
                      iconPath: AppAssets.bedIcon,
                      text: currentProperty.rooms.toString(),
                      iconColor: ColorManager.primaryColor,
                    ),
                    _buildItem(
                      iconPath: AppAssets.bathIcon,
                      text: currentProperty.bathrooms.toString(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRow({required List<Widget> children}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children.map((child) {
        return Flexible(
          flex: 1,
          child: Align(
            alignment: Alignment.centerRight,
            child: child,
          ),
        );
      }).toList(),
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