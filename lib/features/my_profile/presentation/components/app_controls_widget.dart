import 'package:dio/dio.dart';
import 'package:enmaa/configuration/managers/font_manager.dart';
import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/core/components/svg_image_component.dart';
import 'package:enmaa/core/constants/app_assets.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/core/services/shared_preferences_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:enmaa/core/translation/locale_keys.dart';
import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/routers/route_names.dart';
import '../../../../core/components/custom_app_switch.dart';
import '../../../../core/components/custom_bottom_sheet.dart';
import '../../../../core/components/custom_snack_bar.dart';
import '../../../../core/components/need_to_login_component.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/services/dio_service.dart';
import '../../../../core/services/handle_api_request_service.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../main.dart';
import '../../../home_module/home_imports.dart';
import 'package:flutter/material.dart';
import 'language_bottom_sheet_component.dart';

class AppControlsWidget extends StatefulWidget {
  const AppControlsWidget({super.key});

  @override
  State<AppControlsWidget> createState() => _AppControlsWidgetState();
}

class _AppControlsWidgetState extends State<AppControlsWidget> {
  bool isDarkModeEnabled = false;
  bool areNotificationsEnabled = SharedPreferencesService().getValue('notifications_enabled') ?? true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.scale(262),
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: ColorManager.greyShade,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                      ),
                      builder: (__) {
                        return CustomBottomSheet(
                          widget: LanguageBottomSheetComponent(),
                          padding: EdgeInsets.zero,
                          iconPath: AppAssets.localizationIcon,
                          headerText: LocaleKeys.appControlsLanguage.tr(),
                        );
                      },
                    );
                  },
                  child: Row(
                    children: [
                      SvgImageComponent(
                        width: 20,
                        height: 20,
                        iconPath: AppAssets.localizationIcon,
                        color: ColorManager.grey,
                      ),
                      SizedBox(width: context.scale(8)),
                      Text(
                        LocaleKeys.appControlsLanguage.tr(),
                        style: getBoldStyle(
                          color: ColorManager.blackColor,
                          fontSize: FontSize.s16,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (isAuth) {
                      Navigator.pushNamed(context, RoutersNames.changePasswordScreen);
                    } else {
                      needToLoginSnackBar();
                    }
                  },
                  child: Row(
                    children: [
                      SvgImageComponent(
                        width: 20,
                        height: 20,
                        iconPath: AppAssets.keyIcon,
                        color: ColorManager.grey,
                      ),
                      SizedBox(width: context.scale(8)),
                      Text(
                        LocaleKeys.changePassword.tr(),
                        style: getBoldStyle(
                          color: ColorManager.blackColor,
                          fontSize: FontSize.s16,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final Uri url = Uri.parse('https://github.com/AmrAbdElHamed26');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    } else {
                      CustomSnackBar.show(
                        message: LocaleKeys.appControlsLinkError.tr(),
                        type: SnackBarType.error,
                      );
                    }
                  },
                  child: Row(
                    children: [
                      SvgImageComponent(
                        width: 20,
                        height: 20,
                        iconPath: AppAssets.privacyIcon,
                        color: ColorManager.grey,
                      ),
                      SizedBox(width: context.scale(8)),
                      Text(
                        LocaleKeys.appControlsTerms.tr(),
                        style: getBoldStyle(
                          color: ColorManager.blackColor,
                          fontSize: FontSize.s16,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
                 Row(
                  children: [
                    SvgImageComponent(
                      width: 20,
                      height: 20,
                      iconPath: AppAssets.themeIcon,
                      color: ColorManager.grey,
                    ),
                    SizedBox(width: context.scale(8)),
                    Text(
                      LocaleKeys.appControlsDarkMode.tr(),
                      style: getBoldStyle(
                        color: ColorManager.blackColor,
                        fontSize: FontSize.s16,
                      ),
                    ),
                    const Spacer(),
                    CustomAppSwitch(
                      value: isDarkModeEnabled,
                      onChanged: (value) {
                        setState(() {
                          isDarkModeEnabled = value;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgImageComponent(
                      width: 20,
                      height: 20,
                      iconPath: AppAssets.notificationIcon,
                      color: ColorManager.grey,
                    ),
                    SizedBox(width: context.scale(8)),
                    Text(
                      LocaleKeys.appControlsNotifications.tr(),
                      style: getBoldStyle(
                        color: ColorManager.blackColor,
                        fontSize: FontSize.s16,
                      ),
                    ),
                    const Spacer(),
                    CustomAppSwitch(
                      value: areNotificationsEnabled,
                      onChanged: (value) {
                        setState(() {
                          areNotificationsEnabled = value;
                        });
                        _updateNotificationAvailability(context, value);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateNotificationAvailability(BuildContext context, bool notificationAvailability) async {
    SharedPreferencesService().storeValue('notifications_enabled', notificationAvailability);

    final dio = ServiceLocator.getIt<DioService>();

    final result = await HandleRequestService.handleApiCall<void>(
          () async {
        final response = await dio.patch(
          url: ApiConstants.user,
          data: FormData.fromMap({
            "notifications_enabled": notificationAvailability,
          }),
          options: Options(contentType: 'multipart/form-data'),
        );
      },
    );

    result.fold(
          (failure) {
        SharedPreferencesService().storeValue('notifications_enabled', false);
        areNotificationsEnabled = false;
        setState(() {});
        CustomSnackBar.show(
          message: failure.message,
          type: SnackBarType.error,
        );
      },
          (_) {},
    );
  }
}