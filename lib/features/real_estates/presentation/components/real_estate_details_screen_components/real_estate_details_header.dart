import 'package:enmaa/core/extensions/context_extension.dart';

import '../../../../../configuration/managers/color_manager.dart';
import '../../../../../configuration/managers/font_manager.dart';
import '../../../../../configuration/managers/style_manager.dart';
import '../../../../../core/components/svg_image_component.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../home_module/home_imports.dart';

class RealEstateDetailsHeader extends StatelessWidget {
  const RealEstateDetailsHeader({
    super.key ,
    required this.realEstateDetailsPrice,
    required this.realEstateDetailsLocation,
    required this.realEstateDetailsTitle,
  });

  final String realEstateDetailsTitle ;
  final String realEstateDetailsPrice ;
  final String realEstateDetailsLocation ;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          realEstateDetailsTitle,
          style: getBoldStyle(
              color: ColorManager.blackColor, fontSize: FontSize.s12),
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
                  Text(
    realEstateDetailsLocation,
                    style: getLightStyle(
                      color: ColorManager.blackColor,
                      fontSize: FontSize.s11,
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
