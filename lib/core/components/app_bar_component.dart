import 'package:enmaa/configuration/managers/font_manager.dart';
import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/core/components/circular_icon_button.dart';
import 'package:enmaa/core/components/custom_bottom_sheet.dart';
import 'package:enmaa/core/constants/app_assets.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:flutter_svg/svg.dart';
import '../../configuration/managers/color_manager.dart';
import '../../features/home_module/home_imports.dart';
import 'package:flutter/material.dart';

import '../screens/select_location_screen.dart';

class AppBarComponent extends StatelessWidget {
  const AppBarComponent({
    super.key,
    required this.appBarTextMessage,
    this.showNotificationIcon = true,
    this.showLocationIcon = true,
    this.showBackIcon = false,
    this.centerText = false,
  });

  final String appBarTextMessage;
  final bool showNotificationIcon;
  final bool showLocationIcon;
  final bool showBackIcon;
  final bool centerText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.scale(110),
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        boxShadow: [
          BoxShadow(
            color: ColorManager.blackColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(context.scale(16)),
          bottomRight: Radius.circular(context.scale(16)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (showBackIcon && centerText)
            Padding(
              padding: EdgeInsets.all(context.scale(16)),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CircularIconButton(
                  containerSize: context.scale(32),
                  iconPath: AppAssets.backIcon,
                  backgroundColor: ColorManager.greyShade,
                ),
              ),
            )
          else if (centerText)
            SizedBox(width: context.scale(64)),
          if (centerText)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!showBackIcon) const SizedBox(width: 32),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: context.scale(16)),
                    child: Text(
                      appBarTextMessage,
                      style: getBoldStyle(color: ColorManager.blackColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(context.scale(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'أهلاً مصعب الشنقيطي، ',
                      style: getBoldStyle(color: ColorManager.blackColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      appBarTextMessage,
                      style: getLightStyle(color: ColorManager.blackColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          if (showLocationIcon)
            Padding(
              padding: EdgeInsets.only(
                right: context.scale(16),
                bottom: context.scale(16),
              ),
              child: InkWell(
                onTap: () {

                  _showLocationPickerBottomSheet(context);
                },
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final String location = 'الرياض';
                    final textPainter = TextPainter(
                      text: TextSpan(
                        text: location,
                        style: getRegularStyle(
                          color: ColorManager.primaryColor,
                          fontSize: FontSize.s10,
                        ),
                      ),
                      maxLines: 1,
                      textDirection: TextDirection.rtl,
                    )..layout();

                    final textWidth = textPainter.width;
                    final containerWidth = textWidth.clamp(65, 120);

                    return Container(
                      height: context.scale(32),
                      width: containerWidth.toDouble(),
                      decoration: BoxDecoration(
                        color: ColorManager.greyShade,
                        borderRadius: BorderRadius.circular(context.scale(16)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                location,
                                overflow: TextOverflow.ellipsis,
                                style: getRegularStyle(
                                  color: ColorManager.primaryColor,
                                  fontSize: FontSize.s10,
                                ),
                              ),
                            ),
                            SizedBox(width: context.scale(8)),
                            SvgPicture.asset(
                              AppAssets.locationIcon,
                              width: context.scale(16),
                              height: context.scale(16),
                              color: ColorManager.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          if (showNotificationIcon)
            Padding(
              padding: EdgeInsets.all(context.scale(16)),
              child: InkWell(
                onTap: () {},
                child: CircularIconButton(
                  containerSize: context.scale(32),
                  iconPath: AppAssets.notificationIcon,
                  backgroundColor: ColorManager.greyShade,
                ),
              ),
            )
          else if (centerText)
            SizedBox(width: context.scale(64)),
        ],
      ),
    );
  }
}

void _showLocationPickerBottomSheet(BuildContext context) {
  final rootContext = Navigator.of(context, rootNavigator: true).context;

  showModalBottomSheet(
    context: rootContext,
    backgroundColor: ColorManager.greyShade,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25),
      ),
    ),
    builder: (context) {
      return CustomBottomSheet(widget: SelectLocationScreen(), headerText: 'حدد موقعك',);
    },
  );
}
