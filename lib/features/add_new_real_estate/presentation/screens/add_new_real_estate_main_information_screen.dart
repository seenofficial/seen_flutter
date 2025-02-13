import 'package:enmaa/configuration/managers/color_manager.dart';
import 'package:enmaa/configuration/managers/font_manager.dart';
import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/core/components/app_text_field.dart';
import 'package:enmaa/core/extensions/context_extension.dart';

import '../../../../core/components/button_app_component.dart';
import '../../../../core/components/circular_icon_button.dart';
import '../../../../core/components/custom_app_drop_down.dart';
import '../../../home_module/home_imports.dart';
import '../components/form_widget_component.dart';
import '../components/numbered_text_header_component.dart';

class AddNewRealEstateMainInformationScreen extends StatelessWidget {
  const AddNewRealEstateMainInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          NumberedTextHeaderComponent(
            number: '1',
            text: 'المعلومات الرئيسية',
          ),

          SizedBox(height: context.scale(20)),


          FormWidgetComponent(
            label: 'نوع العمليه',
            content: Row(
              children: [
                ButtonAppComponent(
                  width: 171,
                  height: 40,
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
                      ' بيع',
                      style: getBoldStyle(
                        color: ColorManager.primaryColor,
                        fontSize: FontSize.s12,
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
                SizedBox(width: context.scale(16)),
                ButtonAppComponent(
                  width: 171,
                  height: 40,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: ColorManager.whiteColor,
                    borderRadius: BorderRadius.circular(context.scale(24)),
                  ),
                  buttonContent: Center(
                    child: Text(
                      ' إيجار',
                      style: getMediumStyle(
                        color: ColorManager.primaryColor,
                        fontSize: FontSize.s12,
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),


          FormWidgetComponent(
            label: 'الفئة',
            content: CustomDropdown<String>(
              items: ['شقه', 'ss'],
              value: 'شقه',
              onChanged: (value) {
              },
              itemToString: (item) => item,
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


          FormWidgetComponent(
            label: 'النوع',
            content: CustomDropdown<String>(
              items: ['دوبلكس', 'ssafsafas'],
              value: 'دوبلكس',
              onChanged: (value) {
              },
              itemToString: (item) => item,
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

          FormWidgetComponent(
            label: 'المساحة ',
            content: AppTextField(

              height: 40,
              hintText: 'أدخل المساحة بالمتر المربع',
              keyboardType: TextInputType.number,
              backgroundColor: Colors.white,
              borderRadius: 20,
              padding: EdgeInsets.zero,
              onChanged: (value) {
                print('User input: $value');
              },
            ),
          ),


          FormWidgetComponent(
            label: 'الأثاث',
            content: Row(
              children: [
                ButtonAppComponent(
                  width: 171,
                  height: 40,
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
                      ' مفروش',
                      style: getBoldStyle(
                        color: ColorManager.primaryColor,
                        fontSize: FontSize.s12,
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
                SizedBox(width: context.scale(16)),
                ButtonAppComponent(
                  width: 171,
                  height: 40,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: ColorManager.whiteColor,
                    borderRadius: BorderRadius.circular(context.scale(24)),
                  ),
                  buttonContent: Center(
                    child: Text(
                      ' فارغ',
                      style: getMediumStyle(
                        color: ColorManager.primaryColor,
                        fontSize: FontSize.s12,
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),


          FormWidgetComponent(
            label: 'الطابق',
            content: CustomDropdown<String>(
              items: ['2', 'ssafsafas'],
              value: '2',
              onChanged: (value) {
              },
              itemToString: (item) => item,
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
          FormWidgetComponent(
            label: 'عدد الغرف',
            content: CustomDropdown<String>(
              items: ['4', 'ssafsafas'],
              value: '4',
              onChanged: (value) {
              },
              itemToString: (item) => item,
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

          FormWidgetComponent(
            label: 'عدد الحمامات',
            content: CustomDropdown<String>(
              items: ['2', 'ssafsafas'],
              value: '2',
              onChanged: (value) {
              },
              itemToString: (item) => item,
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
    );
  }
}
