import 'package:enmaa/features/real_estates/domain/entities/property_listing_entity.dart';
import 'package:flutter/material.dart';
import 'package:enmaa/configuration/managers/font_manager.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/style_manager.dart';
import '../../../../configuration/routers/route_names.dart';
import '../../../../core/components/custom_image.dart';
import '../../../../core/components/svg_image_component.dart';
import '../../../../core/constants/app_assets.dart';
import '../../home_imports.dart';

class RealStateCardComponent extends StatelessWidget {
  final double width;
  final double height;

  final PropertyListingEntity currentProperty;

  const RealStateCardComponent({
    super.key,
    required this.width,
    required this.height,
    required this.currentProperty,
  });

  @override
  Widget build(BuildContext context) {
    bool isScreenWidth = width == MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true).pushNamed(
            RoutersNames.realEstateDetailsScreen,
            arguments: currentProperty.id);
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(context.scale(12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(context.scale(12)),
                topRight: Radius.circular(context.scale(12)),
              ),
              child: CustomNetworkImage(
                height: context.scale(isScreenWidth ? 172 : 128),
                width: width,
                image: currentProperty.imageUrl,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(context.scale(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentProperty.title,
                    style: getBoldStyle(
                        color: ColorManager.blackColor, fontSize: FontSize.s12),
                  ),
                  SizedBox(height: context.scale(8)),
                  _buildLocationRow(context),
                  SizedBox(height: context.scale(8)),
                  _buildDetailsRow(context),
                  SizedBox(height: context.scale(8)),
                  _buildPriceRow(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable method for building the location row
  Widget _buildLocationRow(BuildContext context) {
    return Row(
      children: [
        SvgImageComponent(
          iconPath: AppAssets.locationIcon,
          width: 12,
          height: 12,
        ),
        SizedBox(width: context.scale(4)),
        Text(
          '${currentProperty.state} - ${currentProperty.city}',
          style: getLightStyle(
              color: ColorManager.blackColor, fontSize: FontSize.s11),
        ),
      ],
    );
  }

  // Reusable method for building the details row
  Widget _buildDetailsRow(BuildContext context) {
    bool isScreenWidth = width == MediaQuery.of(context).size.width;

    return Row(
      children: [
        if (isScreenWidth)
          _buildDetailItem(context, AppAssets.stairsIcon, 'الدور الاول'),
        if (isScreenWidth) _buildVerticalDivider(context),
        _buildDetailItem(
            context, AppAssets.areaIcon, currentProperty.area.toString()),
        _buildVerticalDivider(context),
        _buildDetailItem(
            context, AppAssets.bedIcon, currentProperty.rooms.toString()),
        _buildVerticalDivider(context),
        _buildDetailItem(
            context, AppAssets.bathIcon, currentProperty.bathrooms.toString()),
      ],
    );
  }

  Widget _buildDetailItem(BuildContext context, String iconPath, String text) {
    return Row(
      children: [
        SvgImageComponent(
          iconPath: iconPath,
          width: 12,
          height: 12,
        ),
        SizedBox(width: context.scale(4)),
        Text(
          text,
          style: getBoldStyle(
              color: ColorManager.blackColor, fontSize: FontSize.s10),
        ),
        SizedBox(width: context.scale(16)),
      ],
    );
  }

  Widget _buildVerticalDivider(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.scale(8)),
      child: Container(
        width: 1,
        height: 12,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildPriceRow(BuildContext context) {
    bool isScreenWidth = MediaQuery.of(context).size.width == width;

    return isScreenWidth
        ? Row(
            children: [
              Row(
                children: [
                  Container(
                    width: context.scale(8),
                    height: context.scale(8),
                    decoration: BoxDecoration(
                      color: ColorManager.yellowColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    width: context.scale(4),
                  ),
                  Text('تجاريه',
                      style: getBoldStyle(
                          color: ColorManager.yellowColor,
                          fontSize: FontSize.s12)),
                ],
              ),
              SizedBox(width: context.scale(24)),
              Container(
                width: context.scale(96),
                height: context.scale(28),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 0.50,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: ColorManager.primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgImageComponent(
                      iconPath: AppAssets.rentIcon,
                      width: 12,
                      height: 12,
                    ),
                    Text(
                      currentProperty.operation,
                      style: getMediumStyle(
                          color: ColorManager.primaryColor,
                          fontSize: FontSize.s10),
                    ),
                  ],
                ),
              ),
              SizedBox(width: context.scale(35)),
              Expanded(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: ' تبدأ من  ',
                        style: getRegularStyle(
                            color: ColorManager.primaryColor,
                            fontSize: FontSize.s10),
                      ),
                      TextSpan(
                        text: currentProperty.price,
                        style: getBoldStyle(
                            color: ColorManager.primaryColor,
                            fontSize: FontSize.s12),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        : RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              children: [
                TextSpan(
                  text: ' تبدأ من  ',
                  style: getRegularStyle(
                      color: ColorManager.primaryColor, fontSize: FontSize.s10),
                ),
                TextSpan(
                  text: currentProperty.price,
                  style: getBoldStyle(
                      color: ColorManager.primaryColor, fontSize: FontSize.s12),
                ),
              ],
            ),
          );
  }
}
