import 'package:enmaa/core/extensions/context_extension.dart';

import '../../configuration/managers/color_manager.dart';
import '../../configuration/managers/font_manager.dart';
import '../../configuration/managers/style_manager.dart';
import '../../features/home_module/home_imports.dart';
import '../components/custom_app_drop_down.dart';

class SelectLocationScreen extends StatelessWidget {
  const SelectLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.scale(322),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('الدولة', context),
          SizedBox(height: context.scale(8)),
          CustomDropdown<String>(
            items: ['مصر', 'السعودية', ],
            value: 'مصر',
            onChanged: (value) {},
            itemToString: (item) => item,
            hint: Text(' مصر', style: TextStyle(fontSize: FontSize.s12)),
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
          SizedBox(height: context.scale(16)),

          _buildSectionTitle('المحافظة', context),
          SizedBox(height: context.scale(8)),
          CustomDropdown<String>(
            items:  ['القاهره'] ,
            value: 'القاهره',
            onChanged: (value) {},
            itemToString: (item) => item,
            hint: Text(' القاهره', style: TextStyle(fontSize: FontSize.s12)),
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
          SizedBox(height: context.scale(16)),


          _buildSectionTitle('المدينه', context),
          SizedBox(height: context.scale(8)),
          CustomDropdown<String>(
            items:  ['المعادي'],
            value: 'المعادي',
            onChanged: (value) {},
            itemToString: (item) => item,
            hint: Text(' المعادي', style: TextStyle(fontSize: FontSize.s12)),
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
          SizedBox(height: context.scale(20)),

          SizedBox(
            width: double.infinity,
            height: context.scale(48),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primaryColor,
                foregroundColor: Colors.white,
              ),
              child: Text('ادخل الموقع ' , style: getBoldStyle(color: ColorManager.whiteColor ,fontSize: FontSize.s12),),

            ),
          ),

        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Text(
      title,
      style: getBoldStyle(color: ColorManager.blackColor, fontSize: FontSize.s12),
    );
  }
}
