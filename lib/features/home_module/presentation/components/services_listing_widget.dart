import 'package:enmaa/configuration/managers/color_manager.dart';
import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/configuration/managers/value_manager.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/features/home_module/presentation/components/real_state_card_component.dart';

import '../../home_imports.dart';

class ServicesListingWidget extends StatelessWidget {
  const ServicesListingWidget({super.key , required this.seeMoreAction , required this.listingWidget});

  final Function() seeMoreAction;
  final Widget listingWidget ;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // header of service

        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.scale(AppPadding.p16)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'عقارات بالقرب منك',
                style: getBoldStyle(color: ColorManager.blackColor),
              ),
              InkWell(
                  onTap: seeMoreAction,
                  child: Text(
                    'عرض الكل',
                    style: getUnderlineRegularStyle(
                        color: ColorManager.blackColor),
                  ))
            ],
          ),
        ) ,

        // list cards

        SizedBox(height: context.scale(12),),

        listingWidget ,
      ],
    );
  }
}
