import 'package:enmaa/core/constants/app_assets.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/core/extensions/request_states_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/font_manager.dart';
import '../../../../configuration/managers/style_manager.dart';
import '../../../../configuration/managers/value_manager.dart';
import '../../../../core/components/reusable_type_selector_component.dart';
import '../../../../core/components/svg_image_component.dart';
import '../../../add_new_real_estate/presentation/components/numbered_text_header_component.dart';
import '../../../add_new_real_estate/presentation/components/select_images_component.dart';
import '../../../home_module/home_imports.dart';
import '../controller/book_property_cubit.dart';

class BuyerDataScreen extends StatelessWidget {
  const BuyerDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.all(AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const NumberedTextHeaderComponent(
              number: '٢',
              text: ' بيانات المُشتري',
            ),
            SizedBox(height: context.scale(20)),
            TypeSelectorComponent<String>(
              selectorWidth: 171,
              values: ['أنا المُشتري', ' مُشتري آخر'],
              currentType: 'أنا المُشتري',
              onTap: (type) {},
              getIcon: (type) {
                switch (type) {
                  case 'أنا المُشتري':
                    return AppAssets.emptyIcon;
                  case 'مُشتري آخر':
                    return AppAssets.emptyIcon;
                  default:
                    return AppAssets.emptyIcon;
                }
              },
              getLabel: (type) => type,
            ),
            SizedBox(height: context.scale(20)),
            Text(
              'بياناتك',
              style: getBoldStyle(
                  color: ColorManager.blackColor, fontSize: FontSize.s16),
            ),
            SizedBox(height: context.scale(20)),
            Container(
              width: double.infinity,
              height: context.scale(100),
              decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(AppPadding.p16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgImageComponent(
                        width: 20,
                          height: 20,
                          iconPath: AppAssets.cardIdentityIcon),
                      SizedBox(width: context.scale(8)),
                      Text(
                        'الاسم الكامل  : ',
                        style: getSemiBoldStyle(
                          color: ColorManager.blackColor,
                          fontSize: FontSize.s14,
                        ),
                      ),
                      Text(
                        'مصعب الشنقيطي',
                        style: getBoldStyle(
                          color: ColorManager.blackColor,
                          fontSize: FontSize.s16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgImageComponent(
                          width: 20,
                          height: 20,
                          iconPath: AppAssets.phoneIcon),
                      SizedBox(width: context.scale(8)),
                      Text(
                        'رقم الموبايل   : ',
                        style: getSemiBoldStyle(
                          color: ColorManager.blackColor,
                          fontSize: FontSize.s14,
                        ),
                      ),
                      Text(
                        '01005734569',
                        style: getBoldStyle(
                          color: ColorManager.blackColor,
                          fontSize: FontSize.s16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: context.scale(20)),
            BlocBuilder<BookPropertyCubit, BookPropertyState>(
              builder: (context, state) {
                final cubit = context.read<BookPropertyCubit>();
                return SelectImagesComponent(
                  height: 124,
                  selectedImages: state.selectedImages,
                  isLoading: state.selectImagesState.isLoading,
                  validateImages: state.validateImages,
                  hintText: 'يرجى رفع صور واضحة لهويتك لضمان التحقق السريع.',
                  onSelectImages: ()async {
                    cubit.selectImage(1);
                  },
                  onRemoveImage: cubit.removeImage,
                  onValidateImages: cubit.validateImages,
                  mode: ImageSelectionMode.single,
                );
              },
            ),
          ],
        ));
  }
}
