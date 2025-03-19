import 'package:enmaa/configuration/routers/route_names.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/font_manager.dart';
import '../../../../configuration/managers/style_manager.dart';
import '../../../../core/components/need_to_login_component.dart';
import '../../../../core/components/svg_image_component.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../home_module/home_imports.dart';

class RemoveAccountWidget extends StatelessWidget {
  const RemoveAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()async{
        if(isAuth) {
          final prefs = await SharedPreferences.getInstance();
          prefs.remove('access_token');
          Navigator.pushReplacementNamed(context, RoutersNames.authenticationFlow);
        }
        else {
          needToLoginSnackBar();
        }

      },
      child: Container(
        width: double.infinity,
        height: context.scale(54),
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            SvgImageComponent(
                width: 20, height: 20, iconPath: AppAssets.trashIcon),
            SizedBox(
              width: context.scale(8),
            ),
            Text(
              'حذف الحساب',
              style: getSemiBoldStyle(
                  color: ColorManager.redColor, fontSize: FontSize.s16),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
