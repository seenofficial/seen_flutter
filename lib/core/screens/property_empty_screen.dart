import 'package:enmaa/core/components/svg_image_component.dart';
import 'package:enmaa/core/constants/app_assets.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../configuration/managers/color_manager.dart';
import '../../configuration/managers/font_manager.dart';
import '../../configuration/managers/style_manager.dart';
import '../../features/home_module/home_imports.dart';
import '../components/app_bar_component.dart';
import '../components/button_app_component.dart';
import '../components/custom_snack_bar.dart';

class PropertyEmptyScreen extends StatelessWidget {
  const PropertyEmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.greyShade,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgImageComponent(
              iconPath: AppAssets.propertyEmptyImage,
              width: 250,
              height: 283,
            ),
            SizedBox(
              height: context.scale(8),
            ),
            Text(
              'لم تجد العقار المناسب؟ ',
              style: getBoldStyle(
                color: ColorManager.blackColor,
                fontSize: FontSize.s18,
              ),
            ),
            SizedBox(
              height: context.scale(12),
            ),
            Text(
              'تواصل مع مكتب إنماء للحصول على أفضل الخيارات. سنساعدك في العثور على العقار المناسب لك!',
              textAlign: TextAlign.center,
              style: getMediumStyle(
                color: ColorManager.blackColor,
                fontSize: FontSize.s12,
              ),
            ),
            SizedBox(
              height: context.scale(24),
            ),
            ButtonAppComponent(
              width: 324,
              height: 48,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: ColorManager.primaryColor,
                borderRadius: BorderRadius.circular(context.scale(24)),
              ),
              buttonContent: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgImageComponent(
                      iconPath: AppAssets.phoneCallIcon,
                      color: ColorManager.whiteColor,
                      width: 16,
                      height: 16,
                    ),
                    SizedBox(width: context.scale(8)),
                    Text(
                      'تواصل معانا',
                      style: getBoldStyle(
                        color: ColorManager.whiteColor,
                        fontSize: FontSize.s14,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () async {
                final Uri url = Uri.parse('https://github.com/AmrAbdElHamed26');

                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  CustomSnackBar.show(
                    context: context,
                    message: 'حدث خطأ أثناء فتح الرابط',
                    type: SnackBarType.error,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
