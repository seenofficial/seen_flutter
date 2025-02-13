import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/core/components/svg_image_component.dart';
import 'package:enmaa/core/constants/app_assets.dart';
import 'package:enmaa/core/extensions/context_extension.dart';

import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/font_manager.dart';
import '../../../../core/components/app_text_field.dart';
import '../../../../core/services/image_picker_service.dart';
import '../../../home_module/home_imports.dart';
import '../components/dashed_border_container.dart';
import '../components/form_widget_component.dart';
import '../components/numbered_text_header_component.dart';

class AddNewRealEstatePriceScreen extends StatelessWidget {
  const AddNewRealEstatePriceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NumberedTextHeaderComponent(
            number: '2',
            text: 'السعر والوصف ',
          ),
          SizedBox(height: context.scale(20)),

          // address form
          FormWidgetComponent(
            label: 'العنوان ',
            content: AppTextField(

              height: 40,
              hintText: 'أدخل عنوانًا مختصرًا للعقار.',
              keyboardType: TextInputType.number,
              backgroundColor: Colors.white,
              borderRadius: 20,
              padding: EdgeInsets.zero,
              onChanged: (value) {
                print('User input: $value');
              },
            ),
          ),

          // description form
          FormWidgetComponent(
        label: 'الوصف',
        content: AppTextField(
          height: 90,
          hintText: 'أدخل وصفًا تفصيليًا للعقار ...',
          keyboardType: TextInputType.multiline, // Allows multiline input
          backgroundColor: Colors.white,
          borderRadius: 20,
          padding: EdgeInsets.zero,
          maxLines: null, // Allows unlimited lines
          onChanged: (value) {
            print('User input: $value');
          },
        ),
      ),

          // price form
          FormWidgetComponent(
            label: 'السعر ',
            content: AppTextField(

              height: 40,
              hintText: '..',
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
            label: 'إضافه صور العقار ',
            content: InkWell(
              onTap: ()async{
                final imagePickerHelper = ImagePickerHelper();

                // Pick image from gallery
                final galleryImage = await imagePickerHelper.pickImages();
                if (galleryImage.isNotEmpty ) {
                  print('Gallery image picked: ${galleryImage}');
                }


              },
              child: DottedBorderContainer (
                width: 358,
                height: 108,
                borderRadius: 12,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SvgImageComponent(
                      iconPath: AppAssets.folderIcon,
                      width: 16,
                      height: 16,
                    ),
                    SizedBox(width: context.scale(8)),
                    Text(
                      'قم برفع صور واضحة للعقار لإبراز مميزاته بحد أقصى 5MB لكل صورة',
                      textAlign: TextAlign.center,
                      style: getMediumStyle(color: ColorManager.grey , fontSize: FontSize.s12),
                    ),
                  ],
                ),
              ),
            ),

          ),



        ],
      ),
    );

  }
}
