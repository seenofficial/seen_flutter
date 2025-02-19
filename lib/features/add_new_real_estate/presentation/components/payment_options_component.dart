import 'package:flutter/material.dart';
import '../../../../../configuration/managers/color_manager.dart';
import '../../../../../configuration/managers/font_manager.dart';
import '../../../../../configuration/managers/style_manager.dart';
import '../../../../../core/components/custom_app_drop_down.dart';
import '../../../../configuration/managers/drop_down_style_manager.dart';
import 'form_widget_component.dart';

class PaymentOptionsComponent extends StatelessWidget {
  const PaymentOptionsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return FormWidgetComponent(
      label: 'خيارات الدفع  ',
      content: Row(
        children: [
          Expanded(
            child: CustomDropdown<String>(
              items: ['caaa', 'ssafsafas'],
              onChanged: (value) {},
              itemToString: (item) => item,
              hint: Text(' ', style: TextStyle(fontSize: FontSize.s12)),
              icon: Icon(Icons.keyboard_arrow_down, color: ColorManager.greyShade),
              decoration: DropdownStyles.getDropdownDecoration(),
              dropdownColor: ColorManager.whiteColor,
              menuMaxHeight: 200,
              style: getMediumStyle(
                color: ColorManager.blackColor,
                fontSize: FontSize.s14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}