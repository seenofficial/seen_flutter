import 'package:enmaa/core/components/svg_image_component.dart';
import 'package:enmaa/core/constants/app_assets.dart';
import 'package:enmaa/core/extensions/context_extension.dart';

import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/font_manager.dart';
import '../../../../configuration/managers/style_manager.dart';
import '../../../../core/components/app_text_field.dart';
import '../../../../core/components/custom_app_drop_down.dart';
import '../../../home_module/home_imports.dart';
import '../components/form_widget_component.dart';
import '../components/numbered_text_header_component.dart';

class AddNewRealEstateLocationScreen extends StatelessWidget {
  const AddNewRealEstateLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NumberedTextHeaderComponent(
            number: '3',
            text: ' الموقع والمميزات',
          ),
          SizedBox(height: context.scale(20)),
          // address form
          FormWidgetComponent(
            label: 'حدد الموقع ',
            content: AppTextField(
              height: 40,
              hintText: 'اختر الموقع',
              keyboardType: TextInputType.number,
              
              backgroundColor: Colors.white,
              borderRadius: 20,
              padding: EdgeInsets.zero,
              onChanged: (value) {
                print('User input: $value');
              },
            ),
          ),

          // choose city
          FormWidgetComponent(
            label: 'اختر المحافظة والمدينة ',
            content: Row(
              children: [
                Expanded(
                  child: CustomDropdown<String>(
                    items: ['caaa', 'ssafsafas'],
                    onChanged: (value) {},
                    itemToString: (item) => item,
                    hint: Text(' المحافظة' , style: TextStyle(fontSize: FontSize.s12),),
                    icon: Icon(Icons.keyboard_arrow_down, color: ColorManager.greyShade),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ColorManager.whiteColor,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    dropdownColor: ColorManager.whiteColor,
                    menuMaxHeight: 200,
                    style: getMediumStyle(
                      color: ColorManager.blackColor,
                      fontSize: FontSize.s14,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CustomDropdown<String>(
                    items: ['asdsa', 'ssafsafas'],
                    onChanged: (value) {},
                    itemToString: (item) => item,
                    hint: Text('المدينة' , style: TextStyle(fontSize: FontSize.s12),),
                    icon: Icon(Icons.keyboard_arrow_down, color: ColorManager.greyShade),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ColorManager.whiteColor,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
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
          ),



        ],
      ),
    );
  }
}



