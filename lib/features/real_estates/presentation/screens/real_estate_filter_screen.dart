import 'package:enmaa/configuration/managers/color_manager.dart';
import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/core/components/svg_image_component.dart';
import 'package:enmaa/core/constants/app_assets.dart';
import 'package:enmaa/core/extensions/context_extension.dart';

import '../../../../configuration/managers/font_manager.dart';
import '../../../../core/components/app_text_field.dart';
import '../../../../core/components/button_app_component.dart';
import '../../../../core/components/custom_app_drop_down.dart';
import '../../../../core/components/range_slider_with_text_fields_component.dart';
import '../../../home_module/home_imports.dart';

class RealEstateFilterScreen extends StatelessWidget {
  const RealEstateFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height - context.scale(120) ,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTransactionTypeButtons(context),
                  SizedBox(height: context.scale(20)),
                  _buildSectionTitle('فئة العقار', context),
                  SizedBox(height: context.scale(12)),
                  _buildPropertyCategoryButtons(context),
                  SizedBox(height: context.scale(20)),
                  _buildSectionTitle('نوع العقار', context),
                  SizedBox(height: context.scale(12)),
                  _buildPropertyTypeButtons(context),
                  SizedBox(height: context.scale(20)),
                  _buildSectionTitle('الأثاث', context),
                  SizedBox(height: context.scale(12)),
                  _buildFurnitureButtons(context),
                  SizedBox(height: context.scale(20)),
                  _buildSectionTitle('حدد الموقع', context),
                  SizedBox(height: context.scale(12)),
                  _buildLocationField(context),
                  SizedBox(height: context.scale(20)),
                  _buildSectionTitle('اختر المحافظة والمدينة', context),
                  SizedBox(height: context.scale(12)),
                  _buildProvinceAndCityDropdowns(context),
                  SizedBox(height: context.scale(20)),
                  _buildSectionTitle('الطابق', context),
                  SizedBox(height: context.scale(12)),
                  _buildFloorDropdown(context),
                  SizedBox(height: context.scale(20)),
                  _buildSectionTitle('عدد الغرف', context),
                  SizedBox(height: context.scale(12)),
                  _buildRoomsDropdown(context),
                  SizedBox(height: context.scale(20)),
                  _buildSectionTitle('عدد الحمامات', context),
                  SizedBox(height: context.scale(12)),
                  _buildBathroomsDropdown(context),
                  SizedBox(height: context.scale(20)),
                  _buildSectionTitle('السعر', context),
                  SizedBox(height: context.scale(12)),
                  _buildPriceRangeSlider(context),
                  SizedBox(height: context.scale(20)),
                  _buildSectionTitle('المساحة', context),
                  SizedBox(height: context.scale(12)),
                  _buildAreaRangeSlider(context),
                  SizedBox(height: context.scale(40)),
                  _buildActionButtons(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: context.scale(92),
            height: context.scale(4),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('التصفية', style: getBoldStyle(color: ColorManager.blackColor)),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTransactionTypeButtons(BuildContext context) {
    return Row(
      children: [
        ButtonAppComponent(
          width: 163,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgImageComponent(iconPath: AppAssets.forSellIcon, width: 16, height: 16),
                const SizedBox(width: 3),
                Text(
                  ' بيع',
                  style: getBoldStyle(
                    color: ColorManager.primaryColor,
                    fontSize: FontSize.s12,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {},
        ),
        SizedBox(width: context.scale(16)),
        ButtonAppComponent(
          width: 163,
          height: 40,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: ColorManager.whiteColor,
            borderRadius: BorderRadius.circular(context.scale(24)),
          ),
          buttonContent: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgImageComponent(iconPath: AppAssets.rentIcon, color: ColorManager.primaryColor, width: 16, height: 16),
                const SizedBox(width: 3),
                Text(
                  ' إيجار',
                  style: getMediumStyle(
                    color: ColorManager.primaryColor,
                    fontSize: FontSize.s12,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Text(
      title,
      style: getBoldStyle(color: ColorManager.blackColor, fontSize: FontSize.s12),
    );
  }

  Widget _buildPropertyCategoryButtons(BuildContext context) {
    return Row(
      children: [
        _buildPropertyCategoryButton(context, AppAssets.apartmentIcon, ' شقة'),
        SizedBox(width: context.scale(6)),
        _buildPropertyCategoryButton(context, AppAssets.villaIcon, ' فيلا', isSelected: true),
        SizedBox(width: context.scale(6)),
        _buildPropertyCategoryButton(context, AppAssets.residentialBuildingIcon, ' عمارة'),
        SizedBox(width: context.scale(6)),
        _buildPropertyCategoryButton(context, AppAssets.landIcon, ' أرض'),
      ],
    );
  }

  Widget _buildPropertyCategoryButton(BuildContext context, String iconPath, String label, {bool isSelected = false}) {
    return ButtonAppComponent(
      width: 80,
      height: 40,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(context.scale(24)),
        border: isSelected ? Border.all(color: ColorManager.primaryColor, width: 1) : null,
      ),
      buttonContent: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgImageComponent(iconPath: iconPath, width: 16, height: 16),
            const SizedBox(width: 3),
            Text(
              label,
              style: isSelected
                  ? getBoldStyle(color: ColorManager.primaryColor, fontSize: FontSize.s12)
                  : getMediumStyle(color: ColorManager.primaryColor, fontSize: FontSize.s12),
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }

  Widget _buildPropertyTypeButtons(BuildContext context) {
    return Row(
      children: [
        _buildPropertyTypeButton(context, AppAssets.independentPropertyIcon, ' مستقلة', isSelected: true),
        SizedBox(width: context.scale(6)),
        _buildPropertyTypeButton(context, AppAssets.twinHouseIcon, ' توين هاوس'),
        SizedBox(width: context.scale(6)),
        _buildPropertyTypeButton(context, AppAssets.townhouseIcon, ' تاون هاوس'),
      ],
    );
  }

  Widget _buildPropertyTypeButton(BuildContext context, String iconPath, String label, {bool isSelected = false}) {
    return ButtonAppComponent(
      width: 108,
      height: 40,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(context.scale(24)),
        border: isSelected ? Border.all(color: ColorManager.primaryColor, width: 1) : null,
      ),
      buttonContent: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgImageComponent(iconPath: iconPath, width: 16, height: 16),
            const SizedBox(width: 3),
            Text(
              label,
              style: isSelected
                  ? getBoldStyle(color: ColorManager.primaryColor, fontSize: FontSize.s12)
                  : getMediumStyle(color: ColorManager.primaryColor, fontSize: FontSize.s12),
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }

  Widget _buildFurnitureButtons(BuildContext context) {
    return Row(
      children: [
        _buildFurnitureButton(context, AppAssets.furnishedIcon, ' مفروش', isSelected: true),
        SizedBox(width: context.scale(16)),
        _buildFurnitureButton(context, AppAssets.emptyIcon, ' فارغ'),
      ],
    );
  }

  Widget _buildFurnitureButton(BuildContext context, String iconPath, String label, {bool isSelected = false}) {
    return ButtonAppComponent(
      width: 163,
      height: 40,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(context.scale(24)),
        border: isSelected ? Border.all(color: ColorManager.primaryColor, width: 1) : null,
      ),
      buttonContent: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgImageComponent(iconPath: iconPath, width: 16, height: 16),
            const SizedBox(width: 3),
            Text(
              label,
              style: isSelected
                  ? getBoldStyle(color: ColorManager.primaryColor, fontSize: FontSize.s12)
                  : getMediumStyle(color: ColorManager.primaryColor, fontSize: FontSize.s12),
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }

  Widget _buildLocationField(BuildContext context) {
    return AppTextField(
      height: 40,
      hintText: 'اختر الموقع',
      keyboardType: TextInputType.number,
      backgroundColor: Colors.white,
      borderRadius: 20,
      padding: EdgeInsets.zero,
      onChanged: (value) {
        print('User input: $value');
      },
    );
  }

  Widget _buildProvinceAndCityDropdowns(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomDropdown<String>(
            items: ['caaa', 'ssafsafas'],
            onChanged: (value) {},
            itemToString: (item) => item,
            hint: Text(' المحافظة', style: TextStyle(fontSize: FontSize.s12)),
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
            hint: Text('المدينة', style: TextStyle(fontSize: FontSize.s12)),
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
    );
  }

  Widget _buildFloorDropdown(BuildContext context) {
    return CustomDropdown<String>(
      items: ['1', '2'],
      onChanged: (value) {},
      itemToString: (item) => item,
      hint: Text(' 1', style: TextStyle(fontSize: FontSize.s12)),
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
    );
  }

  Widget _buildRoomsDropdown(BuildContext context) {
    return CustomDropdown<String>(
      items: ['1', '2'],
      onChanged: (value) {},
      itemToString: (item) => item,
      hint: Text(' 1', style: TextStyle(fontSize: FontSize.s12)),
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
    );
  }

  Widget _buildBathroomsDropdown(BuildContext context) {
    return CustomDropdown<String>(
      items: ['1', '2'],
      onChanged: (value) {},
      itemToString: (item) => item,
      hint: Text(' 1', style: TextStyle(fontSize: FontSize.s12)),
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
    );
  }

  Widget _buildPriceRangeSlider(BuildContext context) {
    return RangeSliderWithFields(
      minValue: 0,
      maxValue: 100,
      initialMinValue: 20,
      initialMaxValue: 80,
      unit: 'جنية',
    );
  }

  Widget _buildAreaRangeSlider(BuildContext context) {
    return RangeSliderWithFields(
      minValue: 0,
      maxValue: 100,
      initialMinValue: 20,
      initialMaxValue: 80,
      unit: 'م',
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: context.scale(163),
          height: context.scale(48),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFD6D8DB),
              foregroundColor: Color(0xFFD6D8DB),
            ),
            child: Text(
              'الغاء الكل',
              style: TextStyle(color: ColorManager.blackColor),
            ),
          ),
        ),
        SizedBox(
          width: context.scale(163),
          height: context.scale(48),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: Text('عرض النتائج'),
          ),
        ),
      ],
    );
  }
}