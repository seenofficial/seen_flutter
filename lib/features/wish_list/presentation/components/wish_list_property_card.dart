import 'package:enmaa/core/extensions/furnished_status_extension.dart';
import 'package:enmaa/core/extensions/land_license_status_extension.dart';
import 'package:enmaa/features/wish_list/presentation/controller/wish_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:enmaa/configuration/managers/font_manager.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/style_manager.dart';
import '../../../../configuration/routers/route_names.dart';
import '../../../../core/components/circular_icon_button.dart';
import '../../../../core/components/custom_image.dart';
import '../../../../core/components/svg_image_component.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/enums.dart';
import '../../../real_estates/domain/entities/apartment_entity.dart';
import '../../../real_estates/domain/entities/base_property_entity.dart';
import '../../../real_estates/domain/entities/building_entity.dart';
import '../../../real_estates/domain/entities/land_entity.dart';
import '../../../real_estates/domain/entities/villa_entity.dart';

class WishListPropertyCard extends StatelessWidget {
  final PropertyEntity currentProperty;
  final String wishListId;

  const WishListPropertyCard({
    super.key,
    required this.currentProperty,
    required this.wishListId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(context.scale(12)),
      ),
      child: Stack(
        children: [
          InkWell(
            onTap: (){
              Navigator.of(context, rootNavigator: true).pushNamed(
                RoutersNames.realEstateDetailsScreen,
                arguments: currentProperty.id,
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(context.scale(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentProperty.title,
                          style: getBoldStyle(
                            color: ColorManager.blackColor,
                            fontSize: FontSize.s14,
                          ),
                          maxLines: 2,
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
                ),
                SizedBox(width: context.scale(8)),
                 ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(context.scale(12),), bottomLeft: Radius.circular(context.scale(12),)),
                  child: CustomNetworkImage(
                    height: context.scale(162),
                    width: context.scale(161),
                    image: currentProperty.image,
                  ),
                ),

              ],
            ),
          ),
          PositionedDirectional(
            top: context.scale(8),
            end: context.scale(8),
            child: CircularIconButton(
              containerSize: 40,
              iconSize: 20,
              iconPath: AppAssets.selectedHeartIcon,
              onPressed: () {
                /// todo : remove property from wishlist

                context.read<WishListCubit>().removePropertyFromWishList(wishListId);
              },
            ),
          ),
        ],
      ),
    );
  }

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
          '${currentProperty.state.name} - ${currentProperty.city.name}',
          style: getMediumStyle(
              color: ColorManager.blackColor, fontSize: FontSize.s12),
        ),
      ],
    );
  }

  Widget _buildDetailsRow(BuildContext context) {
    if (currentProperty.propertyType == 'apartment') {
      var rooms = (currentProperty as ApartmentEntity).rooms;
      var bathrooms = (currentProperty as ApartmentEntity).bathrooms;

      return Row(
        children: [
          _buildDetailItem(
              context, AppAssets.areaIcon, currentProperty.area.toString()),
          _buildVerticalDivider(context),

          _buildDetailItem(
              context, AppAssets.bedIcon, rooms.toString()),
          _buildVerticalDivider(context),
          _buildDetailItem(
              context, AppAssets.bathIcon,  bathrooms.toString()),
        ],
      );
    } else if (currentProperty.propertyType == 'land') {
      LandLicenseStatus landLicenseStatus = (currentProperty as LandEntity).isLicensed == true ? LandLicenseStatus.licensed : LandLicenseStatus.notLicensed;
      return Row(
        children: [
          _buildDetailItem(
              context, AppAssets.areaIcon, currentProperty.area.toString()),
          _buildVerticalDivider(context),



          _buildDetailItem(
              context, AppAssets.readyForBuilding, landLicenseStatus.toArabic),


        ],
      );
    } else if (currentProperty.propertyType == 'villa') {
       var rooms = (currentProperty as VillaEntity).rooms;
      var bathrooms = (currentProperty as VillaEntity).bathrooms;

      return Row(
        children: [
          _buildDetailItem(
              context, AppAssets.areaIcon, currentProperty.area.toString()),
          _buildVerticalDivider(context),




          _buildDetailItem(
              context, AppAssets.bedIcon, rooms.toString()),
          _buildVerticalDivider(context),
          _buildDetailItem(
              context, AppAssets.bathIcon,  bathrooms.toString()),
        ],
      );
    } else {
       var apartmentPerFloor = (currentProperty as BuildingEntity).apartmentPerFloor;
      return Row(
        children: [
          _buildDetailItem(
              context, AppAssets.areaIcon, currentProperty.area.toString()),
          _buildVerticalDivider(context),


          _buildDetailItem(
              context, AppAssets.apartmentIcon, ' $apartmentPerFloor  / طابق '),

        ],
      );
    }
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
        SizedBox(width: context.scale(5)),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            children: [
              TextSpan(
                text: ' تبدأ من  ',
                style: getRegularStyle(
                    color: ColorManager.primaryColor,
                    fontSize: FontSize.s12),
              ),
              TextSpan(
                text: currentProperty.price,
                style: getBoldStyle(
                    color: ColorManager.primaryColor,
                    fontSize: FontSize.s16),
              ),
            ],
          ),
        )
      ],
    );
  }
}