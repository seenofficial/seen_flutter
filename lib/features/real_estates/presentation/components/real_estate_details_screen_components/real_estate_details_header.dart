import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/features/real_estates/presentation/controller/real_estate_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../configuration/managers/color_manager.dart';
import '../../../../../configuration/managers/font_manager.dart';
import '../../../../../configuration/managers/style_manager.dart';
import '../../../../../core/components/reserved_component.dart';
import '../../../../../core/components/svg_image_component.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../home_module/home_imports.dart';

class RealEstateDetailsHeader extends StatelessWidget {
  const RealEstateDetailsHeader({
    super.key,
    required this.realEstateDetailsPrice,
    required this.realEstateDetailsLocation,
    required this.realEstateDetailsTitle,
    required this.realEstateDetailsStatus,
  });

  final String realEstateDetailsTitle;

  final String realEstateDetailsPrice;

  final String realEstateDetailsLocation;

  final String realEstateDetailsStatus ;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Expanded(
              child: Text(
                realEstateDetailsTitle,
                overflow: TextOverflow.ellipsis,
                style: getBoldStyle(
                    color: ColorManager.blackColor, fontSize: FontSize.s12),
              ),
            ),

            Visibility(
              visible: realEstateDetailsStatus != 'available',
              child: ReservedComponent(),
            )


          ],
        ),
        SizedBox(height: context.scale(6)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  SvgImageComponent(
                    iconPath: AppAssets.locationIcon,
                    width: 12,
                    height: 12,
                  ),
                  SizedBox(width: context.scale(4)),
                  Expanded(
                    child: Text(
                      realEstateDetailsLocation,
                      overflow: TextOverflow.ellipsis,
                      style: getLightStyle(
                        color: ColorManager.blackColor,
                        fontSize: FontSize.s11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: ' تبدأ من  ',
                        style: getRegularStyle(
                          color: ColorManager.primaryColor,
                          fontSize: FontSize.s10,
                        ),
                      ),
                      TextSpan(
                        text: realEstateDetailsPrice,
                        style: getBoldStyle(
                          color: ColorManager.primaryColor,
                          fontSize: FontSize.s12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
