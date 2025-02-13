import 'package:enmaa/core/extensions/context_extension.dart';

import '../../../../../configuration/managers/color_manager.dart';
import '../../../../../configuration/managers/font_manager.dart';
import '../../../../../configuration/managers/style_manager.dart';
import '../../../../../core/components/svg_image_component.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../home_module/home_imports.dart';
import '../../../domain/entities/property_details_entity.dart';

class RealEstateDetailsSpecifications extends StatelessWidget {
  const RealEstateDetailsSpecifications({super.key , required this.currentProperty});
  final PropertyDetailsEntity currentProperty ;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "بيانات العقار :",
          style: getBoldStyle(
              color: ColorManager.blackColor,
              fontSize: FontSize.s12),
        ),
        SizedBox(height: context.scale(16)),
        Container(
          width: double.infinity,
          height: context.scale(106),
          decoration: BoxDecoration(
            color: ColorManager.whiteColor,
            borderRadius:
            BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color:
                Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 12),
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                // First Row of Icons and Text
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.start,
                  children: [
                    // First Item
                    Row(
                      children: [
                        SvgImageComponent(
                            iconPath: AppAssets
                                .villaIcon,
                            width: 16,
                            height: 16),
                        SizedBox(width: 8),
                        Text(
                          currentProperty.category
                        ),
                      ],
                    ),
                    Spacer(), // Spacer to push elements to the right
                    // Second Item
                    Row(
                      children: [
                        SvgImageComponent(
                            iconPath: AppAssets
                                .independentPropertyIcon,
                            width: 16,
                            height: 16),
                        SizedBox(width: 8),
                        Text(currentProperty.propertyType),
                      ],
                    ),
                    Spacer(),
                    // Third Item
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration:
                          ShapeDecoration(
                            color: ColorManager
                                .greenColor,
                            shape: OvalBorder(),
                          ),
                        ),
                        SizedBox(width: 8),
                        /// todo : map data
                        Text(
                          currentProperty.usageType,
                          style: TextStyle(
                              color: ColorManager
                                  .greenColor),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                    height: context.scale(8)),

                // Second Row of Icons and Text
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.start,
                  children: [
                    // First Item
                    Row(
                      children: [
                        SvgImageComponent(
                            iconPath: AppAssets
                                .landIcon,
                            width: 16,
                            height: 16),
                        SizedBox(width: 8),
                        Text('${currentProperty.floor} أدوار'),
                      ],
                    ),
                    Spacer(),
                    // Second Item
                    Row(
                      children: [
                        SvgImageComponent(
                          iconPath:
                          AppAssets.rentIcon,
                          width: 16,
                          height: 16,
                          color: ColorManager
                              .primaryColor,
                        ),
                        SizedBox(width: 8),
                        Text(currentProperty.operation),
                      ],
                    ),
                    Spacer(),
                    // Third Item
                    Row(
                      children: [
                        SvgImageComponent(
                            iconPath: AppAssets
                                .furnishedIcon,
                            width: 16,
                            height: 16),
                        SizedBox(width: 8),
                        Text(currentProperty.furnitureIncluded ? 'مفروشة' : 'غير مفروشة'),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                    height: context.scale(8)),

                // Third Row of Icons and Text
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.start,
                  children: [
                    // First Item
                    Row(
                      children: [
                        SvgImageComponent(
                            iconPath: AppAssets
                                .areaIcon,
                            width: 16,
                            height: 16),
                        SizedBox(width: 8),
                        Text('${currentProperty.area} م'),
                      ],
                    ),
                    Spacer(),
                    // Second Item
                    Row(
                      children: [
                        SvgImageComponent(
                          iconPath:
                          AppAssets.bedIcon,
                          width: 16,
                          height: 16,
                          color: ColorManager
                              .primaryColor,
                        ),
                        SizedBox(width: 8),
                        Text(currentProperty.rooms.toString()),
                      ],
                    ),
                    Spacer(),
                    // Third Item
                    Row(
                      children: [
                        SvgImageComponent(
                            iconPath: AppAssets
                                .bathIcon,
                            width: 16,
                            height: 16),
                        SizedBox(width: 8),
                        Text(currentProperty.bathrooms.toString()),
                      ],
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
}
