import 'package:enmaa/core/extensions/context_extension.dart';

import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/font_manager.dart';
import '../../../../configuration/managers/style_manager.dart';
import '../../../../core/components/svg_image_component.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/services/image_picker_service.dart';
import '../../../home_module/home_imports.dart';
import 'dashed_border_container.dart';
import 'form_widget_component.dart';

class SelectImagesComponent extends StatelessWidget {
  const SelectImagesComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return           FormWidgetComponent(
      label: 'إضافه صور العقار ',
      content: InkWell(
        onTap: () async {
          final imagePickerHelper = ImagePickerHelper();

          // Pick image from gallery
          final galleryImage = await imagePickerHelper.pickImages();
          if (galleryImage.isNotEmpty) {
            print('Gallery image picked: ${galleryImage}');
          }
        },
        child: DottedBorderContainer(
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
                style: getMediumStyle(
                    color: ColorManager.grey, fontSize: FontSize.s12),
              ),
            ],
          ),
        ),
      ),

    );

  }
}
