import 'package:enmaa/configuration/routers/route_names.dart';
import 'package:enmaa/core/extensions/context_extension.dart';

import '../../../../../configuration/managers/color_manager.dart';
import '../../../../../configuration/managers/font_manager.dart';
import '../../../../../configuration/managers/style_manager.dart';
import '../../../../../core/components/button_app_component.dart';
import '../../../../../core/components/custom_snack_bar.dart';
import '../../../../home_module/home_imports.dart';

class RealEstateDetailsScreenFooter extends StatelessWidget {
  const RealEstateDetailsScreenFooter({super.key ,required this.propertyId});

  final String propertyId ;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ButtonAppComponent(
          width: 171,
          height: 46,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: ColorManager.whiteColor,
            borderRadius:
            BorderRadius.circular(context.scale(24)),
            border: Border.all(
              color: ColorManager.primaryColor,
              width: 1,
            ),
          ),
          buttonContent: Center(
            child: Text(
              ' معاينة',
              style: getBoldStyle(
                color: ColorManager.primaryColor,
                fontSize: FontSize.s12,
              ),
            ),
          ),
          onTap: () async {
            final result = await Navigator.of(context).pushNamed(
              RoutersNames.previewPropertyScreen,
              arguments: propertyId ,
            );

            if (result == true) {
              CustomSnackBar.show(
                context: context,
                message: 'تم تأكيد موعد معاينتك للعقار، وسيتم التواصل معك في أقرب وقت لتأكيد التفاصيل النهائية.',
                type: SnackBarType.success,
              );
            }
            },
        ),
        ButtonAppComponent(
          width: 171,
          height: 46,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: ColorManager.primaryColor,
            borderRadius:
            BorderRadius.circular(context.scale(24)),
          ),
          buttonContent: Center(
            child: Text(
              'احجز الآن',
              style: getBoldStyle(
                color: ColorManager.whiteColor,
                fontSize: FontSize.s12,
              ),
            ),
          ),
          onTap: () async{

            final result = await Navigator.of(context).pushNamed(
              RoutersNames.bookPropertyScreen,
            );

            if (result == true) {
              CustomSnackBar.show(
                context: context,
                message: 'تم تأكيد موعد معاينتك للعقار، وسيتم التواصل معك في أقرب وقت لتأكيد التفاصيل النهائية.',
                type: SnackBarType.success,
              );
            }

          },
        ),
      ],
    ) ;
  }
}
