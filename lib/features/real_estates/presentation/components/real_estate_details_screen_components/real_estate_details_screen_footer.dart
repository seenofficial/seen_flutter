import 'package:enmaa/core/extensions/context_extension.dart';

import '../../../../../configuration/managers/color_manager.dart';
import '../../../../../configuration/managers/font_manager.dart';
import '../../../../../configuration/managers/style_manager.dart';
import '../../../../../core/components/button_app_component.dart';
import '../../../../home_module/home_imports.dart';

class RealEstateDetailsScreenFooter extends StatelessWidget {
  const RealEstateDetailsScreenFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ButtonAppComponent(
          width: 171,
          height: 46,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: ColorManager.whiteColor,
            borderRadius:
            BorderRadius.circular(context.scale(24)),
            border: Border.all(
              color: ColorManager.primaryColor,
              width: 1,
            ),
          ),
          buttonContent: Center(
            child: Text(
              ' معاينة',
              style: getBoldStyle(
                color: ColorManager.primaryColor,
                fontSize: FontSize.s12,
              ),
            ),
          ),
          onTap: () {},
        ),
        ButtonAppComponent(
          width: 171,
          height: 46,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: ColorManager.primaryColor,
            borderRadius:
            BorderRadius.circular(context.scale(24)),
          ),
          buttonContent: Center(
            child: Text(
              'احجز الآن',
              style: getBoldStyle(
                color: ColorManager.whiteColor,
                fontSize: FontSize.s12,
              ),
            ),
          ),
          onTap: () {},
        ),
      ],
    ) ;
  }
}
