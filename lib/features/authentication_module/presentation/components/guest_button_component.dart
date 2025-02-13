import 'package:enmaa/core/extensions/context_extension.dart';

import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/font_manager.dart';
import '../../../../configuration/managers/style_manager.dart';
import '../../../../configuration/routers/route_names.dart';
import '../../../../core/components/button_app_component.dart';
import '../../../home_module/home_imports.dart';

class GuestButtonComponent extends StatelessWidget {
  const GuestButtonComponent({super.key});

  void _onGuestLogin(BuildContext context) {
    Navigator.pushNamed(context, RoutersNames.layoutScreen);
  }

  @override
  Widget build(BuildContext context) {
    return ButtonAppComponent(
      width: double.infinity,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(context.scale(24)),
        border: Border.all(
          color: ColorManager.primaryColor,
          width: 1,
        ),
      ),
      buttonContent: Center(
        child: Text(
          'الدخول كزائر',
          style: getBoldStyle(
            color: ColorManager.primaryColor,
            fontSize: FontSize.s14,
          ),
        ),
      ),
      onTap: () => _onGuestLogin(context),
    );
  }
}
