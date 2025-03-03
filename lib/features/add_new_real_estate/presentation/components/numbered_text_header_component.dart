import 'package:enmaa/core/extensions/context_extension.dart';

import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/font_manager.dart';
import '../../../../configuration/managers/style_manager.dart';
import '../../../home_module/home_imports.dart';

class NumberedTextHeaderComponent extends StatelessWidget {
  final String number;
  final String text;

  const NumberedTextHeaderComponent({
    super.key,
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: context.scale(24),
          height: context.scale(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: getBoldStyle(
                color: ColorManager.primaryColor,
                fontSize: FontSize.s14,
              ),
            ),
          ),
        ),
        SizedBox(width: context.scale(8)),
        Text(
          text,
          style: getBoldStyle(
            color: ColorManager.blackColor,
            fontSize: FontSize.s16,
          ),
        ),
      ],
    );
  }
}