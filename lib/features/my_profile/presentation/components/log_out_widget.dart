import 'package:enmaa/core/extensions/context_extension.dart';

import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/font_manager.dart';
import '../../../../configuration/managers/style_manager.dart';
import '../../../../core/components/svg_image_component.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../home_module/home_imports.dart';

class LogOutWidget extends StatelessWidget {
  const LogOutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          InkWell(onTap: () {}, child: Icon(Icons.arrow_forward_ios))
        ],
      ),
    );
  }
}
