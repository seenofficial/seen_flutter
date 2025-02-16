import 'package:enmaa/core/components/custom_snack_bar.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../configuration/managers/color_manager.dart';
import '../../../configuration/managers/font_manager.dart';
import '../../../configuration/managers/style_manager.dart';
import '../../../core/components/button_app_component.dart';
import '../../../core/components/svg_image_component.dart';
import '../../../core/constants/app_assets.dart';
import '../models/on_boarding_mdoel.dart';

class OnBoardingPageWidget extends StatelessWidget {
  final OnBoardingPage page;
  final int currentPage;
  final int totalPages;

  const OnBoardingPageWidget({
    super.key,
    required this.page,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.scale(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgImageComponent(
            iconPath: page.image,
            width: 268,
            height: 196,
          ),

          SizedBox(height: context.scale(40)),

          Text(
            page.title,
            textAlign: TextAlign.center,
            style: getBoldStyle(color: ColorManager.blackColor, fontSize: FontSize.s20),
          ),

          SizedBox(height: context.scale(8)),

          Text(
            page.description1,
            textAlign: TextAlign.center,
            maxLines: 3,
            style: getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
          ),

          SizedBox(height: context.scale(2)),

          Text(
            page.description2,
            textAlign: TextAlign.center,
            maxLines: 3,
            style: getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
          ),

          SizedBox(height: context.scale(20)),

          ButtonAppComponent(
            width: 117,
            height: 46,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: ColorManager.whiteColor,
              borderRadius: BorderRadius.circular(context.scale(24)),
              border: Border.all(color: ColorManager.yellowColor, width: 1),
            ),
            buttonContent: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgImageComponent(
                    iconPath: AppAssets.phoneCallIcon,
                    width: 12,
                    height: 12,
                  ),
                  SizedBox(width: context.scale(8)),
                  Text(
                    'تواصل معانا',
                    style: getBoldStyle(color: ColorManager.yellowColor, fontSize: FontSize.s14),
                  ),
                ],
              ),
            ),
            onTap: () async {
              /// TODO: Implement phone call feature


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
    );
  }

}

