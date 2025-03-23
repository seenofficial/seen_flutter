import 'package:enmaa/core/constants/api_constants.dart';
import 'package:enmaa/core/services/service_locator.dart';
import 'package:enmaa/core/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:enmaa/core/components/custom_bottom_sheet.dart';
import 'package:enmaa/core/components/need_to_login_component.dart';
import 'package:enmaa/core/components/svg_image_component.dart';
import 'package:enmaa/core/constants/app_assets.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/configuration/managers/color_manager.dart';
import 'package:enmaa/configuration/managers/font_manager.dart';
import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/configuration/routers/route_names.dart';
import 'package:enmaa/core/components/button_app_component.dart';
import 'package:enmaa/core/components/custom_snack_bar.dart';
import 'package:enmaa/core/errors/failure.dart';
import 'package:enmaa/core/services/dio_service.dart';
import 'package:enmaa/main.dart';
import '../../../../core/services/handle_api_request_service.dart';

class RemoveAccountWidget extends StatelessWidget {
  const RemoveAccountWidget({super.key});

  Future<void> _deleteAccount(BuildContext context) async {
    final dio = ServiceLocator.getIt<DioService>();

    final result = await HandleRequestService.handleApiCall<void>(
          () async {
        final response = await dio.delete(
          url: ApiConstants.user,
        );

        if (response.statusCode == 200) {
          SharedPreferencesService().clearAllData();
          SharedPreferencesService().setFirstLaunch(false);
          Navigator.pushReplacementNamed(context, RoutersNames.authenticationFlow);
        } else {
          throw ServerFailure.fromResponse(
            response.statusCode,
            response.data,
            response.data,
          );
        }
      },
    );

    // Handle the result
    result.fold(
          (failure) {
        CustomSnackBar.show(
          message: failure.message,
          type: SnackBarType.error,
        );
      },
          (_) {
        CustomSnackBar.show(
          message: 'تم حذف الحساب بنجاح',
          type: SnackBarType.success,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (isAuth) {
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
                widget: DeleteAccountComponent(
                  onDeleteConfirmed: () => _deleteAccount(context),
                ),
                headerText: '',
              );
            },
          );
        } else {
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
              width: 20,
              height: 20,
              iconPath: AppAssets.trashIcon,
            ),
            SizedBox(
              width: context.scale(8),
            ),
            Text(
              'حذف الحساب',
              style: getSemiBoldStyle(
                color: ColorManager.redColor,
                fontSize: FontSize.s16,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}

class DeleteAccountComponent extends StatelessWidget {
  final VoidCallback onDeleteConfirmed;

  const DeleteAccountComponent({super.key, required this.onDeleteConfirmed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgImageComponent(
          width: 80,
          height: 80,
          iconPath: AppAssets.recyclePinIcon,
        ),
        SizedBox(
          height: context.scale(20),
        ),
        Text(
          'هل أنت متأكد من حذف حسابك؟',
          style: getBoldStyle(
            color: ColorManager.blackColor,
            fontSize: FontSize.s18,
          ),
        ),
        SizedBox(
          height: context.scale(4),
        ),
        Text(
          'سيتم حذف بياناتك نهائيًا دون إمكانية استعادتها.',
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: getSemiBoldStyle(
            color: ColorManager.grey2,
            fontSize: FontSize.s14,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonAppComponent(
                width: 171,
                height: 46,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: ColorManager.grey3,
                  borderRadius: BorderRadius.circular(context.scale(24)),
                ),
                buttonContent: Center(
                  child: Text(
                    'إلغاء',
                    style: getMediumStyle(
                      color: ColorManager.blackColor,
                      fontSize: FontSize.s14,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ButtonAppComponent(
                width: 171,
                height: 46,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: ColorManager.redColor,
                  borderRadius: BorderRadius.circular(context.scale(24)),
                ),
                buttonContent: Center(
                  child: Text(
                    'حذف الحساب',
                    style: getBoldStyle(
                      color: ColorManager.whiteColor,
                      fontSize: FontSize.s14,
                    ),
                  ),
                ),
                onTap: () {
                  onDeleteConfirmed();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}