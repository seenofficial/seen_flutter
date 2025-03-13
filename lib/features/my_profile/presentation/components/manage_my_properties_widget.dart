import 'package:enmaa/configuration/managers/font_manager.dart';
import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/configuration/routers/app_routers.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/routers/route_names.dart';
import '../../../../core/components/svg_image_component.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../home_module/home_imports.dart';

class ManageMyPropertiesWidget extends StatelessWidget {
  const ManageMyPropertiesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
          Navigator.pushNamed(context, RoutersNames.myPropertiesScreen);
      },
      child: Container(
        width: double.infinity,
        height: context.scale(108),
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'إدارة عقاراتي',
                  style: getBoldStyle(
                      color: ColorManager.primaryColor, fontSize: FontSize.s18),
                ),
                Text(
                  'يمكنك إدارة عقاراتك بكل سهولة.',
                  style: getSemiBoldStyle(
                      color: ColorManager.blackColor, fontSize: FontSize.s14),
                )
              ],
            ),
            Spacer(),
            SvgImageComponent(
              iconPath: AppAssets.myPropertiesIcon,
              width: context.scale(90),
              height: context.scale(64),
            )
          ],
        ),
      ),
    );
  }
}
