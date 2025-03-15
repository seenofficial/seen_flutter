import 'package:enmaa/configuration/routers/route_names.dart';
import 'package:enmaa/core/components/svg_image_component.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import '../../configuration/managers/color_manager.dart';
import '../../configuration/managers/font_manager.dart';
import '../../configuration/managers/style_manager.dart';
import '../../features/home_module/home_imports.dart';
import '../components/button_app_component.dart';
import '../components/circular_icon_button.dart';
import '../constants/app_assets.dart';

class ErrorAppScreen extends StatelessWidget {
  const ErrorAppScreen({
    super.key,
    this.showBackButton = true,
    this.showActionButton = true,
    this.backgroundColor,
  });

  final bool showBackButton;
  final bool showActionButton;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? ColorManager.whiteColor,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Stack(
              children: [
                if (showBackButton)
                  PositionedDirectional(
                    top: context.scale(50),
                    start: context.scale(16),
                    child: CircularIconButton(
                      iconPath: AppAssets.backIcon,
                      containerSize: context.scale(32),
                      iconSize: context.scale(20),
                      backgroundColor: ColorManager.greyShade,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgImageComponent(
                        iconPath: AppAssets.errorImage,
                        width: constraints.maxWidth ,
                        height: constraints.maxHeight * 0.6,
                      ),
                      SizedBox(height: context.scale(24)),
                      Text(
                        'حدث خطأ غير متوقع',
                        style: getBoldStyle(
                          color: ColorManager.blackColor,
                          fontSize: FontSize.s18,
                        ),
                      ),
                      SizedBox(height: context.scale(8)),
                      Text(
                        'يبدو أن هناك مشكلة، يرجى المحاولة مرة أخرى لاحقًا.',
                        style: getMediumStyle(
                          color: ColorManager.grey,
                          fontSize: FontSize.s12,
                        ),
                      ),
                      SizedBox(height: context.scale(24)),
                      if (showActionButton)
                        ButtonAppComponent(
                          width: 324,
                          height: 48,
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            color: ColorManager.primaryColor,
                            borderRadius:
                            BorderRadius.circular(context.scale(24)),
                          ),
                          buttonContent: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgImageComponent(
                                  iconPath: AppAssets.backIcon,
                                  color: ColorManager.whiteColor,
                                ),
                                SizedBox(width: context.scale(8)),
                                Text(
                                  'العودة إلى الصفحة الرئيسية',
                                  style: getBoldStyle(
                                    color: ColorManager.whiteColor,
                                    fontSize: FontSize.s14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .popUntil(ModalRoute.withName(
                                RoutersNames.layoutScreen));
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}