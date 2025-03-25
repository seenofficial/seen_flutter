import 'package:easy_localization/easy_localization.dart';
import 'package:enmaa/configuration/managers/color_manager.dart';
import 'package:enmaa/configuration/managers/font_manager.dart';
import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/core/components/svg_image_component.dart';
import 'package:enmaa/core/constants/app_assets.dart';
import 'package:enmaa/core/extensions/context_extension.dart';

import '../../../../core/services/dateformatter_service.dart';
import '../../../wish_list/favorite_imports.dart';
import '../../domain/entities/notification_entity.dart';

class NotificationComponent extends StatelessWidget {
  final NotificationEntity notification;
  final bool isRead;
  const NotificationComponent({
    super.key,
    required this.notification,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormatterService.getFormattedDate(notification.createdAt);

    return Container(
      height: context.scale(104),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isRead ? ColorManager.whiteColor: ColorManager.primaryColor2,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Container(
                width: context.scale(32),
                height: context.scale(32),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorManager.primaryColor,
                ),
                child: SvgImageComponent(iconPath: AppAssets.envelopeIcon),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  notification.message,
                  maxLines: 2,
                  style: getSemiBoldStyle(
                    color: ColorManager.blackColor,
                    fontSize: FontSize.s14,
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                formattedDate,
                style: getRegularStyle(
                  color: ColorManager.grey2,
                  fontSize: FontSize.s12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}