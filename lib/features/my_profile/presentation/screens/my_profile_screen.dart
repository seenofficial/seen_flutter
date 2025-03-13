import 'package:enmaa/configuration/managers/font_manager.dart';
import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/core/components/svg_image_component.dart';
import 'package:enmaa/core/constants/app_assets.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../configuration/managers/color_manager.dart';
import '../../../../core/components/app_bar_component.dart';
import '../../../home_module/home_imports.dart';
import '../components/app_controls_widget.dart';
import '../components/log_out_widget.dart';
import '../components/manage_my_properties_widget.dart';
import '../components/name_and_phone_widget.dart';
import '../components/remove_account_widget.dart';
import '../components/user_screens_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.greyShade,
      body: Column(
        children: [
          const AppBarComponent(
            appBarTextMessage: 'حسابي',
            showNotificationIcon: false,
            showLocationIcon: false,
            centerText: true,
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 12),
              child: SingleChildScrollView(
                child: Column(
                  spacing: context.scale(12),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NameAndPhoneWidget() ,

                    ManageMyPropertiesWidget(),

                    UserScreensWidget(),

                    AppControlsWidget(),

                    LogOutWidget(),


                    RemoveAccountWidget()

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
