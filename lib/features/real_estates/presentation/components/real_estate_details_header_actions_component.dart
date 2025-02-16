import 'package:enmaa/core/extensions/context_extension.dart';

import '../../../../core/components/circular_icon_button.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../home_module/home_imports.dart';

class RealEstateDetailsHeaderActionsComponent extends StatelessWidget {
  const RealEstateDetailsHeaderActionsComponent({super.key});

  final double containerSize = 32;
  final double iconSize = 16;
  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircularIconButton(
          iconPath: AppAssets.backIcon,
          containerSize: context.scale(containerSize),
          iconSize: iconSize,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        Row(
          children: [
            CircularIconButton(
              iconPath: AppAssets.shareIcon,
              containerSize: context.scale(containerSize),
              iconSize: context.scale(iconSize),
              onPressed: () {},
            ),
            SizedBox(width: context.scale(16)),
            CircularIconButton(
              iconPath: AppAssets.heartIcon,
              containerSize: context.scale(containerSize),
              iconSize: context.scale(iconSize),
              onPressed: () {},
            ),
          ],
        ),
      ],
    ) ;
  }
}
