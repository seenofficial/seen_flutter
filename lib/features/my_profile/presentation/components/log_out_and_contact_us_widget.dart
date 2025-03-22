import 'package:enmaa/configuration/routers/route_names.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/font_manager.dart';
import '../../../../configuration/managers/style_manager.dart';
import '../../../../core/components/svg_image_component.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../main.dart';
import '../../../home_module/home_imports.dart';

class LogOutAndContactUsWidget extends StatelessWidget {
  const LogOutAndContactUsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.scale(112),
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: ()async{
              final prefs = await SharedPreferences.getInstance();
              isAuth = false;
              prefs.clear();
              Navigator.pushReplacementNamed(context, RoutersNames.authenticationFlow);
            },
            child: Row(
              children: [
                SvgImageComponent(
                    width: 20, height: 20, iconPath: AppAssets.logOutIcon),
                SizedBox(
                  width: context.scale(8),
                ),
                Text(
                  'تسجيل الخروج',
                  style: getSemiBoldStyle(
                      color: ColorManager.blackColor, fontSize: FontSize.s16),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RoutersNames.contactUsScreen);
            },
            child: Row(
              children: [
                SvgImageComponent(
                    width: 20, height: 20, iconPath: AppAssets.phoneIcon),
                SizedBox(
                  width: context.scale(8),
                ),
                Text(
                  'تواصل معنا',
                  style: getSemiBoldStyle(
                      color: ColorManager.blackColor, fontSize: FontSize.s16),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
